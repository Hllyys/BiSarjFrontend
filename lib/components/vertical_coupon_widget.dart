import 'package:flutter/material.dart';
import 'package:frontend_bisarj/components/app_button.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';
import 'package:coupon_uikit/coupon_uikit.dart';

class VerticalCouponExample extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final num? totalAmount;

  const VerticalCouponExample({
    Key? key,
    this.title,
    this.onTap,
    this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CouponCard(
      height: 200,
      curveRadius: 30,
      borderRadius: 10,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      firstChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Available Balance',
            style: BoldTextStyle(color: Colors.white, size: 20),
          ),
          SizedBox(height: 10),
          AnimatedSize(
            curve: Curves.bounceIn,
            duration: Duration(seconds: 1),
            child: Text(
              '\$${totalAmount.toString()}',
              style: BoldTextStyle(color: Colors.white, size: 40),
            ),
          ),
        ],
      ),
      secondChild: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: AppButton(
          backColor: Colors.white,
          text: title,
          style: BoldTextStyle(size: 18),
          onPressed: onTap,
        ),
      ),
    );
  }
}
