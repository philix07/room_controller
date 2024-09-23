// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:aplikasi_kontrol_kelas/blocs/access_log/access_log_bloc.dart';
import 'package:aplikasi_kontrol_kelas/presentation/setting/widgets/access_log_tile_list.dart';
import 'package:flutter/material.dart';

import 'package:aplikasi_kontrol_kelas/models/classroom.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/components/app_dialog.dart';

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
          //TODO: separate this logs, 1 access log for 1 day
          var logs = state.logs;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: logs.length,
            itemBuilder: (context, index) => AccessLogTileList(logs: logs),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
