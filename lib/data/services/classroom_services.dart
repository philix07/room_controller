import 'package:aplikasi_kontrol_kelas/models/classroom.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';

class ClassroomService {
  final _dbRef = FirebaseDatabase.instance.ref();
  late final _classroomRef = _dbRef.child("classrooms");

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

  Future<Either<String, List<Classroom>>> fetchClassData() async {
    try {
      List<Classroom> classrooms = [];

      var result = await _classroomRef.get();
      return Right(classrooms);
    } catch (e) {
      // ignore: avoid_print
      print('Error Occured: ${e.toString()}');
      return const Left('Failed Add Classroom Data');
    }
  }
}
