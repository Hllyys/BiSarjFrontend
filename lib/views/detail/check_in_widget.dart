import 'package:flutter/material.dart';
import 'package:frontend_bisarj/components/app_button.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CheckInWidget extends StatefulWidget {
  final String? title;

  CheckInWidget({this.title});

  @override
  State<CheckInWidget> createState() => _CheckInWidgetState();
}

class _CheckInWidgetState extends State<CheckInWidget> {
  TextEditingController reviewController = TextEditingController();

  double rattingCount = 0.0;

  String? checkIn({String? name}) {
    if (name == 'Charging Now') {
      return 'charging_now';
    } else if (name == 'Waiting') {
      return 'waiting';
    } else if (name == 'Successfully Charged') {
      return 'successfully';
    } else if (name == 'Could Not Charge') {
      return 'could_not_charge';
    } else if (name == 'Leave a Comment') {
      return 'leave_comment';
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    reviewController.clear();
    rattingCount = 0;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  "Write a review for ${widget.title!}",
                  style: BoldTextStyle(size: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Divider(height: 0),
                SizedBox(height: 16),
                Text("Give it a star", style: BoldTextStyle()),
                SizedBox(height: 16),
                RatingBar.builder(
                  initialRating: rattingCount,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  glow: false,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) =>
                      Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    rattingCount = rating;
                    print(rating);
                  },
                ),
                SizedBox(height: 16),
                Divider(height: 0),
                SizedBox(height: 16),
              ],
            ),
            Text('Comments', style: BoldTextStyle(color: Colors.black54)),
            SizedBox(height: 16),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: BoldTextStyle(size: 14),
              controller: reviewController,
              decoration: inputDecoration(
                title: 'This is my favorite EV Charging stations',
              ),
              validator: fieldValidator,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8),
        child: AppButton(
          text: 'Submit',
          onPressed: () {
            Navigator.pop(context);
          },
          padding: EdgeInsets.all(8),
        ),
      ),
    );
  }
}
