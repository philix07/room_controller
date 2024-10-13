import 'package:aplikasi_kontrol_kelas/blocs/auth/auth_bloc.dart';
import 'package:aplikasi_kontrol_kelas/common/components/spaces.dart';
import 'package:aplikasi_kontrol_kelas/common/style/app_style.dart';
import 'package:aplikasi_kontrol_kelas/models/schedule.dart';
import 'package:aplikasi_kontrol_kelas/models/user.dart';
import 'package:aplikasi_kontrol_kelas/presentation/home/widgets/schedule_tile.dart';
import 'package:aplikasi_kontrol_kelas/presentation/setting/pages/edit_schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleTileList extends StatelessWidget {
  const ScheduleTileList({
    super.key,
    required this.schedule,
    required this.daysOfWeek,
  });

  final Schedule schedule;
  final Days daysOfWeek;

  @override
  Widget build(BuildContext context) {
    var userRole = context.read<AuthBloc>().appUser.role;
    var isAdmin = userRole == UserRole.admin ? true : false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: isAdmin
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${daysOfWeek.value.toUpperCase()}'s Schedule",
                      style: AppTextStyle.black(),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditSchedulePage(
                              schedule: schedule,
                              daysOfWeek: daysOfWeek,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Edit Schedule",
                        style: AppTextStyle.blue(),
                      ),
                    )
                  ],
                )
              : Text(
                  "${daysOfWeek.value.toUpperCase()}'s Schedule",
                  style: AppTextStyle.black(),
                ),
        ),
        const SpaceHeight(6.0),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: schedule.schedules.length,
          itemBuilder: (context, index) => ScheduleTile(
            startDate: schedule.schedules[index].startTime,
            endDate: schedule.schedules[index].endTime,
            description: schedule.schedules[index].description,
          ),
        ),
        const SpaceHeight(10.0),
      ],
    );
  }
}
