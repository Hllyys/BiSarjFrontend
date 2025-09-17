import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_bisarj/components/app_button.dart';
import 'package:frontend_bisarj/utils/app_assets.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/utils/app_data_provider.dart';
import '../../model/charging_station_model.dart';
import '../../utils/app_commons.dart';
import '../detail/details_screes.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  bool isChange = false;
  bool isChange1 = false;
  bool isMarker = false;

  String currentTitle = '';

  List<ChargingStationModel> chargingStationList = chargingStationListData();

  LatLng currentLocation = LatLng(31.1471, 75.3412);

  var marker = <Marker>[];

  int currentValue = 0;
  Completer<GoogleMapController> controllerGoogleMap =
      Completer<GoogleMapController>();
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(31.1471, 75.3412),
    zoom: 15.4746,
  );

  getCameraPosition({required double source, required double destination}) {
    return CameraPosition(target: LatLng(source, destination), zoom: 8);
  }

  @override
  void initState() {
    cameraPosition = CameraPosition(
      target: LatLng(31.1471, 75.3412),
      zoom: 4.0,
    );
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getBytesFromAsset();
    });
  }

  void getBytesFromAsset() async {
    /// For available
    ByteData data = await rootBundle.load(ic_ev_station_available);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: 100,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    var availableIcon = (await fi.image.toByteData(
      format: ui.ImageByteFormat.png,
    ))!.buffer.asUint8List();

    /// For Unavailable
    ByteData data2 = await rootBundle.load(ic_ev_station_unavailable);
    ui.Codec codec2 = await ui.instantiateImageCodec(
      data2.buffer.asUint8List(),
      targetWidth: 100,
    );
    ui.FrameInfo fi2 = await codec2.getNextFrame();
    var unavailableIcon = (await fi2.image.toByteData(
      format: ui.ImageByteFormat.png,
    ))!.buffer.asUint8List();
    chargingStationList.forEach((data) {
      int index = chargingStationList.indexOf(data);
      marker.add(
        Marker(
          onTap: () {
            //
          },
          markerId: MarkerId(index.toString()),
          position: LatLng(
            data.stationLocation!.latitude,
            data.stationLocation!.longitude,
          ),
          infoWindow: InfoWindow(title: data.stationName ?? ''),
          icon: BitmapDescriptor.fromBytes(
            data.status == "Available" ? availableIcon : unavailableIcon,
          ),
        ),
      );
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isChange ? mapWidget() : listWidget(),
      floatingActionButton: !isChange1
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton.small(
                  heroTag: 'btn1',
                  backgroundColor: primaryColor,
                  child: Icon(Icons.location_on_outlined, color: Colors.white),
                  onPressed: () async {
                    isChange = false;
                    isMarker = true;
                    isChange1 = true;
                    setState(() {});
                  },
                ),
                SizedBox(width: 8),
                FloatingActionButton.small(
                  heroTag: 'btn2',
                  backgroundColor: primaryColor,
                  child: Icon(
                    isChange ? Icons.list : Icons.map_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    isChange = !isChange;
                    setState(() {});
                  },
                ),
              ],
            )
          : null,
    );
  }

  Widget mapWidget() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GoogleMap(
          initialCameraPosition: cameraPosition,
          markers: Set<Marker>.of(marker),
          onTap: (val) {
            print(val.longitude);
          },
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          myLocationButtonEnabled: false,
          onMapCreated: (GoogleMapController con) async {
            if (controllerGoogleMap.isCompleted) {
              controllerGoogleMap = Completer<GoogleMapController>();
              await Future.delayed(Duration.zero);
              controllerGoogleMap.complete(con);
            } else {
              controllerGoogleMap.complete(con);
            }
          },
        ),
        if (isMarker)
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton.small(
                      heroTag: 'btn1',
                      backgroundColor: primaryColor,
                      child: Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        isChange1 = false;
                        isMarker = false;
                        setState(() {});
                      },
                    ),
                    SizedBox(width: 8),
                    FloatingActionButton.small(
                      heroTag: 'btn2',
                      backgroundColor: primaryColor,
                      child: Icon(
                        isChange ? Icons.list : Icons.map_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        isChange1 = false;
                        isMarker = false;
                        setState(() {});
                      },
                    ),
                    SizedBox(width: 8),
                    FloatingActionButton.small(
                      heroTag: 'btn3',
                      backgroundColor: primaryColor,
                      child: const Icon(
                        Icons.my_location_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        isChange = false;
                        isMarker = false;
                        isChange1 = false;

                        final GoogleMapController con =
                            await controllerGoogleMap.future;

                        con.animateCamera(
                          CameraUpdate.newCameraPosition(
                            getCameraPosition(
                              source: currentLocation.latitude,
                              destination: currentLocation.longitude,
                            ),
                          ),
                        );

                        marker.add(
                          Marker(
                            onTap: () {
                              //
                            },
                            markerId: MarkerId('1'),
                            position: LatLng(
                              currentLocation.latitude,
                              currentLocation.longitude,
                            ),
                            infoWindow: InfoWindow(title: 'Current Location'),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueGreen,
                            ),
                          ),
                        );
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 300,
                child: PageView.builder(
                  itemCount: chargingStationList.length,
                  itemBuilder: (_, index) {
                    ChargingStationModel data = chargingStationList[index];
                    return Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  data.stationName ?? '',
                                  style: BoldTextStyle(size: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 16),
                              inkWellWidget(
                                onTap: () {
                                  mapDirection(
                                    latitude: data.stationLocation!.latitude,
                                    longitude: data.stationLocation!.longitude,
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.near_me,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            data.stationAddress ?? '',
                            style: SecondaryTextStyle(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                data.avgReviewCount ?? '',
                                style: BoldTextStyle(),
                              ),
                              SizedBox(width: 8),
                              Row(
                                children: List.generate(5, (index) {
                                  return Padding(
                                    padding: EdgeInsets.only(left: 2, right: 2),
                                    child: Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 15,
                                    ),
                                  );
                                }),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '(${data.totalReview} reviews)',
                                style: PrimaryTextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: data.status == 'Available'
                                      ? primaryColor
                                      : Colors.red,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  data.status ?? '',
                                  style: PrimaryTextStyle(
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.grey,
                                size: 15,
                              ),
                              SizedBox(width: 8),
                              Text(
                                data.avgReviewCount ?? '',
                                style: PrimaryTextStyle(),
                              ),
                              SizedBox(width: 16),
                              Icon(
                                Icons.directions_car,
                                color: Colors.grey,
                                size: 15,
                              ),
                              SizedBox(width: 8),
                              Text('5 mins', style: PrimaryTextStyle()),
                            ],
                          ),
                          SizedBox(height: 8),
                          Divider(),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: List.generate(
                                    data.chargerModel!.length,
                                    (_) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          left: 4,
                                          right: 4,
                                        ),
                                        child: Image.asset(
                                          data
                                              .chargerModel![index]
                                              .chargerImage!,
                                          height: 30,
                                          width: 30,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Text(
                                '${data.chargerModel!.length} Charger',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: AppButton(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 4,
                                  ),
                                  backgroundColor: primaryColor,
                                  text: 'View',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => DetailScrees(
                                          chargingStationData: data,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: AppButton(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 4,
                                  ),
                                  text: 'Book',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => DetailScrees(
                                          chargingStationData: data,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  controller: PageController(
                    initialPage: chargingStationList.length,
                    keepPage: true,
                  ),
                  onPageChanged: (val) async {
                    currentValue = val;
                    final GoogleMapController con =
                        await controllerGoogleMap.future;

                    con.animateCamera(
                      CameraUpdate.newCameraPosition(
                        getCameraPosition(
                          source: chargingStationList[currentValue]
                              .stationLocation!
                              .latitude,
                          destination: chargingStationList[currentValue]
                              .stationLocation!
                              .longitude,
                        ),
                      ),
                    );
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget listWidget() {
    return AnimationLimiter(
      child: ListView.separated(
        separatorBuilder: (_, index) => Divider(),
        padding: EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
        itemCount: chargingStationList.length,
        itemBuilder: (_, index) {
          ChargingStationModel data = chargingStationList[index];

          return Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              child: inkWellWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScrees(chargingStationData: data),
                    ),
                  );
                },
                child: FlipAnimation(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          data.status == "Available"
                              ? ic_ev_station_available
                              : ic_ev_station_unavailable,
                          fit: BoxFit.cover,
                          height: 40,
                          width: 40,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.stationName ?? '',
                              style: BoldTextStyle(),
                            ),
                            SizedBox(height: 4),
                            Text(
                              data.stationAddress ?? '',
                              style: SecondaryTextStyle(size: 12),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
