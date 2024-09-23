import 'package:flutter/material.dart';

import '../../../common/components/spaces.dart';
import '../../../common/style/app_style.dart';
import '../../../common/utils/app_formatter.dart';
import '../../../models/access_log.dart';
import '../../home/widgets/access_log_tile.dart';

class AccessLogTileList extends StatelessWidget {
  const AccessLogTileList({super.key, required this.logs});

  final List<AccessLog> logs;

  @override
  Widget build(BuildContext context) {
    AppFormatter format = AppFormatter();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today's Access Log",
          style: AppTextStyle.black(),
        ),
        const SpaceHeight(6.0),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: logs.length,
          itemBuilder: (context, index) => AccessLogTile(
            username: logs[index].username,
            description: logs[index].action,
            operationTime: logs[index].operationTime,
          ),
        ),
        const SpaceHeight(50.0),
      ],
    );
  }
}
