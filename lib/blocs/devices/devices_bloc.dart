import 'package:aplikasi_kontrol_kelas/data/repository/classroom_repository.dart';
import 'package:aplikasi_kontrol_kelas/models/device.dart';
import 'package:aplikasi_kontrol_kelas/presentation/setting/pages/ac_setting_page.dart';
import 'package:bloc/bloc.dart';

part 'devices_event.dart';
part 'devices_state.dart';

class DevicesBloc extends Bloc<DevicesEvent, DevicesState> {
  final _crRepository = ClassroomRepository();
  late AirConditioner airConditioner;
  late Lamp lamp;
  late String crID;
  late bool isAutomated;

  DevicesBloc() : super(DevicesInitial()) {
    on<LoadDevice>((event, emit) async {
      emit(DevicesLoading());

      airConditioner = event.airConditioner;
      lamp = event.lamp;
      crID = event.crID;
      isAutomated = event.isAutomated;

      print("Current air conditioner state:");
      print("temp ${airConditioner.temperature}");
      print("fan speed ${airConditioner.fanSpeed}");
      print("activation status ${airConditioner.isActive}");
      print("Current lamp state : ${lamp.isActive}");

      emit(DevicesSuccess(
        airConditioner: airConditioner,
        lamp: lamp,
        isAutomated: isAutomated,
      ));
    });

    //!

    on<ChangeDeviceAutomationStatus>((event, emit) async {
      emit(DevicesLoading());

      var result = await _crRepository.toggleAutomationStatus(
        crID,
        event.status,
      );

      result.fold((error) {
        emit(DevicesError(message: error));
      }, (newState) {
        isAutomated = newState;
        emit(DevicesSuccess(
          airConditioner: airConditioner,
          lamp: lamp,
          isAutomated: isAutomated,
        ));
      });

      emit(DevicesSuccess(
        airConditioner: airConditioner,
        lamp: lamp,
        isAutomated: isAutomated,
      ));
    });

    //!

    on<TurnOnLamp>((event, emit) async {
      emit(DevicesLoading());

      var result = await _crRepository.toggleLamp(crID, true);
      result.fold((error) {
        emit(DevicesError(message: error));
      }, (newState) {
        lamp.isActive = newState;
        emit(DevicesSuccess(
          airConditioner: airConditioner,
          lamp: lamp,
          isAutomated: isAutomated,
        ));
      });
    });

    //!

    on<TurnOffLamp>((event, emit) async {
      emit(DevicesLoading());

      var result = await _crRepository.toggleLamp(crID, false);
      result.fold((error) {
        emit(DevicesError(message: error));
      }, (newState) {
        lamp.isActive = newState;
        emit(DevicesSuccess(
          airConditioner: airConditioner,
          lamp: lamp,
          isAutomated: isAutomated,
        ));
      });
    });

    //!

    on<TurnOnAC>((event, emit) async {
      emit(DevicesLoading());

      var result = await _crRepository.toggleAirCon(crID, true);
      result.fold((error) {
        emit(DevicesError(message: error));
      }, (newState) {
        airConditioner.isActive = newState;
        emit(DevicesSuccess(
          airConditioner: airConditioner,
          lamp: lamp,
          isAutomated: isAutomated,
        ));
      });
    });

    //!

    on<TurnOffAC>((event, emit) async {
      emit(DevicesLoading());

      var result = await _crRepository.toggleAirCon(crID, false);
      result.fold((error) {
        emit(DevicesError(message: error));
      }, (newState) {
        airConditioner.isActive = newState;
        emit(DevicesSuccess(
          airConditioner: airConditioner,
          lamp: lamp,
          isAutomated: isAutomated,
        ));
      });
    });

    //! New Fan Speed Check Is Required, Because
    //! The Fan Speed Has Range Between 1 - 4

    on<AcFanIncrease>((event, emit) async {
      emit(DevicesLoading());

      var fanSpeed = airConditioner.fanSpeed;
      var result = await _crRepository.setAirConFan(crID, fanSpeed + 1);
      result.fold((error) {
        emit(DevicesError(message: error));
      }, (newFanSpeed) {
        airConditioner.fanSpeed = newFanSpeed;
        emit(DevicesSuccess(
          airConditioner: airConditioner,
          lamp: lamp,
          isAutomated: isAutomated,
        ));
      });
    });

    //!

    on<AcFanDecrease>((event, emit) async {
      emit(DevicesLoading());

      var fanSpeed = airConditioner.fanSpeed;
      var result = await _crRepository.setAirConFan(crID, fanSpeed - 1);
      result.fold((error) {
        emit(DevicesError(message: error));
      }, (newFanSpeed) {
        airConditioner.fanSpeed = newFanSpeed;
        emit(DevicesSuccess(
          airConditioner: airConditioner,
          lamp: lamp,
          isAutomated: isAutomated,
        ));
      });
    });

    //! Temperature Value Check Is Required, Because
    //! Temperature Has Its Own Limit

    on<AcTempIncrease>((event, emit) async {
      emit(DevicesLoading());

      var temperature = airConditioner.temperature;
      var result = await _crRepository.setAirConTemp(crID, temperature + 1);
      result.fold((error) {
        emit(DevicesError(message: error));
      }, (newTemperature) {
        airConditioner.temperature = newTemperature;
        emit(DevicesSuccess(
          airConditioner: airConditioner,
          lamp: lamp,
          isAutomated: isAutomated,
        ));
      });
    });

    //!

    on<AcTempDecrease>((event, emit) async {
      emit(DevicesLoading());

      var temperature = airConditioner.temperature;
      var result = await _crRepository.setAirConTemp(crID, temperature - 1);
      result.fold((error) {
        emit(DevicesError(message: error));
      }, (newTemperature) {
        airConditioner.temperature = newTemperature;
        emit(DevicesSuccess(
          airConditioner: airConditioner,
          lamp: lamp,
          isAutomated: isAutomated,
        ));
      });
    });
  }
}
