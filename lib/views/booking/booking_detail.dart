import 'package:flutter/material.dart';
import 'package:frontend_bisarj/components/app_button.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';
import 'package:frontend_bisarj/views/booking/cancel_booking_screen.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';

class BookingDetail extends StatefulWidget {
  const BookingDetail({super.key});

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controllerCancel;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controllerCancel = BottomSheet.createAnimationController(this);

    controller.duration = Duration(milliseconds: 400);
    controller.reverseDuration = Duration(milliseconds: 400);
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
        appBar: AppBar(title: Text('Booking Details', style: BoldTextStyle())),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Vehicle', style: BoldTextStyle()),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Image.asset(
                      ic_car_Detail,
                      height: 80,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 16),
                    Container(
                      height: 50,
                      width: 1,
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tesla', style: BoldTextStyle()),
                        SizedBox(height: 8),
                        Text('Model S . 40', style: SecondaryTextStyle()),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text('Charging Station', style: BoldTextStyle()),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.bolt, color: Colors.white, size: 25),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Walgreens - Brooklyn,  NY',
                          style: BoldTextStyle(size: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Brooklyn, 589 Prospect Avenue',
                          style: SecondaryTextStyle(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text('Charger', style: BoldTextStyle()),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tesla (Plug) . AC/DC', style: PrimaryTextStyle()),
                        SizedBox(height: 4),
                        Image.asset(
                          ic_ev_4,
                          height: 30,
                          width: 30,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    SizedBox(width: 16),
                    Container(
                      height: 50,
                      width: 1,
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Max.power', style: PrimaryTextStyle()),
                        SizedBox(height: 8),
                        Text('100kw', style: BoldTextStyle(size: 16)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Booking Date', style: PrimaryTextStyle()),
                        Text('Dec 17, 2024', style: BoldTextStyle()),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Time of Arrival', style: PrimaryTextStyle()),
                        Text('10:00 AM', style: BoldTextStyle()),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: primaryColor.withOpacity(0.1),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: primaryColor,
                      size: 15,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Your e-wallet will not be charged as long as you haven\'t charged it at the EV charging station.',
                        style: PrimaryTextStyle(color: primaryColor),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(16),
          child: AppButton(
            text: 'Cancel Booking',
            onPressed: () {
              showModalBottomSheet(
                transitionAnimationController: controllerCancel,
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
                          "Cancel Booking",
                          style: BoldTextStyle(color: Colors.red),
                        ),
                        SizedBox(height: 16),
                        Divider(height: 0),
                        SizedBox(height: 16),
                        Text(
                          "Are you sure you want to cancel the\nbooking?",
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CancelBookingScreen('10'),
                                    ),
                                  );
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
      ),
    );
  }
}
