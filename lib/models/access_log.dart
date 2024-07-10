// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

//! Kenapa Pakai "String" Username? Karena User Tidak Dapat
//! Mengubah Usernamenya Sendiri. User Hanya Bisa Ganti Password Nanti
class AccessLog {
  final String id;
  final String device;
  final String action;
  final String username;

  AccessLog({
    required this.id,
    required this.device,
    required this.action,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'device': device,
      'action': action,
      'username': username,
    };
  }

  factory AccessLog.fromMap(Map<String, dynamic> map) {
    return AccessLog(
      id: map['id'] as String,
      device: map['device'] as String,
      action: map['action'] as String,
      username: map['username'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccessLog.fromJson(String source) =>
      AccessLog.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AccessLogs {
  List<AccessLog> logs;

  AccessLogs({required this.logs});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'logs': logs.map((x) => x.toMap()).toList(),
    };
  }

  factory AccessLogs.fromMap(Map<String, dynamic> map) {
    return AccessLogs(
      logs: List<AccessLog>.from(
        (map['logs'] as List<int>).map<AccessLog>(
          (x) => AccessLog.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AccessLogs.fromJson(String source) =>
      AccessLogs.fromMap(json.decode(source) as Map<String, dynamic>);
}
