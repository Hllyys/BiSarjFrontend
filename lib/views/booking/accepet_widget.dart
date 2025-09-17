import 'package:flutter/material.dart';
import 'package:frontend_bisarj/components/app_button.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';
import 'package:frontend_bisarj/utils/app_data_provider.dart';
import '../../model/booking_model.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'booking_detail.dart';

class AcceptedWidget extends StatefulWidget {
  const AcceptedWidget({super.key});

  @override
  State<AcceptedWidget> createState() => _AcceptedWidgetState();
}

class _AcceptedWidgetState extends State<AcceptedWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controllerDialog;

  late Animation<double> animation;

  bool isCheck = false;
  bool isLoading = false;

  List<BookingModel> bookingListModel = getUpComingList();

  @override
  void initState() {
    bookingListModel.shuffle();
    controllerDialog = BottomSheet.createAnimationController(this);
    controllerDialog.duration = Duration(milliseconds: 400);
    controllerDialog.reverseDuration = Duration(milliseconds: 400);
    controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controllerDialog.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        padding: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
        itemCount: bookingListModel.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          BookingModel data = bookingListModel[index];
          return inkWellWidget(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BookingDetail()),
              );
            },
            child: AnimationConfiguration.staggeredList(
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.createDate ?? '',
                                  style: PrimaryTextStyle(size: 14),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  data.time ?? '',
                                  style: PrimaryTextStyle(size: 14),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Accepted',
                              style: BoldTextStyle(
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(height: 0),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              data.stationName ?? '',
                              style: BoldTextStyle(size: 16),
                            ),
                          ),
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
                                size: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        data.stationAddress ?? '',
                        style: SecondaryTextStyle(),
                      ),
                      SizedBox(height: 10),
                      Divider(height: 0),
                      SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Plug', style: SecondaryTextStyle(size: 12)),
                              SizedBox(height: 4),
                              Image.asset(
                                data.chargerModel!.chargerImage ?? '',
                                height: 30,
                                width: 30,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                          SizedBox(width: 8),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.grey.shade200,
                          ),
                          SizedBox(width: 8),
                          BookingWidget(
                            title: 'Max.power',
                            subTitle:
                                '${data.chargerModel!.chargerMaxPower} kw',
                          ),
                          SizedBox(width: 8),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.grey.shade200,
                          ),
                          SizedBox(width: 8),
                          BookingWidget(
                            title: 'Duration',
                            subTitle: '${data.chargerModel!.totalHours} hours',
                          ),
                          SizedBox(width: 8),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.grey.shade200,
                          ),
                          SizedBox(width: 8),
                          BookingWidget(
                            title: 'Amount',
                            subTitle: '\$${data.totalAmount}',
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Divider(height: 0),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 8,
                              ),
                              backgroundColor: primaryColor,
                              text: 'Stop Charging',
                              onPressed: () {
                                showModalBottomSheet(
                                  transitionAnimationController: controller,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                  ),
                                  context: context,
                                  builder: (_) {
                                    return Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Stop Charging",
                                            style: BoldTextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          Divider(height: 0),
                                          SizedBox(height: 16),
                                          Text(
                                            "Are you sure you want to stop the\ncharging?",
                                            style: BoldTextStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 16),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: AppButton(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 8,
                                                    horizontal: 8,
                                                  ),
                                                  backgroundColor: primaryColor,
                                                  text: 'No, Don\'t Cancel',
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                              SizedBox(width: 16),
                                              Expanded(
                                                child: AppButton(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 8,
                                                    horizontal: 8,
                                                  ),
                                                  text: 'Yes, Cancel',
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 16),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: AppButton(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 8,
                              ),
                              text: 'View',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BookingDetail(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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

  Widget BookingWidget({String? title, String? subTitle}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(title!, style: SecondaryTextStyle(size: 12)),
          SizedBox(height: 8),
          Text(subTitle!, style: BoldTextStyle()),
        ],
      ),
    );
  }
}
