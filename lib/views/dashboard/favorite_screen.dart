import 'package:flutter/material.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/utils/app_data_provider.dart';
import 'package:frontend_bisarj/views/detail/details_screes.dart';
import '../../components/app_button.dart';
import '../../model/charging_station_model.dart';
import '../../utils/app_commons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late AnimationController controller;
  bool isLoading = false;

  List<ChargingStationModel> favoriteChargingStation =
      favoriteStationListData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        title: 'Saved',
        onTap: () {
          //
        },
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.only(left: 8, right: 8),
          itemCount: favoriteChargingStation.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (_, index) {
            ChargingStationModel data = favoriteChargingStation[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: MediaQuery.of(context).size.width * 0.8,
                duration: const Duration(milliseconds: 375),
                child: Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              data.stationName ?? '',
                              style: BoldTextStyle(size: 16),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.near_me,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        data.stationAddress ?? '',
                        style: SecondaryTextStyle(),
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
                      SizedBox(height: 10),
                      Divider(height: 0),
                      SizedBox(height: 8),
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
                                      data.chargerModel![index].chargerImage!,
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
                      SizedBox(height: 8),
                      Divider(height: 0),
                      SizedBox(height: 10),
                      AppButton(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        backgroundColor: primaryColor,
                        text: 'View',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  DetailScrees(chargingStationData: data),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
