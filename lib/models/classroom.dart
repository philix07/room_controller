// ignore_for_file: public_member_api_docs, sort_constructors_first
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
      'id': id,
      'name': name,
      'logs': logsMap,
      'devices': devicesMap,
      'schedules': scheduleMap,
    };
  }

  factory Classroom.fromMap(Map<String, dynamic> map) {
    return Classroom(
      id: map['id'] as String,
      name: map['name'] as String,
      logs: List<AccessLog>.from(
        (map['logs'] as List<int>).map<AccessLog>(
          (x) => AccessLog.fromMap(x as Map<String, dynamic>),
        ),
      ),
      schedules: List<Schedule>.from(
        (map['schedules'] as List<int>).map<Schedule>(
          (x) => Schedule.fromMap(x as Map<String, dynamic>),
        ),
      ),
      devices: List<Device>.from(
        (map['devices'] as List<int>).map<Device>(
          (x) => Device.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Classroom.fromJson(String source) =>
      Classroom.fromMap(json.decode(source) as Map<String, dynamic>);

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
