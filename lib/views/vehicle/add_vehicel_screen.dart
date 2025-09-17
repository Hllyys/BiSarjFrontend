import 'package:flutter/material.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_commons.dart';
import 'package:lottie/lottie.dart';

class AddVehicelScreen extends StatefulWidget {
  const AddVehicelScreen({super.key});

  @override
  State<AddVehicelScreen> createState() => _AddVehicelScreenState();
}

class _AddVehicelScreenState extends State<AddVehicelScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Lottie.asset(
            ic_add_vehicle,
            height: 300,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 40),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            child: Column(
              children: [
                Text('Tesla', style: BoldTextStyle(size: 16)),
                Divider(),
                Text('Model S', style: BoldTextStyle(size: 16)),
                Divider(),
                Text('40', style: BoldTextStyle(size: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
