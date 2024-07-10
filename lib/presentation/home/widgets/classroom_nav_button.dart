import 'package:flutter/material.dart';

import '../../../common/style/app_style.dart';

class ClassroomNavButton extends StatelessWidget {
  const ClassroomNavButton({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  final String title;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(right: 12.0),
        child: Text(
          title,
          style: isActive
              ? AppTextStyle.black(fontSize: 14.0)
              : AppTextStyle.gray(fontSize: 14.0),
        ),
      ),
    );
  }
}
