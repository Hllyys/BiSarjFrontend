import 'package:flutter/material.dart';
import 'package:frontend_bisarj/model/check_in_model.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';
import '../../utils/app_assets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CheckInsScreens extends StatefulWidget {
  const CheckInsScreens({super.key});

  @override
  State<CheckInsScreens> createState() => _CheckInsScreensState();
}

class _CheckInsScreensState extends State<CheckInsScreens> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController reviewController = TextEditingController();

  double rattingCount = 0.0;
  List<CheckInModel> checkInDataList = [];

  String? checkIn({String? image}) {
    if (image == 'charging_now') {
      return ic_battery;
    } else if (image == 'waiting') {
      return ic_time;
    } else if (image == 'successfully') {
      return ic_message;
    } else if (image == 'could_not_charge') {
      return ic_speech_bubble;
    } else if (image == 'leave_comment') {
      return ic_messenger;
    }
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.separated(
        separatorBuilder: (_, __) => Divider(thickness: 0.5),
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(16),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (_, index) {
          //CheckInModel data = checkInDataList[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: FadeInAnimation(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(ic_messenger, height: 30, width: 30),
                        SizedBox(width: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(ic_person, height: 35, width: 35),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Jenny Wilson',
                                      style: BoldTextStyle(),
                                    ),
                                  ),
                                  Text(
                                    'Today',
                                    style: SecondaryTextStyle(size: 12),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Expanded(
                                    child: RatingBar.builder(
                                      initialRating: 4 ?? 2,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      glow: false,
                                      itemSize: 13,
                                      ignoreGestures: true,
                                      itemBuilder: (context, _) =>
                                          Icon(Icons.star, color: Colors.amber),
                                      onRatingUpdate: (rating) {
                                        //
                                      },
                                    ),
                                  ),
                                  Text(
                                    '07:20 AM',
                                    style: SecondaryTextStyle(size: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'This charging station is fast and efficient. got my Ev charger in to time! very easy to used. just tap and charge',
                      style: PrimaryTextStyle(size: 12),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
