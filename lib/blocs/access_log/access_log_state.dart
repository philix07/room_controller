part of 'access_log_bloc.dart';

sealed class AccessLogState {}

final class AccessLogLoading extends AccessLogState {}

final class AccessLogError extends AccessLogState {
  final String message;

  AccessLogError({required this.message});
}

final class AccessLogSuccess extends AccessLogState {
  final List<AccessLog> logs;

  AccessLogSuccess({required this.logs});
}
