import 'package:aplikasi_kontrol_kelas/models/classroom.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';

class ClassroomService {
  final _classroomRef = FirebaseDatabase.instance.ref('classrooms');

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

      var snapshot = await _classroomRef.get();
      var snapshotData = Map<String, dynamic>.from(snapshot.value as Map);
      snapshotData.forEach((key, value) {
        // print('DB Data: ${Map<String, dynamic>.from(value as Map)}');
        var classroom = Classroom.fromMap(
          Map<String, dynamic>.from(value as Map),
          key,
        );
        classrooms.add(classroom);

        print("Classroom data $classroom");
      });

      return Right(classrooms);
    } catch (e) {
      // ignore: avoid_print
      print('Error Occured: ${e.toString()}');
      return const Left('Failed Add Classroom Data');
    }
  }
}
