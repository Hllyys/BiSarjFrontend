import 'package:flutter/material.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';
import 'package:frontend_bisarj/views/dashboard/dashboard_screen.dart';
import 'package:frontend_bisarj/views/vehicle/add_brand/add_brand_screen.dart';

import '../../components/app_button.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_commons.dart';
import 'package:lottie/lottie.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 50, left: 16, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Personalize your', style: BoldTextStyle(size: 22)),
            SizedBox(height: 6),
            Text('experience by adding a', style: BoldTextStyle(size: 22)),
            Row(
              children: [
                Text('vehicle', style: BoldTextStyle(size: 22)),
                Image.asset(ic_car, height: 50, width: 50, fit: BoxFit.contain),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'your vehicle is used to determine compatible charging station',
              style: PrimaryTextStyle(),
            ),
            Lottie.asset(ic_add_vehicle, height: 300, fit: BoxFit.fill),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: AppButton(
                text: 'Add Later',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DashboardsScreen()),
                  );
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: AppButton(
                text: 'Add Vehicle',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddBrandScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
