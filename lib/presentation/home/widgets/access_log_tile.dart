// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:aplikasi_kontrol_kelas/common/style/app_colors.dart';

import '../../../common/components/app_container.dart';
import '../../../common/components/spaces.dart';
import '../../../common/style/app_style.dart';
import '../../../common/utils/app_formatter.dart';

class AccessLogTile extends StatelessWidget {
  const AccessLogTile({
    super.key,
    required this.username,
    required this.description,
    required this.operationTime,
  });

  final String username;
  final String description;
  final DateTime operationTime;

  @override
  Widget build(BuildContext context) {
    AppFormatter format = AppFormatter();

    return AppContainer(
      margin: const EdgeInsets.only(bottom: 7.0),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/lock.svg',
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
                  '$username ${format.time(operationTime)}',
                  style: AppTextStyle.black(),
                ),
                Text(
                  description,
                  // overflow: TextOverflow.clip,
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
