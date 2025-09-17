import 'package:flutter/material.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AppButton extends StatefulWidget {
  final String? text;
  final TextStyle? style;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final Color? backColor;

  AppButton({
    this.text,
    this.onPressed,
    this.style,
    this.backgroundColor,
    this.child,
    this.padding,
    this.backColor,
  });

  @override
  AppButtonState createState() => AppButtonState();
}

class AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late double scale;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(
          vsync: this,
          duration: Duration(milliseconds: 100),
          lowerBound: 0.0,
          upperBound: 0.1,
        )..addListener(() {
          setState(() {});
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    scale = 1 - controller.value;

    return Listener(
      onPointerDown: (event) {
        controller.forward();
      },
      onPointerUp: (event) {
        controller.reverse();
      },
      child: GestureDetector(
        onTap: () => widget.onPressed?.call(),
        child: Transform.scale(
          scale: scale,
          child: Container(
            height: widget.padding != null ? 40 : 50,
            padding: widget.padding != null
                ? widget.padding
                : EdgeInsets.all(12),
            //margin: EdgeInsets.only(left: 8, right: 8),
            width: MediaQuery.of(context).size.width,
            decoration: widget.backColor != null
                ? BoxDecoration(
                    color: widget.backColor,
                    border: Border.all(color: widget.backColor!),
                    borderRadius: BorderRadius.circular(defaultRadius),
                  )
                : widget.backgroundColor == null
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    boxShadow: [
                      BoxShadow(color: Color(0x80000000), blurRadius: 1),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [primaryColor, primaryColor],
                    ),
                  )
                : BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
            child: Center(
              child:
                  widget.child ??
                  AutoSizeText(
                    maxLines: 1,
                    widget.text!,
                    style:
                        widget.style ??
                        BoldTextStyle(
                          color: widget.backgroundColor == null
                              ? Colors.white
                              : primaryColor,
                        ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
