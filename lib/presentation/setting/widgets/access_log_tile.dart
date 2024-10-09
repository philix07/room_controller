import 'package:aplikasi_kontrol_kelas/models/access_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/components/app_container.dart';
import '../../../common/components/spaces.dart';
import '../../../common/style/app_colors.dart';
import '../../../common/style/app_style.dart';
import '../../../common/utils/app_formatter.dart';

class AccessLogTile extends StatelessWidget {
  const AccessLogTile({super.key, required this.accessLog});

  final AccessLog accessLog;

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
                  '${accessLog.username} (${accessLog.operationTime})',
                  style: AppTextStyle.black(),
                ),
                Text(
                  accessLog.action,
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
