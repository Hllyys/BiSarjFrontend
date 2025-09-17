import 'package:flutter/material.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';

import '../../../components/app_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isShow = false;
  bool isRemember = false;
  bool isLoading = false;

  bool isOldPassword = false;
  bool isNewPassword = false;
  bool isConfirmPassword = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode oldFocusNode = FocusNode();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode conFirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(context, onTap: () {
          Navigator.pop(context);
        }),
        title: Text('Change Password', style: BoldTextStyle()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Old Password', style: BoldTextStyle()),
            SizedBox(height: 8),
            TextFormField(
              obscureText: !isOldPassword ? false : true,
              focusNode: oldFocusNode,
              onChanged: (val) {
                //
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: passWordValidation,
              decoration: inputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Icon(Icons.lock_outline_rounded, size: 20, color: primaryColor),
                ),
                hintText: '',
                suffixIcon: inkWellWidget(
                  onTap: () {
                    oldPasswordShow();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Icon(!isOldPassword ? Icons.visibility_off : Icons.visibility,
                        size: 20, color: primaryColor),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('New Password', style: BoldTextStyle()),
            SizedBox(height: 8),
            TextFormField(
              obscureText: !isNewPassword ? false : true,
              decoration: inputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Icon(Icons.lock_outline_rounded, size: 20, color: primaryColor),
                ),
                hintText: '',
                suffixIcon: inkWellWidget(
                  onTap: () {
                    newPasswordShow();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Icon(!isNewPassword ? Icons.visibility_off : Icons.visibility,
                        size: 20, color: primaryColor),
                  ),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: passWordValidation,
            ),
            SizedBox(height: 16),
            Text('Confirm Password', style: BoldTextStyle()),
            SizedBox(height: 8),
            TextFormField(
              obscureText: !isConfirmPassword ? false : true,
              decoration: inputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Icon(Icons.lock_outline_rounded, size: 20, color: primaryColor),
                ),
                hintText: '',
                suffixIcon: inkWellWidget(
                  onTap: () {
                    conFirmPasswordShow();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Icon(!isConfirmPassword ? Icons.visibility_off : Icons.visibility,
                        size: 20, color: primaryColor),
                  ),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This filed is required';
                } else if (value.length < 6) {
                  return 'Minimum password length should be 6';
                } else if (newPasswordController != confirmPasswordController) {
                  return 'Your new password and confirmation password do not match.';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: AppButton(
          text: 'Submit',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  oldPasswordShow() {
    isOldPassword = !isOldPassword;
    setState(() {});
  }

  newPasswordShow() {
    isNewPassword = !isNewPassword;
    setState(() {});
  }

  conFirmPasswordShow() {
    isConfirmPassword = !isConfirmPassword;
    setState(() {});
  }
}
