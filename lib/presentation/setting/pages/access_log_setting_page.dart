// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:aplikasi_kontrol_kelas/blocs/access_log/access_log_bloc.dart';
import 'package:aplikasi_kontrol_kelas/common/components/spaces.dart';
import 'package:aplikasi_kontrol_kelas/presentation/setting/widgets/access_log_tile_list.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/components/app_dialog.dart';
import '../../home/widgets/access_log_tile.dart';

class AccessLogSettingPage extends StatelessWidget {
  const AccessLogSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessLogBloc, AccessLogState>(
      builder: (context, state) {
        if (state is AccessLogLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AccessLogError) {
          Future.delayed(
            const Duration(milliseconds: 100),
            () {
              AppDialog.show(
                context,
                iconPath: 'assets/icons/error.svg',
                message: state.message,
              );
            },
          );
        } else if (state is AccessLogSuccess) {
          // since the "logs" array is descending
          // we need to reverse index the "logs" array
          var logs = state.logs.reversed.toList();

          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: logs.length,
                itemBuilder: (context, index) => AccessLogTile(
                  username: logs[index].username,
                  description: logs[index].action,
                  operationTime: logs[index].operationTime,
                  showDetailedOperationTime: true,
                ),
              ),
              const SpaceHeight(40.0),
            ],
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
