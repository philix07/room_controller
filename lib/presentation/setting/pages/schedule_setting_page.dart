import 'package:aplikasi_kontrol_kelas/blocs/schedule/schedule_bloc.dart';
import 'package:aplikasi_kontrol_kelas/presentation/setting/widgets/schedule_tile_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/components/app_dialog.dart';
import '../../../models/classroom.dart';
import '../../../models/schedule.dart';

class ScheduleSettingPage extends StatelessWidget {
  const ScheduleSettingPage({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        if (state is ScheduleLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ScheduleError) {
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
        } else if (state is ScheduleSuccess) {
          var schedules = state.schedules;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: schedules.length,
            itemBuilder: (context, index) => ScheduleTileList(
              schedule: schedules[index],
              daysOfWeek: Days.fromIndex(index),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
