import 'package:aplikasi_kontrol_kelas/common/components/spaces.dart';
import 'package:aplikasi_kontrol_kelas/common/style/app_style.dart';
import 'package:aplikasi_kontrol_kelas/models/schedule.dart';
import 'package:aplikasi_kontrol_kelas/presentation/home/widgets/schedule_tile.dart';
import 'package:flutter/widgets.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${daysOfWeek.value.toUpperCase()}'s Schedule",
          style: AppTextStyle.black(),
        ),
        const SpaceHeight(6.0),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: schedule.schedules.length,
          itemBuilder: (context, index) => ScheduleTile(
            startDate: schedule.schedules[index].startTime,
            endDate: schedule.schedules[index].startTime,
            description: schedule.schedules[index].description,
          ),
        ),
        const SpaceHeight(10.0),
      ],
    );
  }
}
