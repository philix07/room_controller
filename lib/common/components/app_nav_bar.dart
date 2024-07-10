import 'package:aplikasi_kontrol_kelas/common/components/spaces.dart';
import 'package:aplikasi_kontrol_kelas/common/style/app_colors.dart';
import 'package:aplikasi_kontrol_kelas/common/style/app_style.dart';
import 'package:aplikasi_kontrol_kelas/presentation/home/homepage.dart';
import 'package:aplikasi_kontrol_kelas/presentation/profile/profile_page.dart';
import 'package:aplikasi_kontrol_kelas/presentation/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconly/iconly.dart';

class AppNavBar {

  static List<Widget> get(BuildContext context) {    
    return <Widget>[
      PopupMenuButton<String>(
        icon: SvgPicture.asset(
          "assets/icons/drawer-menu.svg",
          colorFilter: const ColorFilter.mode(AppColor.black, BlendMode.srcIn),
        ),
        onSelected: (value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                if (value == 'homepage') {
                  return const Homepage();
                } else if (value == 'settings') {
                  return const SettingPage();
                }
                return const ProfilePage();
              },
            ),
          );
        },
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              value: 'homepage',
              child: Row(
                children: [
                  const Icon(IconlyLight.home),
                  const SpaceWidth(10.0),
                  Text(
                    'Home',
                    style: AppTextStyle.black(),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'settings',
              child: Row(
                children: [
                  const Icon(IconlyLight.setting),
                  const SpaceWidth(10.0),
                  Text(
                    'Settings',
                    style: AppTextStyle.black(),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'profile-page',
              child: Row(
                children: [
                  const Icon(IconlyLight.profile),
                  const SpaceWidth(10.0),
                  Text(
                    'Profile',
                    style: AppTextStyle.black(),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    ];
  }
}
