import 'package:aplikasi_kontrol_kelas/common/components/app_nav_bar.dart';
import 'package:aplikasi_kontrol_kelas/common/components/app_scaffold.dart';
import 'package:aplikasi_kontrol_kelas/models/classroom.dart';
import 'package:aplikasi_kontrol_kelas/models/room_condition.dart';
import 'package:aplikasi_kontrol_kelas/presentation/auth/auth_page.dart';
import 'package:aplikasi_kontrol_kelas/presentation/auth/login_page.dart';
import 'package:aplikasi_kontrol_kelas/presentation/home/classroom_detail_page.dart';
import 'package:aplikasi_kontrol_kelas/presentation/home/widgets/classroom_nav_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../common/components/app_dialog.dart';
import '../../data/services/classroom_services.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ClassroomService services = ClassroomService();
    services.fetchClassData();
  }

  //! -------------------

  Classroom classroom = Classroom.dummy();

  int _classroomIndex = 0;
  void swapIndex(int index) {
    setState(() {
      _classroomIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const AppScaffold(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is AuthLoggedOut) {
          return const AuthManagerPage();
        } else if (state is AuthError) {
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
        } else if (state is AuthLoggedIn) {
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
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return ClassroomNavButton(
                        title: 'Classroom ${index + 1}',
                        isActive: _classroomIndex == index,
                        onTap: () {
                          swapIndex(index);
                        },
                      );
                    },
                  ),
                ),
                ClassroomDetailPage(classroom: classroom),
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
