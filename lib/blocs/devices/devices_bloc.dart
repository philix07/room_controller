import 'package:aplikasi_kontrol_kelas/models/device.dart';
import 'package:bloc/bloc.dart';

part 'devices_event.dart';
part 'devices_state.dart';

class DevicesBloc extends Bloc<DevicesEvent, DevicesState> {
  late AirConditioner airConditioner;
  late Lamp lamp;
  late String crName;

  DevicesBloc() : super(DevicesInitial()) {
    on<LoadDevice>((event, emit) async {
      emit(DevicesLoading());

      airConditioner = event.airConditioner;
      lamp = event.lamp;

      print("Current air conditioner state:");
      print("temp ${airConditioner.temperature}");
      print("fan speed ${airConditioner.fanSpeed}");
      print("activation status ${airConditioner.isActive}");
      print("Current lamp state : ${lamp.isActive}");

      emit(DevicesSuccess(airConditioner: airConditioner, lamp: lamp));
    });

    on<TurnOnLamp>((event, emit) async {
      emit(DevicesLoading());

      emit(DevicesSuccess(airConditioner: airConditioner, lamp: lamp));
    });

    on<TurnOffLamp>((event, emit) async {
      emit(DevicesLoading());

      emit(DevicesSuccess(airConditioner: airConditioner, lamp: lamp));
    });

    on<TurnOnAC>((event, emit) async {
      emit(DevicesLoading());

      emit(DevicesSuccess(airConditioner: airConditioner, lamp: lamp));
    });

    on<TurnOffAC>((event, emit) async {
      emit(DevicesLoading());

      emit(DevicesSuccess(airConditioner: airConditioner, lamp: lamp));
    });

    on<AcFanIncrease>((event, emit) async {
      emit(DevicesLoading());

      emit(DevicesSuccess(airConditioner: airConditioner, lamp: lamp));
    });

    on<AcFanDecrease>((event, emit) async {
      emit(DevicesLoading());

      emit(DevicesSuccess(airConditioner: airConditioner, lamp: lamp));
    });

    on<AcTempIncrease>((event, emit) async {
      emit(DevicesLoading());

      emit(DevicesSuccess(airConditioner: airConditioner, lamp: lamp));
    });

    on<AcTempDecrease>((event, emit) async {
      emit(DevicesLoading());

      emit(DevicesSuccess(airConditioner: airConditioner, lamp: lamp));
    });
  }
}
