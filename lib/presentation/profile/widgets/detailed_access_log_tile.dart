import 'package:aplikasi_kontrol_kelas/common/components/app_container.dart';
import 'package:aplikasi_kontrol_kelas/presentation/home/widgets/access_log_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/components/spaces.dart';
import '../../../common/style/app_colors.dart';
import '../../../common/style/app_style.dart';
import '../../../common/utils/app_formatter.dart';
import '../../../models/access_log.dart';

class DetailedAccessLogTile extends StatelessWidget {
  const DetailedAccessLogTile({
    super.key,
    required this.roomName,
    required this.logs,
  });

  final String roomName;
  final List<AccessLog> logs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Access Log At Room : $roomName',
          style: AppTextStyle.black(fontSize: 14.0),
        ),
        const SpaceHeight(8.0),
        logs.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: logs.length,
                itemBuilder: (context, index) => AccessLogTile(
                  username: logs[index].username,
                  description: logs[index].action,
                  operationTime: logs[index].operationTime,
                ),
              )
            : Row(
                children: [
                  SvgPicture.asset(
                    width: 30,
                    height: 30,
                    'assets/icons/information.svg',
                    colorFilter: const ColorFilter.mode(
                      AppColor.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SpaceWidth(5.0),
                  Text(
                    'No Access Log At Room : $roomName',
                    style: AppTextStyle.black(),
                  ),
                ],
              ),
        const SpaceHeight(8.0),
      ],
    );
  }
}

// class DetailedAccessLogTile extends StatelessWidget {
//   const DetailedAccessLogTile({
//     super.key,
//     required this.roomName,
//     required this.username,
//     required this.description,
//     required this.operationTime,
//     this.showDetailedOperationTime = false,
//   });

//   final String roomName;
//   final String username;
//   final String description;
//   final DateTime operationTime;
//   final bool showDetailedOperationTime;

//   @override
//   Widget build(BuildContext context) {
//     AppFormatter format = AppFormatter();

//     return AppContainer(
//       margin: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 7.0),
//       child: Row(
//         children: [
//           SvgPicture.asset(
//             'assets/icons/lock.svg',
//             colorFilter: const ColorFilter.mode(
//               AppColor.black,
//               BlendMode.srcIn,
//             ),
//           ),
//           const SpaceWidth(10.0),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Column(
//                   children: [
//                     Text(
//                             'Room : $roomName',
//                             style: AppTextStyle.black(),
//                           ),
//                     showDetailedOperationTime
//                         ? Text(
//                             '$username (${format.dateTime(operationTime)})',
//                             style: AppTextStyle.black(),
//                           )
//                         : Text(
//                             '$username ${format.time(operationTime)}',
//                             style: AppTextStyle.black(),
//                           ),
//                   ],
//                 ),
//                 Text(
//                   description,
//                   // overflow: TextOverflow.clip,
//                   style: AppTextStyle.gray(),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
