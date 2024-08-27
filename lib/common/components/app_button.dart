// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../style/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.color = AppColor.primary,
    this.height = 40,
    this.width = 140,
    required this.title,
    required this.textStyle,
    required this.onTap,
  });

  final Color color;
  final double width;
  final double height;
  final String title;
  final TextStyle textStyle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 5.0,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: AppColor.gray.withOpacity(0.2),
            ),
          ],
        ),
        child: Text(
          title,
          style: textStyle,
        ),
      ),
    );
  }
}


class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    this.color = AppColor.primary,
    this.height = 40,
    this.width = 140,
    required this.child,
    required this.onTap,
  });

  final Color color;
  final double width;
  final double height;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 5.0,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: AppColor.gray.withOpacity(0.2),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}