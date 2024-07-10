import 'package:aplikasi_kontrol_kelas/common/components/spaces.dart';
import 'package:aplikasi_kontrol_kelas/common/style/app_style.dart';
import 'package:aplikasi_kontrol_kelas/presentation/setting/setting_detail_page.dart';
import 'package:flutter/material.dart';

import '../../common/components/app_nav_bar.dart';
import '../../common/components/app_scaffold.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      withAppBar: true,
      appBarTitle: "Settings",
      actions: AppNavBar.get(context),
      child: Column(
        children: [
          //? Select Classroom Row
          Row(
            children: [
              Text(
                'Select classroom',
                style: AppTextStyle.black(),
              ),
              const SpaceWidth(10.0),
              Text(
                'Combo Box Here',
                style: AppTextStyle.black(),
              ),
            ],
          ),

          //? Settings Information Detail All Goes Here
          const SettingDetailPage(),
        ],
      ),
    );
  }
}
