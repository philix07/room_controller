// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../common/components/app_container.dart';
import '../../../common/style/app_colors.dart';
import '../../../common/style/app_style.dart';

class ScheduleButton extends StatelessWidget {
  const ScheduleButton({
    super.key,
    required this.isActive,
    required this.title,
  });

  final bool isActive;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      width: MediaQuery.of(context).size.width / 7.2,
      color: isActive ? AppColor.black : AppColor.white,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          title,
          style: isActive ? AppTextStyle.white() : AppTextStyle.black(),
        ),
      ),
    );
  }
}
