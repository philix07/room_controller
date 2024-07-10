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
  final List<Device> devices;

  Classroom({
    required this.id,
    required this.name,
    required this.logs,
    required this.schedules,
    required this.devices,
  });

  factory Classroom.dummy() {
    List<AccessLog> logs = [
      AccessLog(
        id: '1',
        device: Devices.lamp.name,
        action: 'Turn On Lamp',
        username: 'Felix',
      ),
      AccessLog(
        id: '2',
        device: Devices.lamp.name,
        action: 'Turn Of Lamp',
        username: 'Felix',
      ),
      AccessLog(
        id: '3',
        device: Devices.lamp.name,
        action: 'Turn On Lamp',
        username: 'Felix',
      ),
    ];

    List<Schedule> schedules = Schedule.getDummyListOfSchedule();

    List<Device> devices = [
      Device(isActive: true, device: Devices.lamp),
      Device(isActive: false, device: Devices.airConditioner),
    ];

    var crData = Classroom(
      id: '123',
      name: 'F.A 4.1',
      logs: logs,
      schedules: schedules,
      devices: devices,
    );

    return crData;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> devicesMap = {
      for (var device in devices) device.device.name: device.toMap()
    };

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
      'devices': devicesMap,
      'schedules': scheduleMap,
    };
  }

  factory Classroom.fromMap(Map<String, dynamic> map, String id) {
    List<dynamic> rawAccessLogs = map['logs'] as List;
    List<AccessLog> logs = rawAccessLogs
        .where((e) => e != null)
        .map((e) => AccessLog.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList();
    print('classroom.dart : access log successfully fetched');

    List<Device> devices = [];
    var rawDevices = Map<String, dynamic>.from(map['devices'] as Map);
    rawDevices.forEach((key, value) {
      devices.add(Device.fromMap(Map<String, dynamic>.from(value)));
    });
    print('classroom.dart : device successfully fetched');

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

    schedules.forEach((element) {
      element.schedules.forEach((element) {
        print(element.toString());
      });
    });
    print('classroom.dart : schedules successfully fetched');

    return Classroom(
      id: id,
      name: map['name'] as String,
      logs: logs,
      schedules: schedules,
      devices: devices,
    );
  }

  String toJson() => json.encode(toMap());

  //! This Function Below Works Properly
  //! But It Serve As My Reference Only
  Map<String, dynamic> convertDevicesToJson(List<Device> devices) {
    final Map<String, dynamic> devicesMap = {};

    for (Device dv in devices) {
      devicesMap[dv.device.name] = dv.toMap();
    }

    return {'devices': devicesMap};
  }
}
