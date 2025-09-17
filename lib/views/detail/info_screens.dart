import 'package:flutter/material.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';
import 'package:frontend_bisarj/utils/app_data_provider.dart';

import '../../model/charging_station_model.dart';
import '../../utils/app_assets.dart';

class InfoScreens extends StatefulWidget {
  InfoScreens({super.key});

  @override
  State<InfoScreens> createState() => _InfoScreensState();
}

class _InfoScreensState extends State<InfoScreens> {
  ChargingStationModel chargingStationModel = getChargingDetailData();

  bool isMore = false;

  List<String> image = [
    ic_lounge,
    ic_wifi,
    ic_television,
    ic_toilet,
    ic_medicine,
    ic_tools,
    ic_menu,
    ic_store
  ];

  List<String> name = [
    'Lounge',
    'Wi-Fi',
    'SnapSip',
    'Restrooms',
    'Pharmacy',
    'Maintenance',
    'Restaurant',
    'Shops'
  ];

  List<String> weekName = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('About', style: BoldTextStyle(size: 18)),
                SizedBox(height: 16),
                Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                  style: SecondaryTextStyle(),
                  maxLines: isMore ? 2 : null,
                  textAlign: TextAlign.justify,
                ),
                inkWellWidget(
                  onTap: () {
                    isMore = !isMore;
                    setState(() {});
                  },
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      !isMore ? ' Read less..' : ' Read more..',
                      style: PrimaryTextStyle(color: primaryColor),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Icon(Icons.watch_later_outlined, color: Colors.grey),
                            SizedBox(width: 10),
                            Text('Open', style: BoldTextStyle(color: primaryColor)),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text('24 hours', style: PrimaryTextStyle()),
                            ),
                            Icon(Icons.keyboard_arrow_down_outlined, color: Colors.grey)
                          ],
                        ),
                      ),
                      Divider(height: 0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                        child: Wrap(
                          runSpacing: 8,
                          children: List.generate(
                            weekName.length,
                            (index) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(weekName[index], style: PrimaryTextStyle(size: 14)),
                                Text('00:00 - 00:00', style: PrimaryTextStyle()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text('Amenities', style: BoldTextStyle(size: 20)),
                SizedBox(height: 8),
              ],
            ),
          ),
          if (chargingStationModel.amenities != null)
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 8),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  chargingStationModel.amenities!.length,
                  (index) {
                    AmenitiesModel data = chargingStationModel.amenities![index];
                    return Container(
                      width: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 8),
                              ],
                            ),
                            child: Image.asset(
                              data.image ?? '',
                              height: 25,
                              width: 25,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            data.name ?? '',
                            style: PrimaryTextStyle(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text('Location', style: BoldTextStyle(size: 20)),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on_outlined, color: primaryColor),
                    SizedBox(width: 8),
                    Text(chargingStationModel.stationAddress ?? '', style: PrimaryTextStyle()),
                  ],
                ),
                SizedBox(height: 8),
                if (chargingStationModel.stationLocation != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network('https://i.sstatic.net/HILmr.png'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
