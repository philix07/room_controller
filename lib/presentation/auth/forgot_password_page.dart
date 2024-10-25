import 'package:aplikasi_kontrol_kelas/blocs/auth/auth_bloc.dart';
import 'package:aplikasi_kontrol_kelas/common/components/app_button.dart';
import 'package:aplikasi_kontrol_kelas/common/components/app_dialog.dart';
import 'package:aplikasi_kontrol_kelas/common/components/app_scaffold.dart';
import 'package:aplikasi_kontrol_kelas/common/components/app_text_field.dart';
import 'package:aplikasi_kontrol_kelas/common/components/spaces.dart';
import 'package:aplikasi_kontrol_kelas/common/style/app_colors.dart';
import 'package:aplikasi_kontrol_kelas/common/style/app_style.dart';
import 'package:aplikasi_kontrol_kelas/common/utils/app_form_validator.dart';
import 'package:aplikasi_kontrol_kelas/presentation/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  final appValidator = AppFormValidator();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AuthError) {
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
          } else if (state is AuthLoggedIn) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: AppTextField(
                    controller: emailController,
                    labelText: 'Input Email',
                    inputFormatter: appValidator.acceptAll(),
                    validator: (val) => appValidator.validateEmail(val),
                  ),
                ),
                const SpaceHeight(10.0),
                AppButton(
                  color: AppColor.gray,
                  title: 'Send Link',
                  textStyle: AppTextStyle.black(),
                  onTap: () {
                    //TODO: Send Reset Password Link
                    context.read<AuthBloc>().add(
                          AuthChangePassword(
                            email: emailController.text,
                          ),
                        );

                    AppDialog.show(
                      context,
                      contentColor: AppColor.blue,
                      iconPath: 'assets/icons/information.svg',
                      message: 'Link Sent',
                      customOnBack: true,
                      onBack: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ],
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AppTextField(
                  controller: emailController,
                  labelText: 'Input Email',
                  inputFormatter: appValidator.acceptAll(),
                  validator: (val) => appValidator.validateEmail(val),
                ),
              ),
              const SpaceHeight(10.0),
              AppButton(
                color: AppColor.gray,
                title: 'Send Link',
                textStyle: AppTextStyle.black(),
                onTap: () {
                  //TODO: Send Reset Password Link
                  context.read<AuthBloc>().add(
                        AuthChangePassword(
                          email: emailController.text,
                        ),
                      );

                  AppDialog.show(
                    context,
                    contentColor: AppColor.blue,
                    iconPath: 'assets/icons/information.svg',
                    message: 'Link Sent',
                    customOnBack: true,
                    onBack: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
