// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:aplikasi_kontrol_kelas/common/components/app_container.dart';
import 'package:aplikasi_kontrol_kelas/common/style/app_colors.dart';
import 'package:aplikasi_kontrol_kelas/common/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ComponentRemote extends StatefulWidget {
  const ComponentRemote({
    super.key,
    required this.svgPath,
    required this.title,
    required this.isActive,
    required this.width,
    required this.height,
    required this.fontSize,
    required this.onSwitch,
    this.svgWidth,
    this.svgHeight,
  });

  final String svgPath;
  final String title;
  final bool isActive;
  final double fontSize;
  final double width;
  final double height;
  final void Function(bool)? onSwitch;
  final double? svgWidth;
  final double? svgHeight;

  @override
  State<ComponentRemote> createState() => _ComponentRemoteState();
}

class _ComponentRemoteState extends State<ComponentRemote> {
  @override
  Widget build(BuildContext context) {
    Color activeForeground = widget.isActive ? AppColor.white : AppColor.font;
    Color activeBackground =
        widget.isActive ? AppColor.primary : AppColor.white;

    return AppContainer(
      width: widget.width,
      height: widget.height,
      color: activeBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Container()),
          SvgPicture.asset(
            widget.svgPath,
            width: widget.svgWidth,
            height: widget.svgHeight,
            colorFilter: ColorFilter.mode(activeForeground, BlendMode.srcIn),
          ),
          Text(
            widget.title,
            style: widget.isActive
                ? AppTextStyle.white(fontSize: widget.fontSize)
                : AppTextStyle.black(fontSize: widget.fontSize),
          ),
          Expanded(child: Container()),
          Switch(
            onChanged: widget.onSwitch,
            value: widget.isActive,
            activeColor: AppColor.primary,
            activeTrackColor: AppColor.white,
            inactiveThumbColor: AppColor.white,
            inactiveTrackColor: AppColor.primary,
          ),
        ],
      ),
    );
  }
}
