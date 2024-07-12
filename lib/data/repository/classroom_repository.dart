import 'package:aplikasi_kontrol_kelas/data/services/classroom_services.dart';
import 'package:aplikasi_kontrol_kelas/models/classroom.dart';
import 'package:dartz/dartz.dart';

class ClassroomRepository {
  final _crService = ClassroomService();

  Future<Either<String, List<Classroom>>> fetchClassroomData() async {
    var result = await _crService.fetchClassroomData();

    bool isError = false;
    String message = "";
    List<Classroom> classroomData = [];

    result.fold((errorMessage) {
      isError = true;
      message = errorMessage;
    }, (data) {
      classroomData = data;
    });

    if (isError) return Left(message);
    return Right(classroomData);
  }
}
