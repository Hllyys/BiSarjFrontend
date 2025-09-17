import 'package:flutter/material.dart';
import 'package:frontend_bisarj/components/app_button.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';

class BankDetailScreens extends StatelessWidget {
  BankDetailScreens({super.key});

  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController nameAsBankController = TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();

  final FocusNode bankNameFocusNode = FocusNode();
  final FocusNode accountFocusNode = FocusNode();
  final FocusNode nameAsBankFocusNode = FocusNode();
  final FocusNode ifscCodeFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(context, onTap: () {
          Navigator.pop(context);
        }),
        title: Text('Bank Details', style: BoldTextStyle(size: 16)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bank Name', style: BoldTextStyle()),
            SizedBox(height: 8),
            TextFormField(
              cursorColor: primaryColor,
              decoration: inputDecoration(hintText: ''),
              focusNode: bankNameFocusNode,
              controller: bankNameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onFieldSubmitted: (val) {
                FocusScope.of(context).requestFocus(accountFocusNode);
              },
              validator: fieldValidator,
            ),
            SizedBox(height: 16),
            Text('Account Number', style: BoldTextStyle()),
            SizedBox(height: 8),
            TextFormField(
              cursorColor: primaryColor,
              decoration: inputDecoration(hintText: ''),
              focusNode: accountFocusNode,
              controller: accountNumberController,
              keyboardType: TextInputType.phone,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onFieldSubmitted: (val) {
                FocusScope.of(context).requestFocus(nameAsBankFocusNode);
              },
              validator: fieldValidator,
            ),
            SizedBox(height: 16),
            Text('Name as Per Bank', style: BoldTextStyle()),
            SizedBox(height: 8),
            TextFormField(
              cursorColor: primaryColor,
              decoration: inputDecoration(hintText: ''),
              focusNode: nameAsBankFocusNode,
              controller: nameAsBankController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onFieldSubmitted: (val) {
                FocusScope.of(context).requestFocus(ifscCodeFocusNode);
              },
              validator: fieldValidator,
            ),
            SizedBox(height: 16),
            Text('IFSC Code', style: BoldTextStyle()),
            SizedBox(height: 8),
            TextFormField(
              cursorColor: primaryColor,
              decoration: inputDecoration(hintText: ''),
              focusNode: ifscCodeFocusNode,
              controller: ifscCodeController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: fieldValidator,
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
}
