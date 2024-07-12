import 'package:aplikasi_kontrol_kelas/models/access_log.dart';
import 'package:bloc/bloc.dart';

part 'access_log_event.dart';
part 'access_log_state.dart';

class AccessLogBloc extends Bloc<AccessLogEvent, AccessLogState> {
  List<AccessLog> logs = [];

  AccessLogBloc() : super(AccessLogLoading()) {
    on<LoadAccessLog>((event, emit) {
      emit(AccessLogLoading());

      logs = event.logs;

      emit(AccessLogSuccess(logs: logs));
    });
  }
}
