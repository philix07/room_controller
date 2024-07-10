import 'package:aplikasi_kontrol_kelas/common/components/spaces.dart';
import 'package:aplikasi_kontrol_kelas/common/style/app_style.dart';
import 'package:aplikasi_kontrol_kelas/models/room_condition.dart';
import 'package:aplikasi_kontrol_kelas/presentation/home/widgets/access_log_tile.dart';
import 'package:aplikasi_kontrol_kelas/presentation/home/widgets/component_remote.dart';
import 'package:aplikasi_kontrol_kelas/presentation/home/widgets/schedule_button.dart';
import 'package:aplikasi_kontrol_kelas/presentation/home/widgets/schedule_tile.dart';
import 'package:flutter/material.dart';

class ClassroomDetailPage extends StatefulWidget {
  const ClassroomDetailPage({super.key, required this.roomCondition});

  final RoomCondition roomCondition;

  @override
  State<ClassroomDetailPage> createState() => _ClassroomDetailPageState();
}

class _ClassroomDetailPageState extends State<ClassroomDetailPage> {
  final ValueNotifier<int> _scheduleIndex = ValueNotifier(0);

  void switchIndex(int index) {
    setState(() {
      _scheduleIndex.value = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var roomCondition = widget.roomCondition;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //? Switch Button Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ComponentRemote(
              svgPath: "assets/icons/ac.svg",
              title: "Air Conditioner",
              isActive: roomCondition.isAirConditionerOn,
              fontSize: 12.0,
              svgWidth: 80,
              width: MediaQuery.of(context).size.width / 2.3,
              height: MediaQuery.of(context).size.width / 2.3,
            ),
            ComponentRemote(
              svgPath: "assets/icons/lamp.svg",
              title: "Lamp",
              isActive: false,
              fontSize: 12.0,
              svgWidth: 80,
              width: MediaQuery.of(context).size.width / 2.3,
              height: MediaQuery.of(context).size.width / 2.3,
            ),
          ],
        ),

        //? Schedule Section
        const SpaceHeight(12.0),
        Text(
          'Room Schedule',
          style: AppTextStyle.black(fontSize: 16.0),
        ),
        const SpaceHeight(5.0),

        ValueListenableBuilder(
          valueListenable: _scheduleIndex,
          builder: (context, value, child) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  switchIndex(0);
                },
                child: ScheduleButton(
                  isActive: _scheduleIndex.value == 0,
                  title: 'Senin',
                ),
              ),
              InkWell(
                onTap: () {
                  switchIndex(1);
                },
                child: ScheduleButton(
                  isActive: _scheduleIndex.value == 1,
                  title: 'Selasa',
                ),
              ),
              InkWell(
                onTap: () {
                  switchIndex(2);
                },
                child: ScheduleButton(
                  isActive: _scheduleIndex.value == 2,
                  title: 'Rabu',
                ),
              ),
              InkWell(
                onTap: () {
                  switchIndex(3);
                },
                child: ScheduleButton(
                  isActive: _scheduleIndex.value == 3,
                  title: 'Kamis',
                ),
              ),
              InkWell(
                onTap: () {
                  switchIndex(4);
                },
                child: ScheduleButton(
                  isActive: _scheduleIndex.value == 4,
                  title: 'Jumat',
                ),
              ),
              InkWell(
                onTap: () {
                  switchIndex(5);
                },
                child: ScheduleButton(
                  isActive: _scheduleIndex.value == 5,
                  title: 'Sabtu',
                ),
              ),
            ],
          ),
        ),
        const SpaceHeight(10.0),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScheduleTile(
              startDate: DateTime.now(),
              endDate: DateTime.now(),
              description: 'Inf 4Q - Arsitektur Dan Organisasi Komputer',
            ),
            ScheduleTile(
              startDate: DateTime.now(),
              endDate: DateTime.now(),
              description: 'Inf 6Q - Sistem Operasi',
            ),
            ScheduleTile(
              startDate: DateTime.now(),
              endDate: DateTime.now(),
              description: 'Inf 8Q - Pemrograman Lanjutan Visual Basic .Net',
            ),
          ],
        ),

        //? Access Log Section
        const SpaceHeight(5.0),
        Text(
          'Access Log',
          style: AppTextStyle.black(fontSize: 16.0),
        ),
        const SpaceHeight(5.0),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccessLogTile(
              username: "Felix Liando",
              operationTime: DateTime.now(),
              description: 'Mematikan AC',
            ),
            AccessLogTile(
              username: "Felix Liando",
              operationTime: DateTime.now(),
              description: 'Mematikan AC',
            ),
            AccessLogTile(
              username: "Felix Liando",
              operationTime: DateTime.now(),
              description: 'Mematikan AC',
            ),
            AccessLogTile(
              username: "Felix Liando",
              operationTime: DateTime.now(),
              description: 'Mematikan AC',
            ),
          ],
        )
      ],
    );
  }
}
