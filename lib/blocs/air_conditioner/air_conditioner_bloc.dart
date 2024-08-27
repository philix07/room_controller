import 'package:aplikasi_kontrol_kelas/blocs/classroom/classroom_bloc.dart';
import 'package:aplikasi_kontrol_kelas/models/device.dart';
import 'package:bloc/bloc.dart';

part 'air_conditioner_event.dart';
part 'air_conditioner_state.dart';

class AirConBloc extends Bloc<AirConEvent, AirConState> {
  late AirConditioner airConditioner;

  AirConBloc() : super(AirConInitial()) {
    on<AcLoad>((event, emit) async {
      emit(AirConLoading());

      airConditioner = event.airConditioner;
      print("Current air conditioner state:");
      print("temp ${airConditioner.temperature}");
      print("fan speed ${airConditioner.fanSpeed}");
      print("activation status ${airConditioner.isActive}");

      emit(AirConSuccess(airConditioner: event.airConditioner));
    });

    on<AcTempIncrease>((event, emit) async {});

    on<AcTempDecrease>((event, emit) async {});

    on<AcFanIncrease>((event, emit) async {});

    on<AcFanDecrease>((event, emit) async {});
  }
}
