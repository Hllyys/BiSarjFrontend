import 'package:flutter/material.dart';
import 'package:frontend_bisarj/components/app_button.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_commons.dart';

class AlertDialogWidget extends StatefulWidget {
  final double scale;
  final String? title;
  final String? subTitle;
  final Function()? onTap;

  AlertDialogWidget({
    required this.scale,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  @override
  State<AlertDialogWidget> createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.scale,
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(ic_book, height: 120, fit: BoxFit.contain),
              SizedBox(height: 16),
              Text(
                widget.title!,
                style: BoldTextStyle(size: 18, color: primaryColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                widget.subTitle!,
                style: PrimaryTextStyle(),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              AppButton(
                padding: EdgeInsets.all(8),
                text: 'Ok',
                onPressed: widget.onTap!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
