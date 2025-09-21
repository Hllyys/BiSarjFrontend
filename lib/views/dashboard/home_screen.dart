import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:latlong2/latlong.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:frontend_bisarj/components/app_button.dart';
import 'package:frontend_bisarj/utils/app_assets.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import '../../model/charging_station_model.dart';
import '../../utils/app_commons.dart';
import 'package:frontend_bisarj/graphql/mutations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // UI flags
  bool isChange = false; // map/list toggle
  bool isChange1 = false; // fab visibility helper
  bool isMarker = false; // bottom pager visibility

  // Backend docs
  List<Map<String, dynamic>> stationDocs = [];

  // Eğer başka yerlerde kullanıyorsan; mock kapalı
  List<ChargingStationModel> chargingStationList = [];

  // Map
  final fm.MapController mapController = fm.MapController();
  final List<fm.Marker> markers = [];

  LatLng initialCenter = const LatLng(41.015137, 28.979530); // İstanbul
  double initialZoom = 6.0;
  LatLng currentLocation = const LatLng(41.015137, 28.979530);

  // Optional marker icon
  Uint8List? availableIconBytes;

  // fetch once
  bool _fetched = false;

  @override
  void initState() {
    super.initState();
    _loadMarkerIcons();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_fetched) {
      _fetched = true;
      _fetchStations();
    }
  }

  //Payload GraphQL `location` dizisi [lat, lng] geliyor.
  LatLng latLngFromPayload(List<dynamic> loc) {
    final lat = (loc[0] as num).toDouble();
    final lng = (loc[1] as num).toDouble();
    return LatLng(lat, lng);
  }

  Future<void> _loadMarkerIcons() async {
    try {
      final d1 = await rootBundle.load(ic_ev_station_available);
      final c1 = await ui.instantiateImageCodec(
        d1.buffer.asUint8List(),
        targetWidth: 100,
      );
      final f1 = await c1.getNextFrame();
      availableIconBytes = (await f1.image.toByteData(
        format: ui.ImageByteFormat.png,
      ))!.buffer.asUint8List();
      setState(() {});
    } catch (_) {}
  }

  Future<void> _fetchStations() async {
    final client = GraphQLProvider.of(context).value;

    final res = await client.query(
      QueryOptions(
        document: gql(listChargeStationsQuery),
        variables: {'locale': 'tr', 'limit': 200},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (res.hasException) {
      debugPrint('linkException: ${res.exception?.linkException}');
      for (final e in res.exception!.graphqlErrors) {
        debugPrint('graphqlError: ${e.message}');
      }
      return;
    }

    final data = res.data?['Charge_stations'];
    final docs = (data?['docs'] ?? []) as List;

    stationDocs = docs.cast<Map<String, dynamic>>();

    // Markerları doldur (location = [lat, lng])
    markers
      ..clear()
      ..addAll(
        stationDocs.map((doc) {
          final point = latLngFromPayload(doc['location'] as List);
          return fm.Marker(
            point: point,
            width: 40,
            height: 40,
            alignment: Alignment.topCenter,
            child: Tooltip(
              message: (doc['name'] ?? 'Station').toString(),
              child: availableIconBytes != null
                  ? Image.memory(availableIconBytes!, width: 40, height: 40)
                  : const Icon(Icons.ev_station, size: 40, color: Colors.green),
            ),
          );
        }),
      );

    if (markers.isNotEmpty) {
      initialCenter = markers.first.point;
    }

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
                  child: const Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    isChange = false;
                    isMarker = true;
                    isChange1 = true;
                    setState(() {});
                  },
                ),
                const SizedBox(width: 8),
                FloatingActionButton.small(
                  heroTag: 'zoomIn',
                  backgroundColor: primaryColor,
                  child: const Icon(Icons.zoom_in, color: Colors.white),
                  onPressed: () {
                    // yakınlaştırma işlemi  eklenecek
                  },
                ),
                const SizedBox(width: 8),
                FloatingActionButton.small(
                  heroTag: 'btn2',
                  backgroundColor: primaryColor,
                  child: Icon(
                    isChange ? Icons.list : Icons.map_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
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
        fm.FlutterMap(
          mapController: mapController,
          options: fm.MapOptions(
            initialCenter: initialCenter,
            initialZoom: initialZoom,
            minZoom: 2,
            maxZoom: 19,
          ),
          children: [
            fm.TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.frontend_bisarj',
            ),
            fm.MarkerLayer(markers: markers),
          ],
        ),

        if (isMarker) _bottomPager(),
      ],
    );
  }

  Widget _bottomPager() {
    if (stationDocs.isEmpty) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.small(
                heroTag: 'btn1',
                backgroundColor: primaryColor,
                child: const Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  isChange1 = false;
                  isMarker = false;
                  setState(() {});
                },
              ),
              const SizedBox(width: 8),
              FloatingActionButton.small(
                heroTag: 'btn2',
                backgroundColor: primaryColor,
                child: const Icon(Icons.map_outlined, color: Colors.white),
                onPressed: () {
                  isChange1 = false;
                  isMarker = false;
                  setState(() {});
                },
              ),
              const SizedBox(width: 8),
              FloatingActionButton.small(
                heroTag: 'btn3',
                backgroundColor: primaryColor,
                child: const Icon(
                  Icons.my_location_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  isChange = false;
                  isMarker = false;
                  isChange1 = false;
                  mapController.move(currentLocation, 12);
                  markers.add(
                    fm.Marker(
                      point: currentLocation,
                      width: 40,
                      height: 40,
                      alignment: Alignment.topCenter,
                      child: const Icon(
                        Icons.location_pin,
                        size: 40,
                        color: Colors.green,
                      ),
                    ),
                  );
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 300,
          child: PageView.builder(
            itemCount: stationDocs.length,
            controller: PageController(initialPage: 0, keepPage: true),
            onPageChanged: (val) {
              final p = latLngFromPayload(stationDocs[val]['location'] as List);
              mapController.move(p, 12);
            },
            itemBuilder: (_, index) {
              final d = stationDocs[index];
              final name = (d['name'] ?? '') as String;
              final company = (d['company']?['name'] ?? '') as String;
              final p = latLngFromPayload(d['location'] as List);

              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: BoldTextStyle(size: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 16),
                        inkWellWidget(
                          onTap: () => mapDirection(
                            latitude: p.latitude,
                            longitude: p.longitude,
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              Icons.near_me,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      company,
                      style: SecondaryTextStyle(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Text(
                            'Available',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey,
                          size: 15,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${p.latitude.toStringAsFixed(5)}, ${p.longitude.toStringAsFixed(5)}',
                          style: PrimaryTextStyle(),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 4,
                            ),
                            backgroundColor: primaryColor,
                            text: 'View',
                            onPressed: () {
                              Navigator.pop(context);
                              mapDirection(
                                latitude: p.latitude,
                                longitude: p.longitude,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AppButton(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 4,
                            ),
                            text: 'Book',
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget listWidget() {
    final items = stationDocs;
    return AnimationLimiter(
      child: ListView.separated(
        separatorBuilder: (_, __) => const Divider(),
        padding: const EdgeInsets.only(
          top: 50,
          left: 16,
          right: 16,
          bottom: 16,
        ),
        itemCount: items.length,
        itemBuilder: (_, index) {
          final d = items[index];
          final name = (d['name'] ?? '') as String;
          final company = (d['company']?['name'] ?? '') as String;
          final p = latLngFromPayload(d['location'] as List);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              child: inkWellWidget(
                onTap: () {
                  mapController.move(p, 12);
                  setState(() => isChange = false); // haritaya dön
                },
                child: FlipAnimation(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: availableIconBytes != null
                            ? Image.memory(
                                availableIconBytes!,
                                height: 40,
                                width: 40,
                              )
                            : const Icon(
                                Icons.ev_station,
                                size: 40,
                                color: Colors.green,
                              ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name, style: BoldTextStyle()),
                            const SizedBox(height: 4),
                            Text(company, style: SecondaryTextStyle(size: 12)),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 20),
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
