import 'package:aplikasi_kontrol_kelas/blocs/auth/auth_bloc.dart';
import 'package:aplikasi_kontrol_kelas/blocs/classroom/classroom_bloc.dart';
import 'package:aplikasi_kontrol_kelas/common/components/app_scaffold.dart';
import 'package:aplikasi_kontrol_kelas/common/components/spaces.dart';
import 'package:aplikasi_kontrol_kelas/common/style/app_style.dart';
import 'package:aplikasi_kontrol_kelas/models/access_log.dart';
import 'package:aplikasi_kontrol_kelas/presentation/profile/widgets/detailed_access_log_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/components/app_dialog.dart';

class MyAccecssLogPage extends StatelessWidget {
  const MyAccecssLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [
          Center(
            child: Text(
              'My Access Log',
              style: AppTextStyle.black(fontSize: 16.0),
            ),
          ),
          BlocBuilder<ClassroomBloc, ClassroomState>(
            builder: (context, state) {
              if (state is ClassroomLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ClassroomError) {
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
              } else if (state is ClassroomSuccess) {
                var currentUser = context.read<AuthBloc>().appUser;
                List<List<AccessLog>> logs = [];

                // Get all the logs based on which user logged in
                var crData = state.classrooms;
                for (var cr in crData) {
                  var dumpLogs = <AccessLog>[];
                  for (var accessLog in cr.logs) {
                    if (accessLog.username == currentUser.username) {
                      dumpLogs.add(accessLog);
                    }
                  }
                  logs.add(dumpLogs);
                }

                return Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: crData.length,
                    itemBuilder: (context, index) => DetailedAccessLogTile(
                      roomName: crData[index].name,
                      logs: logs[index],
                    ),
                  ),
                );
              }

              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          const SpaceHeight(10.0),
        ],
      ),
    );
  }
}
