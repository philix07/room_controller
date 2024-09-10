// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'dart:convert';

import 'package:aplikasi_kontrol_kelas/models/access_log.dart';
import 'package:aplikasi_kontrol_kelas/models/device.dart';
import 'package:aplikasi_kontrol_kelas/models/schedule.dart';

class Classroom {
  final String id;
  final String name;
  final List<AccessLog> logs;
  final List<Schedule> schedules;
  final AirConditioner airConditioner;
  final Lamp lamp;

  Classroom({
    required this.id,
    required this.name,
    required this.logs,
    required this.schedules,
    required this.airConditioner,
    required this.lamp,
  });

  Map<String, dynamic> toMap() {
    // final devicesMap = devices.map((device) => device.toMap()).toList();

    final Map<String, dynamic> logsMap = {
      for (var log in logs) log.id: log.toMap()
    };

    //! Groups Schedule By Days Of Week
    Map<String, dynamic> scheduleMap = {
      'monday': [],
      'tuesday': [],
      'wednesday': [],
      'thursday': [],
      'friday': [],
      'saturday': [],
      'sunday': [],
    };

    for (var schedule in schedules) {
      for (var scheduleDetail in schedule.schedules) {
        if (scheduleMap.containsKey(scheduleDetail.dayOfWeek.value)) {
          scheduleMap[scheduleDetail.dayOfWeek.value]
              ?.add(scheduleDetail.toMap());
        }
      }
    }

    return <String, dynamic>{
      'name': name,
      'logs': logsMap,
      'schedules': scheduleMap,
      'airConditioner': airConditioner.toMap(),
      'lamp': lamp.toMap(),
    };
  }

  factory Classroom.fromMap(Map<String, dynamic> map, String id) {
    List<dynamic> rawAccessLogs = map['logs'] as List;
    List<AccessLog> logs = rawAccessLogs
        .where((e) => e != null)
        .map((e) => AccessLog.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList();
    print('classroom.dart : access log successfully fetched');

    //! Index Guide 0 is Monday - 6 is Sunday
    //! Getting All The Schedule Grouped By Days
    var rawSchedules = Map<String, dynamic>.from(map['schedules'] as Map);
    var mondaySchedule = Schedule.fromList(rawSchedules['monday']);
    var tuesdaySchedule = Schedule.fromList(rawSchedules['tuesday']);
    var wednesdaySchedule = Schedule.fromList(rawSchedules['wednesday']);
    var thursdaySchedule = Schedule.fromList(rawSchedules['thursday']);
    var fridaySchedule = Schedule.fromList(rawSchedules['friday']);
    var saturdaySchedule = Schedule.fromList(rawSchedules['saturday']);
    var sundaySchedule = Schedule.fromList(rawSchedules['sunday']);

    //! Order The Schedule By Index
    List<Schedule> schedules = [
      mondaySchedule,
      tuesdaySchedule,
      wednesdaySchedule,
      thursdaySchedule,
      fridaySchedule,
      saturdaySchedule,
      sundaySchedule,
    ];
    print('classroom.dart : schedules successfully fetched');

    return Classroom(
      id: id,
      name: map['name'] as String,
      logs: logs,
      schedules: schedules,
      airConditioner: AirConditioner.fromMap(
        Map<String, dynamic>.from(map['airConditioner']),
      ),
      lamp: Lamp.fromMap(Map<String, dynamic>.from(map['lamp'])),
    );
  }

  String toJson() => json.encode(toMap());

  //! This Function Below Works Properly
  //! But It Serve As My Reference Only
  Map<String, dynamic> convertDevicesToJson(List<Device> devices) {
    final Map<String, dynamic> devicesMap = {};

    for (Device dv in devices) {
      devicesMap[dv.name] = dv.toMap();
    }

    return {'devices': devicesMap};
  }

  factory Classroom.dummy() {
    List<AccessLog> logs = [
      AccessLog(
        id: '0',
        action: 'Turn On Lamp',
        username: 'Felix',
        operationTime: DateTime(2024, 07, 11, 12, 20, 11),
      ),
      AccessLog(
        id: '1',
        action: 'Turn Off Lamp',
        username: 'Felix',
        operationTime: DateTime(2024, 07, 11, 21, 06, 5),
      ),
      AccessLog(
        id: '2',
        action: 'Turn On Air Conditioner',
        username: 'Felix',
        operationTime: DateTime(2024, 07, 12, 12, 20, 11),
      ),
    ];

    List<Schedule> schedules = Schedule.getDummyListOfSchedule();

    AirConditioner airConditioner = AirConditioner(
      id: '1',
      name: 'Air Conditioner',
      isActive: true,
      temperature: 24,
      fanSpeed: 3,
    );

    Lamp lamp = Lamp(
      id: '1',
      name: 'Lamp',
      isActive: false,
    );

    var crData = Classroom(
      id: '123',
      name: 'F.A 4.1',
      logs: logs,
      schedules: schedules,
      airConditioner: airConditioner,
      lamp: lamp,
    );

    return crData;
  }

  factory Classroom.dummy2() {
    List<AccessLog> logs = [
      AccessLog(
        id: '0',
        action: 'Turn Off Lamp',
        username: 'Felix',
        operationTime: DateTime(2024, 07, 11, 12, 11, 5),
      ),
      AccessLog(
        id: '1',
        action: 'Turn On Lamp',
        username: 'Felix',
        operationTime: DateTime(2024, 07, 11, 21, 17, 2),
      ),
      AccessLog(
        id: '2',
        action: 'Turn On Air Conditioner',
        username: 'Felix',
        operationTime: DateTime(2024, 07, 11, 16, 20, 11),
      ),
    ];

    List<Schedule> schedules = Schedule.getDummyListOfSchedule();

    AirConditioner airConditioner = AirConditioner(
      id: '1',
      name: 'AirConditioner',
      isActive: false,
      temperature: 17,
      fanSpeed: 4,
    );

    Lamp lamp = Lamp(
      id: '1',
      name: 'Lamp',
      isActive: true,
    );

    var crData = Classroom(
      id: '124',
      name: 'F.A 4.2',
      logs: logs,
      schedules: schedules,
      airConditioner: airConditioner,
      lamp: lamp,
    );

    return crData;
  }
}
