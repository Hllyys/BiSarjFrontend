// Bold Text Style
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:ev/utils/app_colors.dart';
// import 'package:ev/utils/app_constants.dart';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:lottie/lottie.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_assets.dart';

TextStyle BoldTextStyle({
  int? size,
  Color? color,
  FontWeight? weight,
  String? fontFamily,
  double? letterSpacing,
  FontStyle? fontStyle,
  double? wordSpacing,
  TextDecoration? decoration,
  TextDecorationStyle? textDecorationStyle,
  TextBaseline? textBaseline,
  Color? decorationColor,
  Color? backgroundColor,
  double? height,
}) {
  return TextStyle(
    fontSize: size != null ? size.toDouble() : textBoldSizeGlobal,
    color: color ?? Colors.black,
    fontWeight: weight ?? FontWeight.bold,
    fontFamily: fontFamily ?? 'AirbnbCereal_W_Bd',
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
    decoration: decoration,
    decorationStyle: textDecorationStyle,
    decorationColor: decorationColor,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    backgroundColor: backgroundColor,
    height: height,
  );
}

// Primary Text Style
TextStyle PrimaryTextStyle({
  int? size,
  Color? color,
  FontWeight? weight,
  String? fontFamily,
  double? letterSpacing,
  FontStyle? fontStyle,
  double? wordSpacing,
  TextDecoration? decoration,
  TextDecorationStyle? textDecorationStyle,
  TextBaseline? textBaseline,
  Color? decorationColor,
  Color? backgroundColor,
  double? height,
}) {
  return TextStyle(
    fontSize: size != null ? size.toDouble() : textPrimarySizeGlobal,
    color: color ?? Colors.black,
    fontWeight: weight ?? FontWeight.normal,
    fontFamily: fontFamily ?? 'AirbnbCereal_W_Bk',
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
    decoration: decoration,
    decorationStyle: textDecorationStyle,
    decorationColor: decorationColor,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    backgroundColor: backgroundColor,
    height: height,
  );
}

// Secondary Text Style
TextStyle SecondaryTextStyle({
  int? size,
  Color? color,
  FontWeight? weight,
  String? fontFamily,
  double? letterSpacing,
  FontStyle? fontStyle,
  double? wordSpacing,
  TextDecoration? decoration,
  TextDecorationStyle? textDecorationStyle,
  TextBaseline? textBaseline,
  Color? decorationColor,
  Color? backgroundColor,
  double? height,
}) {
  return TextStyle(
    fontSize: size != null ? size.toDouble() : textSecondarySizeGlobal,
    color: color ?? textSecondaryColor,
    fontWeight: weight ?? FontWeight.w500,
    fontFamily: fontFamily ?? 'AirbnbCereal_W_Lt',
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
    decoration: decoration,
    decorationStyle: textDecorationStyle,
    decorationColor: decorationColor,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    backgroundColor: backgroundColor,
    height: height,
  );
}

InputDecoration inputDecoration({
  String? hintText,
  String? title,
  Widget? suffixIcon,
  Widget? prefix,
  Widget? prefixIcon,
  Widget? suffix,
  Widget? label,
  EdgeInsets? padding,
}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: PrimaryTextStyle(color: Colors.grey.shade500, size: 16),
    label: label,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: primaryColor),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
    ),
    labelStyle: BoldTextStyle(color: primaryColor),
    hoverColor: primaryColor.withOpacity(0.3),
    contentPadding: padding,
    labelText: title,
    suffixIcon: suffixIcon,
    prefix: prefix,
    prefixIcon: prefixIcon,
    suffix: suffix,
    // prefixIconConstraints: BoxConstraints(minWidth: 25, minHeight: 25),
    // suffixIconConstraints: BoxConstraints(minWidth: 25, minHeight: 25),
  );
}

Widget noDataFound() {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(ic_empty, fit: BoxFit.contain, height: 200),
        Text('Not Found', style: BoldTextStyle()),
      ],
    ),
  );
}

PreferredSizeWidget appBarWidget({
  String? title,
  IconData? icon,
  Function()? onTap,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.bolt, color: Colors.white, size: 25),
        ),
        SizedBox(width: 16),
        Text(title!, style: BoldTextStyle(size: 16)),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(16),
        child: inkWellWidget(
          onTap: onTap,
          child: Icon((icon), color: primaryColor),
        ),
      ),
    ],
  );
}

Widget inkWellWidget({required Function()? onTap, required Widget child}) {
  return InkWell(
    overlayColor: MaterialStateProperty.resolveWith(
      (states) => Colors.transparent,
    ),
    onTap: onTap,
    child: child,
  );
}

Widget backButton(BuildContext context, {Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Center(
        child: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Colors.white,
          size: 16,
        ),
      ),
    ),
  );
}

EdgeInsetsGeometry paddingTop() {
  return EdgeInsets.only(top: 50, left: 16, right: 8);
}

Widget topTitleWidget({required BuildContext context, String? title}) {
  return Row(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
      SizedBox(width: 20),
      Text(title!, style: BoldTextStyle()),
    ],
  );
}

String? fieldValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'This filed is required';
  }
  return null;
}

commonSnackBar({String? message, ContentType? contentType}) {
  SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'On Snap!',
      message: message!,
      contentType: contentType ?? ContentType.failure,
    ),
  );

  /*ScaffoldMessenger.of(Get.context!)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);*/
}

commonToast({String? title}) {
  return Fluttertoast.showToast(
    msg: title!,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 12.0,
  );
}

String? passWordValidation(String? value) {
  if (value!.isEmpty) {
    return 'This filed is required';
  } else if (value.length < 6) {
    return 'Your password should be at least 6 characters.';
  }
  return null;
}

String commonData({DateTime? date}) {
  return DateFormat.jm().format(date!);
}

String commonDataToday({DateTime? date}) {
  if (date!.difference(DateTime.now()).inDays == 0) {
    return 'Today';
  } else {
    return DateFormat.yMMMd().format(date);
  }
}

Future<void> mapDirection({double? latitude, double? longitude}) async {
  String url =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

  launchUrl(Uri.parse(url));
}
