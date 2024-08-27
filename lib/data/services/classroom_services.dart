import 'package:aplikasi_kontrol_kelas/models/classroom.dart';
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

  //!-------------------- Schedule Dataclass Section ---------------------------
  //!---------------------------------------------------------------------------
  Future<Either<String, Schedule>> addSchedule(
    String classroomID,
    Schedule newSchedule,
    Days daysOfWeek,
  ) async {
    try {
      await _classroomRef
          .child("$classroomID/schedules/${daysOfWeek.value}")
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
}
