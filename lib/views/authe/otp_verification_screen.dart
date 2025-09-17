import 'package:flutter/material.dart';
import 'package:frontend_bisarj/components/app_button.dart';
import 'package:frontend_bisarj/utils/app_assets.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/views/authe/complete_profile_screen.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../utils/app_commons.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(
          context,
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('OTP code verification', style: BoldTextStyle(size: 20)),
                Image.asset(ic_lock, height: 40, width: 40, fit: BoxFit.cover),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'We have sent an OTP code to phone number\n*** *** *** **99.Enter the OTP code below to continue.',
              style: PrimaryTextStyle(),
            ),
            SizedBox(height: 60),
            OtpTextField(
              numberOfFields: 4,
              cursorColor: primaryColor,
              fillColor: Colors.grey.shade200,
              borderColor: primaryColor,
              enabledBorderColor: Colors.transparent,
              focusedBorderColor: primaryColor,
              filled: true,
              showFieldAsBox: false,
              fieldWidth: 60,
              borderWidth: 1,
              margin: EdgeInsets.symmetric(horizontal: 8),
              onCodeChanged: (String code) {
                //
              },
              onSubmit: (String verificationCode) {
                //
              },
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CompleteProfileScreen()),
                );
              },
              child: Center(
                child: RichText(
                  text: new TextSpan(
                    text: 'You can resend code in',
                    style: PrimaryTextStyle(),
                    children: <TextSpan>[
                      new TextSpan(
                        text: ' 00 : 59',
                        style: BoldTextStyle(color: primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: AppButton(
          text: 'Continue',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CompleteProfileScreen()),
            );
          },
        ),
      ),
    );
  }
}
