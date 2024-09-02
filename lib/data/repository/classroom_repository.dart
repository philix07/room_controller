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

  //!-------------------- Devices Dataclass Section -------------------------
  //!---------------------------------------------------------------------------
  Future<Either<String, bool>> toggleLamp(
    String crID,
    bool lampState,
  ) async {
    var result = await _crService.toggleLamp(crID, lampState);

    bool isError = false;
    String message = "";
    bool newState = lampState;

    result.fold((errorMessage) {
      isError = true;
      message = errorMessage;
    }, (data) {
      newState = data;
    });

    if (isError) return Left(message);
    return Right(newState);
  }

  Future<Either<String, bool>> toggleAirCon(
    String crID,
    bool airConState,
  ) async {
    var result = await _crService.toggleAirCon(crID, airConState);

    bool isError = false;
    String message = "";
    bool newState = airConState;

    result.fold((errorMessage) {
      isError = true;
      message = errorMessage;
    }, (data) {
      newState = data;
    });

    if (isError) return Left(message);
    return Right(newState);
  }

  Future<Either<String, int>> setAirConTemp(
    String crID,
    int newTemperature,
  ) async {
    var result = await _crService.setAirConTemp(crID, newTemperature);

    bool isError = false;
    String message = "";
    int newTemp = 0;

    result.fold((errorMessage) {
      isError = true;
      message = errorMessage;
    }, (data) {
      newTemp = data;
    });

    if (isError) return Left(message);
    return Right(newTemp);
  }

  Future<Either<String, int>> setAirConFan(
    String crID,
    int newFanSpeed,
  ) async {
    var result = await _crService.setAirConFan(crID, newFanSpeed);

    bool isError = false;
    String message = "";
    int newFan = 0;

    result.fold((errorMessage) {
      isError = true;
      message = errorMessage;
    }, (data) {
      newFan = data;
    });

    if (isError) return Left(message);
    return Right(newFan);
  }
}
