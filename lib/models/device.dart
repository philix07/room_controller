abstract class Device {
  String id;
  String name;
  bool isActive;

  Device({
    required this.id,
    required this.name,
    required this.isActive,
  });

  Map<String, dynamic> toMap();

  @override
  String toString() => 'Device(id: $id, name: $name, isActive: $isActive)';
}

class AirConditioner extends Device {
  int temperature;
  int fanSpeed;

  AirConditioner({
    required super.id,
    required super.name,
    required super.isActive,
    required this.temperature,
    required this.fanSpeed,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isActive': isActive,
      'temperature': temperature,
      'fanSpeed': fanSpeed,
      'type': 'AirConditioner',
    };
  }

  factory AirConditioner.fromMap(Map<String, dynamic> map) {
    return AirConditioner(
      id: map['id'],
      name: map['name'],
      isActive: map['isActive'],
      temperature: map['temperature'],
      fanSpeed: map['fanSpeed'],
    );
  }
}

class Lamp extends Device {
  Lamp({
    required super.id,
    required super.name,
    required super.isActive,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isActive': isActive,
      'type': 'Lamp',
    };
  }

  factory Lamp.fromMap(Map<String, dynamic> map) {
    return Lamp(
      id: map['id'],
      name: map['name'],
      isActive: map['isActive'],
    );
  }
}


// class Device {
//   final bool isActive;
//   final Devices device;

//   Device({required this.isActive, required this.device});

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'isActive': isActive,
//       'device': device.name,
//     };
//   }

//   factory Device.fromMap(Map<String, dynamic> map) {
//     return Device(
//       isActive: map['isActive'] as bool,
//       device: Devices.fromString(map['device'] as String),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Device.fromJson(String source) =>
//       Device.fromMap(json.decode(source) as Map<String, dynamic>);
// }

// enum Devices {
//   none('None'),
//   lamp('Lamp'),
//   airConditioner('Air Conditioner');

//   final String name;
//   const Devices(this.name);

//   static Devices fromString(String device) {
//     switch (device) {
//       case 'Lamp':
//         return Devices.lamp;
//       case 'Air Conditioner':
//         return Devices.airConditioner;
//       default:
//         return Devices.none;
//     }
//   }
// }
