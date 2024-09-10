import 'package:aplikasi_kontrol_kelas/blocs/devices/devices_bloc.dart';
import 'package:aplikasi_kontrol_kelas/models/access_log.dart';
import 'package:aplikasi_kontrol_kelas/models/classroom.dart';
import 'package:aplikasi_kontrol_kelas/models/device.dart';
import 'package:aplikasi_kontrol_kelas/models/schedule.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';

class ClassroomService {
  final _classroomRef = FirebaseDatabase.instance.ref('classrooms');

  //!-------------------- Classroom Dataclass Section --------------------------
  //!---------------------------------------------------------------------------
  Future<Either<String, Classroom>> addClassroomData(
      Classroom classroom) async {
    try {
      await _classroomRef.child(classroom.id).update(classroom.toMap());
      return Right(classroom);
    } catch (e) {
      // ignore: avoid_print
      print('Error Occured: ${e.toString()}');
      return const Left('Failed Add Classroom Data');
    }
  }

  Future<Either<String, List<Classroom>>> fetchClassroomData() async {
    try {
      List<Classroom> classrooms = [];

      var snapshot = await _classroomRef.get();
      var snapshotData = Map<String, dynamic>.from(snapshot.value as Map);

      snapshotData.forEach((key, value) {
        var classroom = Classroom.fromMap(
          Map<String, dynamic>.from(value as Map),
          key,
        );
        classrooms.add(classroom);
      });

      return Right(classrooms);
    } catch (e) {
      // ignore: avoid_print
      print('Error Occured: ${e.toString()}');
      return const Left('Failed Add Classroom Data');
    }
  }

  //!-------------------- Devices Dataclass Section -------------------------
  //!---------------------------------------------------------------------------
  Future<Either<String, bool>> toggleLamp(
    String crID,
    bool lampState,
  ) async {
    try {
      await _classroomRef.child("$crID/lamp/isActive").set(lampState);

      return Right(lampState);
    } catch (e) {
      // ignore: avoid_print
      print('Error Occured: ${e.toString()}');
      return const Left("Failed To Switch Lamp's Power Button");
    }
  }

  Future<Either<String, bool>> toggleAirCon(
    String crID,
    bool airConState,
  ) async {
    try {
      await _classroomRef
          .child("$crID/airConditioner/isActive")
          .set(airConState);

      return Right(airConState);
    } catch (e) {
      // ignore: avoid_print
      print('Error Occured: ${e.toString()}');
      return const Left("Failed To Switch Air Conditioner's Power Button");
    }
  }

  Future<Either<String, int>> setAirConTemp(
    String crID,
    int newTemperature,
  ) async {
    try {
      await _classroomRef
          .child("$crID/airConditioner/temperature")
          .set(newTemperature);

      return Right(newTemperature);
    } catch (e) {
      // ignore: avoid_print
      print('Error Occured: ${e.toString()}');
      return const Left("Failed To Change Air Conditioner's Temperature");
    }
  }

  Future<Either<String, int>> setAirConFan(
    String crID,
    int newFanSpeed,
  ) async {
    try {
      await _classroomRef
          .child("$crID/airConditioner/fanSpeed")
          .set(newFanSpeed);

      return Right(newFanSpeed);
    } catch (e) {
      // ignore: avoid_print
      print('Error Occured: ${e.toString()}');
      return const Left("Failed To Change Air Conditioner's Fan Speed");
    }
  }

  //!-------------------- Schedule Dataclass Section ---------------------------
  //!---------------------------------------------------------------------------
  Future<Either<String, Schedule>> addSchedule(
    String crID,
    Schedule newSchedule,
    Days daysOfWeek,
  ) async {
    try {
      await _classroomRef
          .child("$crID/schedules/${daysOfWeek.value}")
          .update(newSchedule.toMap());

      return Right(newSchedule);
    } catch (e) {
      // ignore: avoid_print
      print('Error Occured: ${e.toString()}');
      return const Left('Failed To Add New Schedule');
    }
  }

  //!-------------------- Access Log Dataclass Section -------------------------
  //!---------------------------------------------------------------------------
  Future<Either<String, AccessLog>> addAccessLog(
    String crID,
    AccessLog log,
    int index,
  ) async {
    try {
      await _classroomRef.child("$crID/logs/$index").set(log.toMap());

      return Right(log);
    } catch (e) {
      return const Left('Failed To Add New AccessLog');
    }
  }
}
