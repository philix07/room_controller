import 'package:aplikasi_kontrol_kelas/common/components/app_scaffold.dart';
import 'package:aplikasi_kontrol_kelas/models/user.dart';
import 'package:aplikasi_kontrol_kelas/presentation/auth/forgot_password_page.dart';
import 'package:aplikasi_kontrol_kelas/presentation/auth/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../common/components/app_button.dart';
import '../../common/components/spaces.dart';
import '../../common/style/app_style.dart';
import '../../common/utils/app_form_validator.dart';
import 'widgets/auth_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formValidator = AppFormValidator();

    var userRole = context.read<AuthBloc>().appUser.role;
    // var isAdmin = userRole == UserRole.admin ? true : false;
    var isAdmin = true;

    return AppScaffold(
      padding: const EdgeInsets.all(0),
      child: Form(
        key: formValidator.formState,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              // TODO Missing Logo Assets
              // const CircleAvatar(
              //   radius: 55.0,
              //   backgroundImage: AssetImage('assets/images/logo_apk_2.png'),
              // ),
              const SpaceHeight(20.0),
              AuthTextField(
                title: 'EMAIL',
                iconPath: 'assets/icons/email.svg',
                inputFormatters: AppFormValidator().acceptAll(),
                validator: (val) {
                  return formValidator.validateEmail(val);
                },
                controller: emailController,
              ),
              AuthTextField(
                title: 'PASSWORD',
                iconPath: 'assets/icons/lock.svg',
                inputFormatters: AppFormValidator().wordAndNumber(),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                controller: passwordController,
                obscureText: true,
              ),
              InkWell(
                onTap: () {
                  //! Trigger Forgot Password Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordPage(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 5.0, 20.0),
                  width: double.maxFinite,
                  child: Text(
                    "Forgot Password ?",
                    textAlign: TextAlign.end,
                    style: AppTextStyle.darkBrown(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              AppButton(
                width: double.maxFinite,
                title: "LOGIN",
                textStyle: AppTextStyle.white(),
                onTap: () {
                  //! Validate Input And Trigger Login Event
                  if (formValidator.formState.currentState!.validate()) {
                    context.read<AuthBloc>().add(AuthLogin(
                          email: emailController.text,
                          password: passwordController.text,
                        ));
                  }
                },
              ),
              const SpaceHeight(5.0),
              isAdmin
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SpaceWidth(5.0),
                        Text(
                          "Don't have an account? ",
                          style: AppTextStyle.black(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            "create a new account",
                            style: AppTextStyle.darkBrown(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
