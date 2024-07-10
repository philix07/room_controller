import 'package:aplikasi_kontrol_kelas/models/access_log.dart';
import 'package:aplikasi_kontrol_kelas/models/classroom.dart';
import 'package:aplikasi_kontrol_kelas/models/device.dart';
import 'package:aplikasi_kontrol_kelas/models/schedule.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';

class ClassroomService {
  final _dbRef = FirebaseDatabase.instance.ref();
  late final _classroomRef = _dbRef.child("classrooms");

  Future<void> testing() async {
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

    List<ScheduleDetail> mondaySchedule = [
      ScheduleDetail(
        dayOfWeek: Days.monday,
        startTime: DateTime.now(),
        endTime: DateTime.now(),
      ),
      ScheduleDetail(
        dayOfWeek: Days.monday,
        startTime: DateTime.now(),
        endTime: DateTime.now(),
      ),
    ];

    List<ScheduleDetail> tuesdaySchedule = [
      ScheduleDetail(
        dayOfWeek: Days.tuesday,
        startTime: DateTime.now(),
        endTime: DateTime.now(),
      ),
      ScheduleDetail(
        dayOfWeek: Days.tuesday,
        startTime: DateTime.now(),
        endTime: DateTime.now(),
      ),
    ];

    List<Schedule> schedules = [
      Schedule(schedules: mondaySchedule),
      Schedule(schedules: tuesdaySchedule),
    ];

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

    // await _classroomRef.child("classroom1").set(crData.toMap());
    await addClassData(crData);
  }

  //!-------------------- Classroom Dataclass Section
  Future<Either<String, Classroom>> addClassData(Classroom classroom) async {
    try {
      await _classroomRef.child(classroom.id).update(classroom.toMap());
      return Right(classroom);
    } catch (e) {
      // ignore: avoid_print
      print('Error Occured: ${e.toString()}');

      return const Left('Failed Add Classroom Data');
    }
  }
}
