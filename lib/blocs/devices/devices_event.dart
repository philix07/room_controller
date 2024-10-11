part of 'devices_bloc.dart';

sealed class DevicesEvent {}

final class LoadDevice extends DevicesEvent {
  final AirConditioner airConditioner;
  final Lamp lamp;
  final String crID;
  final bool isAutomated;

  LoadDevice({
    required this.airConditioner,
    required this.lamp,
    required this.crID,
    required this.isAutomated,
  });
}

final class TurnOnLamp extends DevicesEvent {}

final class TurnOffLamp extends DevicesEvent {}

final class TurnOnAC extends DevicesEvent {}

final class TurnOffAC extends DevicesEvent {}

final class AcTempIncrease extends DevicesEvent {}

final class AcTempDecrease extends DevicesEvent {}

final class AcFanIncrease extends DevicesEvent {}

final class AcFanDecrease extends DevicesEvent {}

final class ChangeDeviceAutomationStatus extends DevicesEvent {
  final bool status;

  ChangeDeviceAutomationStatus({required this.status});
}
