import 'package:aplikasi_kontrol_kelas/data/repository/classroom_repository.dart';
import 'package:aplikasi_kontrol_kelas/models/access_log.dart';
import 'package:bloc/bloc.dart';

part 'access_log_event.dart';
part 'access_log_state.dart';

class AccessLogBloc extends Bloc<AccessLogEvent, AccessLogState> {
  final _logRepository = ClassroomRepository();
  List<AccessLog> logs = [];
  late String crID;

  AccessLogBloc() : super(AccessLogLoading()) {
    on<LoadAccessLog>((event, emit) async {
      emit(AccessLogLoading());

      logs = event.logs;
      crID = event.crID;

      emit(AccessLogSuccess(logs: logs));
    });

    on<AddAccessLog>((event, emit) async {
      emit(AccessLogLoading());
      print('Add Access Log Event Triggered');

      var result = await _logRepository.addAccessLog(
        crID,
        event.accessLog,
        logs.length,
      );

      result.fold((error) {
        emit(AccessLogError(message: error));
        print('Failed to add Access Log');
      }, (newState) {
        logs.add(event.accessLog);
        print('Access Log Successfully Added');
        emit(AccessLogSuccess(logs: logs));
      });
    });
  }
}
