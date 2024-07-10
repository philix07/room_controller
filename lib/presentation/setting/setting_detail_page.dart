import 'package:aplikasi_kontrol_kelas/common/components/app_text_button.dart';
import 'package:flutter/material.dart';

class SettingDetailPage extends StatefulWidget {
  const SettingDetailPage({super.key});

  @override
  State<SettingDetailPage> createState() => _SettingDetailPageState();
}

class _SettingDetailPageState extends State<SettingDetailPage> {
  final ValueNotifier<int> _navIndex = ValueNotifier(0);

  void switchIndex(int index) {
    setState(() {
      _navIndex.value = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return AppTextButton(
                title: 'Classroom ${index + 1}',
                isActive: _navIndex.value == index,
                onTap: () {
                  switchIndex(index);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
