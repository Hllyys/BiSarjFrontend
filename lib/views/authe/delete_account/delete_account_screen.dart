import 'package:flutter/material.dart';
import 'package:frontend_bisarj/graphql/service/auth/user_service.dart';
import 'package:frontend_bisarj/views/authe/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:frontend_bisarj/components/app_button.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';
import 'package:frontend_bisarj/utils/app_assets.dart';

import 'package:frontend_bisarj/graphql/service/auth/account_service.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  Future<int?> _resolveUserId(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');

    if (userId == null || userId <= 0) {
      userId = await UserService.ensureUserIdFromMeUser(context);
    }
    return userId;
  }

  Future<void> _handleDelete(BuildContext context) async {
    Navigator.pop(context); // onay dialogunu kapat
    try {
      final userId = await _resolveUserId(context);
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('A user information error occurred.')),
        );
        return;
      }

      final deleted = await AccountService.deleteUser(
        context,
        id: userId,
        trash: true,
      );

      // Sadece silme başarılıysa yönlendir
      final bool isDeleted = deleted != null && deleted['id'] != null;

      if (isDeleted) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        await prefs.remove('userId');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account deleted: ${deleted['email'] ?? ''}')),
        );

        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Deletion failed.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Deletion ERROR: $e')));
    }
  }

  void _openConfirmDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (ctx, a1, a2, child) {
        final curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(ic_book, height: 120, fit: BoxFit.contain),
                  const SizedBox(height: 16),
                  Text(
                    'Delete Account',
                    style: BoldTextStyle(size: 18, color: primaryColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Are you sure you want to delete Account?',
                    style: PrimaryTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          padding: const EdgeInsets.all(8),
                          text: 'No',
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AppButton(
                          backColor: Colors.red,
                          padding: const EdgeInsets.all(8),
                          text: 'Yes',
                          onPressed: () => _handleDelete(context),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(context, onTap: () => Navigator.pop(context)),
        title: Text('Delete Account', style: BoldTextStyle()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Confirm account deletion', style: BoldTextStyle(size: 16)),
            const SizedBox(height: 16),
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
          onPressed: () => _openConfirmDialog(context),
        ),
      ),
    );
  }
}
