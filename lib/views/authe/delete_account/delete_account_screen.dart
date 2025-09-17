import 'package:flutter/material.dart';
import 'package:frontend_bisarj/components/app_button.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';

import '../../../utils/app_assets.dart';
// import '../../../utils/app_constants.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(context, onTap: () {
          Navigator.pop(context);
        }),
        title: Text('Delete Account', style: BoldTextStyle()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Confirm account deletion', style: BoldTextStyle(size: 16)),
            SizedBox(height: 16),
            Text(
              'Deleting your account removes personal information from our database. Your email becomes permanently reserved and same email cannot be re-used to register a new account.',
              style: PrimaryTextStyle(size: 16),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AppButton(
          text: 'Delete Account',
          onPressed: () {
            showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
              pageBuilder: (ctx, a1, a2) {
                return Container();
              },
              transitionBuilder: (ctx, a1, a2, child) {
                var curve = Curves.easeInOut.transform(a1.value);

                return Transform.scale(
                  scale: curve,
                  child: AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius)),
                    content: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(ic_book, height: 120, fit: BoxFit.contain),
                          SizedBox(height: 16),
                          Text('Delete Account',
                              style: BoldTextStyle(size: 18, color: primaryColor),
                              textAlign: TextAlign.center),
                          SizedBox(height: 16),
                          Text('Are you sure you want to delete Account?',
                              style: PrimaryTextStyle(), textAlign: TextAlign.center),
                          SizedBox(height: 30),
                          Row(
                            children: [
                              Expanded(
                                child: AppButton(
                                  padding: EdgeInsets.all(8),
                                  text: 'No',
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: AppButton(
                                  backColor: Colors.red,
                                  padding: EdgeInsets.all(8),
                                  text: 'Yes',
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    ;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 300),
            );
          },
        ),
      ),
    );
  }
}
