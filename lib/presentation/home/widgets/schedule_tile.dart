// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:aplikasi_kontrol_kelas/common/style/app_colors.dart';
import 'package:aplikasi_kontrol_kelas/common/utils/app_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/components/app_container.dart';
import '../../../common/components/spaces.dart';
import '../../../common/style/app_style.dart';

class ScheduleTile extends StatelessWidget {
  const ScheduleTile({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.description,
  });

  final DateTime startDate;
  final DateTime endDate;
  final String description;

  @override
  Widget build(BuildContext context) {
    AppFormatter formatter = AppFormatter();

    return AppContainer(
      margin: const EdgeInsets.only(bottom: 7.0),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/calendar.svg',
            width: 25,
            height: 25,
            colorFilter: const ColorFilter.mode(
              AppColor.black,
              BlendMode.srcIn,
            ),
          ),
          const SpaceWidth(10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${formatter.time(startDate)} sampai ${formatter.time(endDate)}',
                  style: AppTextStyle.black(),
                ),
                Text(
                  description,
                  overflow: TextOverflow.clip,
                  style: AppTextStyle.gray(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
