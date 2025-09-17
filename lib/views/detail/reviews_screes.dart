import 'package:flutter/material.dart';
import 'package:frontend_bisarj/utils/app_assets.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewsScrees extends StatefulWidget {
  const ReviewsScrees({super.key});

  @override
  State<ReviewsScrees> createState() => _ReviewsScreesState();
}

class _ReviewsScreesState extends State<ReviewsScrees> {
  TextEditingController reviewController = TextEditingController();

  double rattingCount = 0.0;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.separated(
        separatorBuilder: (_, __) => Divider(thickness: 0.5),
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(16),
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          //  ReviewModel data = reviewDataList[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              duration: Duration(milliseconds: 500),
              verticalOffset: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                                      'Darron Burress',
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RatingBar.builder(
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
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      '(${8})',
                                      style: PrimaryTextStyle(size: 12),
                                    ),
                                  ),
                                  Text(
                                    '18:35 PM',
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
                      'This station is well-lit and secure. which is important when charging my car at night',
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
