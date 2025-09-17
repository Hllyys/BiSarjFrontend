import 'package:flutter/material.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';

import '../../components/app_button.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_commons.dart';
import '../vehicle/vehicle_screen.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Scaffold(
        appBar: AppBar(
          leading: backButton(context, onTap: () {
            Navigator.pop(context);
          }),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Complete your profile', style: BoldTextStyle(size: 20)),
                  SizedBox(width: 8),
                  Image.asset(ic_calendar, height: 20, width: 20, fit: BoxFit.cover),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Don\'t worry, only you can see your personal data. No one else will be able to see it.',
                style: PrimaryTextStyle(),
              ),
              SizedBox(height: 16),
              Center(
                child: ClipRRect(
                  child: Stack(
                    children: [
                      Image.asset(
                        ic_person,
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(defaultRadius)),
                          child: Icon(Icons.edit, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text('Full Name', style: BoldTextStyle()),
              SizedBox(height: 8),
              TextFormField(
                decoration: inputDecoration(hintText: 'Andew Ainsley'),
              ),
              SizedBox(height: 16),
              Text('Email', style: BoldTextStyle()),
              SizedBox(height: 8),
              TextFormField(
                decoration: inputDecoration(hintText: 'andew@gmail.com'),
              ),
              SizedBox(height: 16),
              Text('Gender', style: BoldTextStyle()),
              SizedBox(height: 8),
              TextFormField(
                decoration: inputDecoration(
                    suffixIcon:
                        Icon(Icons.keyboard_arrow_down_outlined, color: primaryColor, size: 25),
                    hintText: 'Male'),
              ),
              SizedBox(height: 16),
              Text('Date of Birth', style: BoldTextStyle()),
              SizedBox(height: 8),
              TextFormField(
                decoration: inputDecoration(
                    suffixIcon: Icon(Icons.calendar_month_outlined, color: primaryColor, size: 20),
                    hintText: '12/09/1998'),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(16),
          child: AppButton(
            text: 'Continue',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => VehicleScreen()));
            },
          ),
        ),
      ),
    );
  }
}
