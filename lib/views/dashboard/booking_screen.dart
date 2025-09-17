import 'package:flutter/material.dart';
import 'package:frontend_bisarj/views/booking/accepet_widget.dart';
import 'package:frontend_bisarj/views/booking/canceled_widget.dart';
import 'package:frontend_bisarj/views/booking/completed_widget.dart';
import 'package:frontend_bisarj/views/booking/request_widget.dart';
import 'package:frontend_bisarj/views/booking/upcoming_widget.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_commons.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          shape: Border(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.3)),
          ),
          automaticallyImplyLeading: false,
          title: Row(
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
              Text('My Booking', style: BoldTextStyle(size: 16)),
            ],
          ),
          bottom: TabBar(
            tabAlignment: TabAlignment.start,
            labelColor: primaryColor,
            labelStyle: BoldTextStyle(),
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: primaryColor,
            isScrollable: true,
            padding: EdgeInsets.zero,
            onTap: (value) {
              //
            },
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Requested'),
              Tab(text: 'Accepted'),
              Tab(text: 'Completed'),
              Tab(text: 'Canceled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UpcomingWidget(),
            RequestWidget(),
            AcceptedWidget(),
            CompletedWidget(),
            CanceledWidget(),
          ],
        ),
      ),
    );
  }
}
