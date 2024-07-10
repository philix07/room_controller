// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../style/app_colors.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({
    super.key,
    this.alignment = Alignment.center,
    this.padding = const EdgeInsets.all(8.0),
    this.margin,
    this.color = AppColor.white,
    this.width,
    this.height,
    this.boxShadow = const [
      BoxShadow(
        offset: Offset(0, 2),
        blurRadius: 6.0,
        blurStyle: BlurStyle.outer,
        color: AppColor.shadow,
      ),
    ],
    required this.child,
  });

  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double? width;
  final double? height;
  final List<BoxShadow>? boxShadow;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
