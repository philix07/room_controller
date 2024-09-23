import 'package:aplikasi_kontrol_kelas/common/components/app_text_button.dart';
import 'package:aplikasi_kontrol_kelas/common/components/spaces.dart';
import 'package:aplikasi_kontrol_kelas/models/classroom.dart';
import 'package:aplikasi_kontrol_kelas/presentation/setting/pages/ac_setting_page.dart';
import 'package:aplikasi_kontrol_kelas/presentation/setting/pages/access_log_setting_page.dart';
import 'package:aplikasi_kontrol_kelas/presentation/setting/pages/schedule_setting_page.dart';
import 'package:flutter/material.dart';

import '../../../common/style/app_colors.dart';

class SettingDetailPage extends StatefulWidget {
  const SettingDetailPage({super.key, required this.classroom});

  final Classroom classroom;

  @override
  State<SettingDetailPage> createState() => _SettingDetailPageState();
}

class _SettingDetailPageState extends State<SettingDetailPage> {
  int _navIndex = 0;
  void switchIndex(int index) {
    setState(() {
      _navIndex = index;
    });
  }

  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();

    pages = [
      const AirConSettingPage(),
      const ScheduleSettingPage(),
      const AccessLogSettingPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppTextButton(
              title: 'Air Conditioner',
              isActive: _navIndex == 0,
              onTap: () {
                switchIndex(0);
              },
            ),
            AppTextButton(
              title: 'Schedule',
              isActive: _navIndex == 1,
              onTap: () {
                switchIndex(1);
              },
            ),
            AppTextButton(
              title: 'Access Log',
              isActive: _navIndex == 2,
              onTap: () {
                switchIndex(2);
              },
            ),
          ],
        ),
        const Divider(
          color: AppColor.black,
          thickness: 1,
        ),
        const SpaceHeight(10.0),
        pages[_navIndex],
        const SpaceHeight(40.0),
      ],
    );
  }
}
