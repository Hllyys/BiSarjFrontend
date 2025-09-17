import 'package:flutter/material.dart';
import 'package:frontend_bisarj/components/app_button.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';

class ForgotPasswordScreens extends StatefulWidget {
  const ForgotPasswordScreens({super.key});

  @override
  State<ForgotPasswordScreens> createState() => _ForgotPasswordScreensState();
}

class _ForgotPasswordScreensState extends State<ForgotPasswordScreens> {
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(context, onTap: () {
          Navigator.pop(context);
        }),
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Text('Forgot Password?', style: BoldTextStyle(size: 20)),
              SizedBox(height: 16),
              Text(
                'Don\'t worry! Just fill in your email and we\'ll send a code to rest your password.',
                style: PrimaryTextStyle(size: 16),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16),
              Text('Email', style: BoldTextStyle(size: 16)),
              SizedBox(height: 8),
              TextFormField(
                controller: emailController,
                cursorColor: primaryColor,
                decoration: inputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: 24,
                    color: primaryColor,
                  ),
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(height: 30),
              AppButton(
                text: 'Send Code',
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
