import 'package:aplikasi_kontrol_kelas/blocs/access_log/access_log_bloc.dart';
import 'package:aplikasi_kontrol_kelas/blocs/classroom/classroom_bloc.dart';
import 'package:aplikasi_kontrol_kelas/blocs/schedule/schedule_bloc.dart';
import 'package:aplikasi_kontrol_kelas/common/components/app_nav_bar.dart';
import 'package:aplikasi_kontrol_kelas/common/components/app_scaffold.dart';
import 'package:aplikasi_kontrol_kelas/data/services/classroom_services.dart';
import 'package:aplikasi_kontrol_kelas/models/classroom.dart';
import 'package:aplikasi_kontrol_kelas/presentation/home/classroom_detail_page.dart';
import 'package:aplikasi_kontrol_kelas/presentation/home/widgets/classroom_nav_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../common/components/app_dialog.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Classroom classroom = Classroom.dummy();

  int _classroomIndex = 0;
  void swapIndex(int index) {
    setState(() {
      _classroomIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<ClassroomBloc>().add(ClassroomFetchAll());
    // ClassroomService service = ClassroomService();
    // service.addClassroomData(Classroom.dummy());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassroomBloc, ClassroomState>(
      builder: (context, state) {
        if (state is ClassroomLoading) {
          return const AppScaffold(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ClassroomError) {
          Future.delayed(
            const Duration(milliseconds: 100),
            () {
              AppDialog.show(
                context,
                iconPath: 'assets/icons/error.svg',
                message: state.message,
                customOnBack: true,
                onBack: () {
                  Navigator.pop(context);
                  context.read<AuthBloc>().add(AuthLogOut());
                },
              );
            },
          );
        } else if (state is ClassroomSuccess) {
          var crData = state.classrooms;

          //? Load Schedule Data
          context
              .read<ScheduleBloc>()
              .add(LoadSchedule(schedules: crData[_classroomIndex].schedules));

          //? Load Access Log Data
          context
              .read<AccessLogBloc>()
              .add(LoadAccessLog(logs: crData[_classroomIndex].logs));

          return AppScaffold(
            withAppBar: true,
            appBarTitle: "Classroom Controller",
            actions: AppNavBar.get(context),
            child: Column(
              children: [
                //? Room Selector, Later The Length Will
                //? Be Based On The Room Count
                SizedBox(
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
                ClassroomDetailPage(classroom: crData[_classroomIndex]),
              ],
            ),
          );
        }

        return const AppScaffold(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
