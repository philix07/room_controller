part of 'air_conditioner_bloc.dart';

sealed class AirConState {}

final class AirConInitial extends AirConState {}

final class AirConSuccess extends AirConState {
  final AirConditioner airConditioner;

  AirConSuccess({required this.airConditioner});
}

final class AirConLoading extends AirConState {}

final class AirConError extends AirConState {
  final String message;

  AirConError({required this.message});
}
