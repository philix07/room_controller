part of 'access_log_bloc.dart';

sealed class AccessLogEvent {}

final class LoadAccessLog extends AccessLogEvent {
  final List<AccessLog> logs;

  LoadAccessLog({required this.logs});
}

final class AddAccessLog extends AccessLogEvent {
  final AccessLog accessLog;

  AddAccessLog({required this.accessLog});
}

final class DeletedAccessLog extends AccessLogEvent {
  final String id;

  DeletedAccessLog({required this.id});
}
