// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

//! Kenapa Pakai "String" Username? Karena User Tidak Dapat
//! Mengubah Usernamenya Sendiri. User Hanya Bisa Ganti Password Nantinya
class AccessLog {
  final String id;
  final String action;
  final String username;
  final DateTime operationTime;

  AccessLog({
    required this.id,
    required this.action,
    required this.username,
    required this.operationTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'action': action,
      'username': username,
      'operationTime' : operationTime.toString(),
    };
  }

  factory AccessLog.fromMap(Map<String, dynamic> map) {
    return AccessLog(
      id: map['id'] as String,
      action: map['action'] as String,
      username: map['username'] as String,
      operationTime: DateTime.parse(map['operationTime'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory AccessLog.fromJson(String source) =>
      AccessLog.fromMap(json.decode(source) as Map<String, dynamic>);
}
