import 'package:flutter/material.dart';
import 'package:frontend_bisarj/components/app_button.dart';
import 'package:frontend_bisarj/utils/app_assets.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';
import 'package:frontend_bisarj/views/authe/otp_verification_screen.dart';
import 'package:country_code_picker/country_code_picker.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool isCheck = false;

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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Hello there', style: BoldTextStyle(size: 20)),
                Image.asset(
                  ic_hand,
                  height: 30,
                  width: 30,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Please enter your phone number. You will\receive on OTP code in the next step for the\nverification process.',
              style: SecondaryTextStyle(),
            ),
            SizedBox(height: 30),
            Text('Phone Number', style: BoldTextStyle()),
            SizedBox(height: 16),
            TextFormField(
              decoration: inputDecoration(
                hintText: "12345-67890",
                prefixIcon: SizedBox(
                  height: 40,
                  child: CountryCodePicker(
                    padding: EdgeInsets.only(bottom: 2),
                    onChanged: print,
                    initialSelection: 'IN',
                    favorite: ['+91', 'IN'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  activeColor: primaryColor,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  value: isCheck,
                  onChanged: (val) {
                    isCheck = val!;
                    setState(() {});
                  },
                ),
                Expanded(
                  child: RichText(
                    text: new TextSpan(
                      text: 'I agree to EVPoint',
                      style: PrimaryTextStyle(size: 15),
                      children: <TextSpan>[
                        new TextSpan(
                          text: ' Public Agreement, Terms, Privacy Policy.',
                          style: BoldTextStyle(color: primaryColor, size: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
              MaterialPageRoute(builder: (_) => OtpVerificationScreen()),
            );
          },
        ),
      ),
    );
  }
}
