import 'package:aplikasi_kontrol_kelas/data/services/classroom_services.dart';
import 'package:aplikasi_kontrol_kelas/models/access_log.dart';
import 'package:aplikasi_kontrol_kelas/models/classroom.dart';
import 'package:dartz/dartz.dart';

import '../../models/schedule.dart';

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

  Future<Either<String, bool>> toggleAutomationStatus(
    String crID,
    bool isAutomated,
  ) async {
    var result = await _crService.toggleAutomationStatus(crID, isAutomated);

    bool isError = false;
    String message = "";
    bool isNewAutomated = isAutomated;

    result.fold((errorMessage) {
      isError = true;
      message = errorMessage;
    }, (data) {
      isNewAutomated = data;
    });

    if (isError) return Left(message);
    return Right(isNewAutomated);
  }

  Future<Either<String, bool>> togglePIRDetectionStatus(
    String crID,
    bool pirDetectionStatus,
  ) async {
    var result = await _crService.togglePIRDetectionStatus(
      crID,
      pirDetectionStatus,
    );

    bool isError = false;
    String message = "";
    bool newPIRDetectionStatus = pirDetectionStatus;

    result.fold((errorMessage) {
      isError = true;
      message = errorMessage;
    }, (data) {
      newPIRDetectionStatus = data;
    });

    if (isError) return Left(message);
    return Right(newPIRDetectionStatus);
  }

  //!-------------------- Devices Dataclass Section ----------------------------
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

  //!-------------------- Schedule Dataclass Section ---------------------------
  //!---------------------------------------------------------------------------
  Future<Either<String, Schedule>> updateSchedule(
    String crID,
    Schedule newSchedule,
    Days daysOfWeek,
  ) async {
    var result = await _crService.updateSchedule(crID, newSchedule, daysOfWeek);

    bool isError = false;
    String message = "";
    late Schedule schedule;

    result.fold((error) {
      message = error;
      isError = true;
    }, (data) {
      schedule = data;
    });

    if (isError) return Left(message);
    return Right(schedule);
  }

  //!-------------------- Access Log Dataclass Section -------------------------
  //!---------------------------------------------------------------------------
  Future<Either<String, AccessLog>> addAccessLog(
    String crID,
    AccessLog log,
    int index,
  ) async {
    var result = await _crService.addAccessLog(crID, log, index);

    bool isError = false;
    String message = "";
    late AccessLog newLog;

    result.fold((errorMessage) {
      isError = true;
      message = errorMessage;
    }, (data) {
      newLog = data;
    });

    if (isError) return Left(message);
    return Right(newLog);
  }
}
