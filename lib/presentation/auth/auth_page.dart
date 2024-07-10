import 'package:aplikasi_kontrol_kelas/presentation/auth/login_page.dart';
import 'package:aplikasi_kontrol_kelas/presentation/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../common/components/app_dialog.dart';
import '../../common/components/app_scaffold.dart';

class AuthManagerPage extends StatefulWidget {
  const AuthManagerPage({super.key});

  @override
  State<AuthManagerPage> createState() => _AuthManagerPageState();
}

class _AuthManagerPageState extends State<AuthManagerPage> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoggedOut) {
          return const LoginPage();
        } else if (state is AuthLoggedIn) {
          return const Homepage();
        } else if (state is AuthLoading) {
          return const AppScaffold(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
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
        }

        return AppScaffold(
          child: Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
