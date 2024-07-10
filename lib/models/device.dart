// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Device {
  final bool isActive;
  final Devices device;

  Device({required this.isActive, required this.device});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isActive': isActive,
      'device': device.name,
    };
  }

  factory Device.fromMap(Map<String, dynamic> map) {
    return Device(
      isActive: map['isActive'] as bool,
      device: Devices.fromString(map['device'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Device.fromJson(String source) =>
      Device.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum Devices {
  none('None'),
  lamp('Lamp'),
  airConditioner('Air Conditioner');

  final String name;
  const Devices(this.name);

  static Devices fromString(String device) {
    switch (device) {
      case 'Lamp':
        return Devices.lamp;
      case 'Air Conditioner':
        return Devices.airConditioner;
      default:
        return Devices.none;
    }
  }
}
