part of 'air_conditioner_bloc.dart';

sealed class AirConEvent {}

final class AcLoad extends AirConEvent {
  final AirConditioner airConditioner;

  AcLoad({required this.airConditioner});
}

final class AcTempIncrease extends AirConEvent {}

final class AcTempDecrease extends AirConEvent {}

final class AcFanIncrease extends AirConEvent {}

final class AcFanDecrease extends AirConEvent {}
