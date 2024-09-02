// ignore_for_file: avoid_print

import 'package:aplikasi_kontrol_kelas/common/components/spaces.dart';
import 'package:aplikasi_kontrol_kelas/common/style/app_style.dart';
import 'package:aplikasi_kontrol_kelas/presentation/setting/pages/setting_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/access_log/access_log_bloc.dart';
import '../../blocs/classroom/classroom_bloc.dart';
import '../../blocs/devices/devices_bloc.dart';
import '../../blocs/schedule/schedule_bloc.dart';
import '../../common/components/app_dialog.dart';
import '../../common/components/app_nav_bar.dart';
import '../../common/components/app_scaffold.dart';
import '../home/widgets/classroom_nav_button.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  int _classroomIndex = 0;
  void swapIndex(int index) {
    setState(() {
      _classroomIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      withAppBar: true,
      appBarTitle: "Settings",
      actions: AppNavBar.get(context),
      child: BlocBuilder<ClassroomBloc, ClassroomState>(
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
            var crData = state.classrooms;

            //? Load Schedule Data
            context.read<ScheduleBloc>().add(LoadSchedule(
                  schedules: crData[_classroomIndex].schedules,
                  crID: crData[_classroomIndex].id,
                ));

            //? Load Access Log Data
            context.read<AccessLogBloc>().add(LoadAccessLog(
                  logs: crData[_classroomIndex].logs,
                  crID: crData[_classroomIndex].id,
                ));

            //? Load Device Data
            context.read<DevicesBloc>().add(LoadDevice(
                  airConditioner: crData[_classroomIndex].airConditioner,
                  lamp: crData[_classroomIndex].lamp,
                  crID: crData[_classroomIndex].id,
                ));

            return SingleChildScrollView(
              child: Column(
                children: [
                  //? Select Classroom Row
                  Row(
                    children: [
                      Text(
                        'Select classroom',
                        style: AppTextStyle.black(fontSize: 14.0),
                      ),
                      const SpaceWidth(10.0),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: crData.length,
                            itemBuilder: (context, index) {
                              return ClassroomNavButton(
                                title: crData[index].name,
                                isActive: _classroomIndex == index,
                                onTap: () {
                                  swapIndex(index);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SpaceHeight(5.0),

                  //? Settings Information Detail All Goes Here
                  SettingDetailPage(
                    classroom: crData[_classroomIndex],
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
