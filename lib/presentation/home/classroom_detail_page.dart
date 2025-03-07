// ignore_for_file: avoid_print

import 'package:aplikasi_kontrol_kelas/blocs/access_log/access_log_bloc.dart';
import 'package:aplikasi_kontrol_kelas/blocs/classroom/classroom_bloc.dart';
import 'package:aplikasi_kontrol_kelas/blocs/devices/devices_bloc.dart';
import 'package:aplikasi_kontrol_kelas/blocs/schedule/schedule_bloc.dart';
import 'package:aplikasi_kontrol_kelas/common/components/app_button.dart';
import 'package:aplikasi_kontrol_kelas/common/components/spaces.dart';
import 'package:aplikasi_kontrol_kelas/common/style/app_colors.dart';
import 'package:aplikasi_kontrol_kelas/common/style/app_style.dart';
import 'package:aplikasi_kontrol_kelas/models/classroom.dart';
import 'package:aplikasi_kontrol_kelas/models/schedule.dart';
import 'package:aplikasi_kontrol_kelas/presentation/home/widgets/access_log_tile.dart';
import 'package:aplikasi_kontrol_kelas/presentation/home/widgets/component_remote.dart';
import 'package:aplikasi_kontrol_kelas/presentation/home/widgets/schedule_button.dart';
import 'package:aplikasi_kontrol_kelas/presentation/home/widgets/schedule_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/components/app_dialog.dart';

class ClassroomDetailPage extends StatefulWidget {
  const ClassroomDetailPage({super.key, required this.classroom});

  final Classroom classroom;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //? Switch Button Section
        BlocBuilder<DevicesBloc, DevicesState>(
          builder: (context, state) {
            if (state is DevicesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DevicesError) {
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
            } else if (state is DevicesSuccess) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButton(
                        title: 'Is Automated',
                        textStyle: state.isAutomated
                            ? AppTextStyle.white()
                            : AppTextStyle.black(),
                        onTap: () {
                          context.read<DevicesBloc>().add(
                                ChangeDeviceAutomationStatus(
                                  status: !state.isAutomated,
                                ),
                              );
                        },
                        color: state.isAutomated
                            ? AppColor.primary
                            : AppColor.white,
                      ),
                      AppButton(
                        title: 'PIR Detection',
                        textStyle: state.pirDetectionStatus
                            ? AppTextStyle.white()
                            : AppTextStyle.black(),
                        onTap: () {
                          context.read<DevicesBloc>().add(
                                ChangePIRDetectionStatus(
                                  status: !state.pirDetectionStatus,
                                ),
                              );
                        },
                        color: state.pirDetectionStatus
                            ? AppColor.primary
                            : AppColor.white,
                      ),
                      // AppButton(title: 'Automated', textStyle: textStyle, onTap: onTap)
                      // Row(
                      //   children: [
                      //     Text(
                      //       'Is Automated : ',
                      //       style: AppTextStyle.black(
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //     ),
                      //     Text(
                      //       state.isAutomated.toString().toUpperCase(),
                      //       style: AppTextStyle.black(
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // InkWell(
                      //   onTap: () {
                      //     context.read<DevicesBloc>().add(
                      //           ChangeDeviceAutomationStatus(
                      //             status: !state.isAutomated,
                      //           ),
                      //         );
                      //   },
                      //   child: Text(
                      //     'Toggle here',
                      //     style: AppTextStyle.blue(),
                      //   ),
                      // ),
                    ],
                  ),
                  const SpaceHeight(10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ComponentRemote(
                        svgPath: "assets/icons/ac.svg",
                        title: "Air Conditioner",
                        isActive: state.airConditioner.isActive == true,
                        fontSize: 12.0,
                        svgHeight: 60,
                        svgWidth: 80,
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: MediaQuery.of(context).size.width / 2.3,
                        onSwitch: (val) => val == true
                            ? context.read<DevicesBloc>().add(TurnOnAC())
                            : context.read<DevicesBloc>().add(TurnOffAC()),
                      ),
                      ComponentRemote(
                        svgPath: "assets/icons/lamp.svg",
                        title: "Lamp",
                        isActive: state.lamp.isActive == true,
                        fontSize: 12.0,
                        svgHeight: 60,
                        svgWidth: 80,
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: MediaQuery.of(context).size.width / 2.3,
                        onSwitch: (val) => val == true
                            ? context.read<DevicesBloc>().add(TurnOnLamp())
                            : context.read<DevicesBloc>().add(TurnOffLamp()),
                      ),
                    ],
                  ),
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),

        //? Schedule Section
        const SpaceHeight(12.0),
        Text(
          'Room Schedule',
          style: AppTextStyle.black(fontSize: 16.0),
        ),
        const SpaceHeight(8.0),

        //! Use BlocListner of ClassroomBloc,
        //! If classroom data is loaded then store the schedule data
        //! Into the schedule bloc
        BlocBuilder<ScheduleBloc, ScheduleState>(
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
              List<ScheduleDetail> scheduleDetail =
                  state.schedules[_scheduleIndex.value].schedules;

              return ValueListenableBuilder(
                valueListenable: _scheduleIndex,
                builder: (context, value, child) => Column(
                  children: [
                    //? Row That Handles DaysOfWeek
                    Row(
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

                    //? Column that handle specific schedule data
                    const SpaceHeight(10.0),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: scheduleDetail.length,
                      itemBuilder: (context, index) => ScheduleTile(
                        startDate: scheduleDetail[index].startTime,
                        endDate: scheduleDetail[index].endTime,
                        description: scheduleDetail[index].description,
                      ),
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

        //? Access Log Section
        const SpaceHeight(8.0),
        Text(
          'Access Log',
          style: AppTextStyle.black(fontSize: 16.0),
        ),
        const SpaceHeight(8.0),

        BlocBuilder<AccessLogBloc, AccessLogState>(
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
              var logs = state.logs;

              return SizedBox(
                height: MediaQuery.of(context).size.height / 14 * 8,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // length is intentionally setted to 6, for full detailed access log, access setting page
                  itemCount: logs.length > 6 ? 6 : logs.length,
                  itemBuilder: (context, index) => AccessLogTile(
                    username: logs[index].username,
                    description: logs[index].action,
                    operationTime: logs[index].operationTime,
                  ),
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }
}
