import 'package:aplikasi_kontrol_kelas/blocs/air_conditioner/air_conditioner_bloc.dart';
import 'package:aplikasi_kontrol_kelas/blocs/classroom/classroom_bloc.dart';
import 'package:aplikasi_kontrol_kelas/common/components/app_button.dart';
import 'package:aplikasi_kontrol_kelas/common/components/spaces.dart';
import 'package:aplikasi_kontrol_kelas/common/style/app_colors.dart';
import 'package:aplikasi_kontrol_kelas/common/style/app_style.dart';
import 'package:aplikasi_kontrol_kelas/models/classroom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/components/app_dialog.dart';

class AirConSettingPage extends StatefulWidget {
  const AirConSettingPage({super.key, required this.classroom});

  final Classroom classroom;

  @override
  State<AirConSettingPage> createState() => _AirConSettingPageState();
}

class _AirConSettingPageState extends State<AirConSettingPage> {
  @override
  void initState() {
    super.initState();

    print('Triggering ac load');

    context
        .read<AirConBloc>()
        .add(AcLoad(airConditioner: widget.classroom.airConditioner));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AirConBloc, AirConState>(
      builder: (context, state) {
        if (state is AirConLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AirConError) {
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
        } else if (state is AirConSuccess) {
          var airConditioner = state.airConditioner;

          return Column(
            children: [
              SvgPicture.asset(
                'assets/icons/ac.svg',
                width: MediaQuery.of(context).size.width / 2,
                colorFilter: const ColorFilter.mode(
                  AppColor.black,
                  BlendMode.srcIn,
                ),
              ),
              Text(
                '${airConditioner.temperature}℃',
                style: AppTextStyle.black(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SpaceHeight(10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/snow.svg',
                    width: 40,
                    height: 40,
                    colorFilter: const ColorFilter.mode(
                      AppColor.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SpaceWidth(10.0),
                  Text(
                    'Cooling Mode',
                    style: AppTextStyle.black(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SpaceHeight(20.0),

              //? Temperature Button Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppIconButton(
                    color: AppColor.gray,
                    width: MediaQuery.of(context).size.width / 5,
                    height: 45,
                    child: SvgPicture.asset(
                      'assets/icons/minus.svg',
                      width: 70,
                      height: 70,
                      colorFilter: const ColorFilter.mode(
                        AppColor.black,
                        BlendMode.srcIn,
                      ),
                    ),
                    onTap: () {
                      //TODO: Trigger Decrease Temperature Event
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Temperature',
                      style: AppTextStyle.black(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  AppIconButton(
                    color: AppColor.gray,
                    width: MediaQuery.of(context).size.width / 6,
                    height: 40,
                    child: SvgPicture.asset(
                      'assets/icons/plus.svg',
                      width: 70,
                      height: 70,
                      colorFilter: const ColorFilter.mode(
                        AppColor.black,
                        BlendMode.srcIn,
                      ),
                    ),
                    onTap: () {
                      //TODO: Trigger Increase Temperature Event
                    },
                  ),
                ],
              ),

              Text('Fan Speed Icon Here'),
              //? Fan Speed Button Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppIconButton(
                    color: AppColor.background,
                    width: MediaQuery.of(context).size.width / 5,
                    height: 45,
                    child: SvgPicture.asset(
                      'assets/icons/minus.svg',
                      width: 70,
                      height: 70,
                      colorFilter: const ColorFilter.mode(
                        AppColor.black,
                        BlendMode.srcIn,
                      ),
                    ),
                    onTap: () {
                      //TODO: Trigger Decrease Temperature Event
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Fan Speed',
                      style: AppTextStyle.black(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  AppIconButton(
                    color: AppColor.background,
                    width: MediaQuery.of(context).size.width / 6,
                    height: 40,
                    child: SvgPicture.asset(
                      'assets/icons/plus.svg',
                      width: 70,
                      height: 70,
                      colorFilter: const ColorFilter.mode(
                        AppColor.black,
                        BlendMode.srcIn,
                      ),
                    ),
                    onTap: () {
                      //TODO: Trigger Increase Temperature Event
                    },
                  ),
                ],
              )
            ],
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
