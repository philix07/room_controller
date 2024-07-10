import 'package:aplikasi_kontrol_kelas/models/schedule.dart';
import 'package:bloc/bloc.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleInitial()) {
    on<ScheduleEvent>((event, emit) {
    });
  }
}
