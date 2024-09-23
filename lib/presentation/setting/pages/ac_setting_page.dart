import 'package:aplikasi_kontrol_kelas/blocs/access_log/access_log_bloc.dart';
import 'package:aplikasi_kontrol_kelas/blocs/auth/auth_bloc.dart';
import 'package:aplikasi_kontrol_kelas/blocs/devices/devices_bloc.dart';
import 'package:aplikasi_kontrol_kelas/common/components/app_button.dart';
import 'package:aplikasi_kontrol_kelas/common/components/spaces.dart';
import 'package:aplikasi_kontrol_kelas/common/style/app_colors.dart';
import 'package:aplikasi_kontrol_kelas/common/style/app_style.dart';
import 'package:aplikasi_kontrol_kelas/models/access_log.dart';
import 'package:aplikasi_kontrol_kelas/models/classroom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/components/app_dialog.dart';

class AirConSettingPage extends StatefulWidget {
  const AirConSettingPage({super.key});

  @override
  State<AirConSettingPage> createState() => _AirConSettingPageState();
}

class _AirConSettingPageState extends State<AirConSettingPage> {
  @override
  void initState() {
    super.initState();

    print('Triggering device load');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DevicesBloc, DevicesState>(
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
          var airConditioner = state.airConditioner;
          var currentUser = context.read<AuthBloc>().appUser;

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
                    color: AppColor.gray.withOpacity(0.5),
                    width: MediaQuery.of(context).size.width / 6,
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
                      //TODO: Trigger Decrease Temperature Event Then Add Access Log
                      if (airConditioner.temperature > 16 &&
                          airConditioner.isActive) {
                        context.read<DevicesBloc>().add(AcTempDecrease());

                        var id = context.read<AccessLogBloc>().logs.length;
                        var log = AccessLog(
                          id: id.toString(),
                          action: "Decrease AC Temperature",
                          username: currentUser.username,
                          operationTime: DateTime.now(),
                        );

                        context
                            .read<AccessLogBloc>()
                            .add(AddAccessLog(accessLog: log));
                      } else if (!airConditioner.isActive) {
                        AppDialog.show(
                          context,
                          iconPath: 'assets/icons/information.svg',
                          message: "Air Conditioner is Turned Off",
                          contentColor: AppColor.blue,
                        );
                      } else if (airConditioner.temperature <= 16) {
                        AppDialog.show(
                          context,
                          iconPath: 'assets/icons/information.svg',
                          message: "Temperature Limit Reached",
                          contentColor: AppColor.blue,
                        );
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Temperature',
                      style: AppTextStyle.black(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  AppIconButton(
                    color: AppColor.gray.withOpacity(0.5),
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
                      if (airConditioner.temperature < 30 &&
                          airConditioner.isActive) {
                        context.read<DevicesBloc>().add(AcTempIncrease());

                        var id = context.read<AccessLogBloc>().logs.length;
                        var log = AccessLog(
                          id: id.toString(),
                          action: "Increase AC Temperature",
                          username: currentUser.username,
                          operationTime: DateTime.now(),
                        );

                        context
                            .read<AccessLogBloc>()
                            .add(AddAccessLog(accessLog: log));
                      } else if (!airConditioner.isActive) {
                        AppDialog.show(
                          context,
                          iconPath: 'assets/icons/information.svg',
                          message: "Air Conditioner is Turned Off",
                          contentColor: AppColor.blue,
                        );
                      } else if (airConditioner.temperature >= 30) {
                        AppDialog.show(
                          context,
                          iconPath: 'assets/icons/information.svg',
                          message: "Temperature Limit Reached",
                          contentColor: AppColor.blue,
                        );
                      }
                    },
                  ),
                ],
              ),

              const SpaceHeight(40.0),
              Text(
                'Fan Speed',
                style: AppTextStyle.black(fontSize: 24.0),
              ),
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
                      //TODO: Decrease Temperature Event
                      if (airConditioner.fanSpeed > 1 &&
                          airConditioner.isActive) {
                        context.read<DevicesBloc>().add(AcFanDecrease());

                        var id = context.read<AccessLogBloc>().logs.length;
                        var log = AccessLog(
                          id: id.toString(),
                          action: "Decrease AC Fan Speed",
                          username: currentUser.username,
                          operationTime: DateTime.now(),
                        );

                        context
                            .read<AccessLogBloc>()
                            .add(AddAccessLog(accessLog: log));
                      } else if (!airConditioner.isActive) {
                        AppDialog.show(
                          context,
                          iconPath: 'assets/icons/information.svg',
                          message: "Air Conditioner is Turned Off",
                          contentColor: AppColor.blue,
                        );
                      } else if (airConditioner.fanSpeed <= 1) {
                        AppDialog.show(
                          context,
                          iconPath: 'assets/icons/information.svg',
                          message: "Fan Speed Limit Reached",
                          contentColor: AppColor.blue,
                        );
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      airConditioner.fanSpeed.toString(),
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
                      //TODO: Increase Temperature Event
                      if (airConditioner.fanSpeed < 4 &&
                          airConditioner.isActive) {
                        context.read<DevicesBloc>().add(AcFanIncrease());

                        var id = context.read<AccessLogBloc>().logs.length;
                        var log = AccessLog(
                          id: id.toString(),
                          action: "Increase AC Fan Speed",
                          username: currentUser.username,
                          operationTime: DateTime.now(),
                        );

                        context
                            .read<AccessLogBloc>()
                            .add(AddAccessLog(accessLog: log));
                      } else if (!airConditioner.isActive) {
                        AppDialog.show(
                          context,
                          iconPath: 'assets/icons/information.svg',
                          message: "Air Conditioner is Turned Off",
                          contentColor: AppColor.blue,
                        );
                      } else if (airConditioner.fanSpeed >= 1) {
                        AppDialog.show(
                          context,
                          iconPath: 'assets/icons/information.svg',
                          message: "Fan Speed Limit Reached",
                          contentColor: AppColor.blue,
                        );
                      }
                    },
                  ),
                ],
              ),

              const SpaceHeight(20.0),
              InkWell(
                onTap: () => airConditioner.isActive
                    ? context.read<DevicesBloc>().add(TurnOffAC())
                    : context.read<DevicesBloc>().add(TurnOnAC()),
                child: Container(
                  width: 70,
                  height: 70,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: state.airConditioner.isActive
                        ? AppColor.lightGreen
                        : AppColor.lightRed, // Change color based on status
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/power.svg',
                    width: 70,
                    height: 100,
                    colorFilter: const ColorFilter.mode(
                      Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
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
