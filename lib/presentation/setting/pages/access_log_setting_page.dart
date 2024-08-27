// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:aplikasi_kontrol_kelas/models/classroom.dart';

class AccessLogSettingPage extends StatelessWidget {
  const AccessLogSettingPage({super.key, required this.classroom});

  final Classroom classroom;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('This is access log setting page'),
      ],
    );
  }
}
