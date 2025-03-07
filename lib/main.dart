import 'package:aplikasi_kontrol_kelas/blocs/access_log/access_log_bloc.dart';
import 'package:aplikasi_kontrol_kelas/blocs/auth/auth_bloc.dart';
import 'package:aplikasi_kontrol_kelas/blocs/classroom/classroom_bloc.dart';
import 'package:aplikasi_kontrol_kelas/blocs/devices/devices_bloc.dart';
import 'package:aplikasi_kontrol_kelas/blocs/schedule/schedule_bloc.dart';
import 'package:aplikasi_kontrol_kelas/presentation/auth/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aplikasi_kontrol_kelas/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.setSettings(
    appVerificationDisabledForTesting: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => ScheduleBloc()),
        BlocProvider(create: (_) => AccessLogBloc()),
        BlocProvider(create: (_) => ClassroomBloc()),
        BlocProvider(create: (_) => DevicesBloc()),
      ],
      child: const MaterialApp(
        title: 'Controller Kelas',
        debugShowCheckedModeBanner: false,
        home: AuthManagerPage(),
      ),
    );
  }
}
