part of 'devices_bloc.dart';

sealed class DevicesState {}

final class DevicesInitial extends DevicesState {}

final class DevicesSuccess extends DevicesState {
  final AirConditioner airConditioner;
  final Lamp lamp;

  DevicesSuccess({required this.airConditioner, required this.lamp});
}

final class DevicesLoading extends DevicesState {}

final class DevicesError extends DevicesState {
  final String message;

  DevicesError({required this.message});
}
