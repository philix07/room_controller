// ignore_for_file: avoid_print

import 'package:aplikasi_kontrol_kelas/blocs/auth/auth_bloc.dart';
import 'package:aplikasi_kontrol_kelas/common/components/app_button.dart';
import 'package:aplikasi_kontrol_kelas/common/components/app_scaffold.dart';
import 'package:aplikasi_kontrol_kelas/common/components/spaces.dart';
import 'package:aplikasi_kontrol_kelas/common/style/app_style.dart';
import 'package:aplikasi_kontrol_kelas/presentation/auth/auth_page.dart';
import 'package:aplikasi_kontrol_kelas/presentation/auth/register_page.dart';
import 'package:aplikasi_kontrol_kelas/presentation/profile/pages/change_password_page.dart';
import 'package:aplikasi_kontrol_kelas/presentation/profile/pages/my_access_log_page.dart';
import 'package:aplikasi_kontrol_kelas/presentation/profile/widgets/text_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/components/app_nav_bar.dart';
import '../../models/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var userRole = context.read<AuthBloc>().appUser.role;
    var isAdmin = userRole == UserRole.admin ? true : false;

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
        } else if (state is AuthLoggedIn) {
          return AppScaffold(
            withAppBar: true,
            appBarTitle: "Profile",
            isScrollable: false,
            actions: AppNavBar.get(context),
            child: Column(
              children: [
                TextDescripton(
                  title: 'Username',
                  subtitle: state.user.username,
                ),
                const SpaceHeight(10.0),
                TextDescripton(
                  title: 'Email',
                  subtitle: state.user.email,
                ),
                const SpaceHeight(10.0),
                TextDescripton(
                  title: 'User Role',
                  subtitle: state.user.role.value,
                ),
                const SpaceHeight(10.0),

                // Create A Middle Space
                Expanded(child: Container()),

                AppButton(
                  width: double.maxFinite,
                  title: 'My Access Log',
                  textStyle: AppTextStyle.white(),
                  onTap: () {
                    // TODO Show All Current User's Access Log
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyAccecssLogPage(),
                      ),
                    );
                  },
                ),
                const SpaceHeight(10.0),
                AppButton(
                  width: double.maxFinite,
                  title: 'Change Password',
                  textStyle: AppTextStyle.white(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangePasswordPage(),
                      ),
                    );
                  },
                ),
                const SpaceHeight(10.0),
                isAdmin
                    ? AppButton(
                        width: double.maxFinite,
                        title: 'Create new account',
                        textStyle: AppTextStyle.white(),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                      )
                    : Container(),
                const SpaceHeight(10.0),

                AppButton(
                  width: double.maxFinite,
                  title: 'Log Out',
                  textStyle: AppTextStyle.white(),
                  onTap: () {
                    context.read<AuthBloc>().add(AuthLogOut());
                  },
                ),
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
