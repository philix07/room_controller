// ignore_for_file: avoid_print

import 'package:aplikasi_kontrol_kelas/models/schedule.dart';
import 'package:bloc/bloc.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  List<Schedule> schedules = [];
  late String crID;

  ScheduleBloc() : super(ScheduleLoading()) {
    on<LoadSchedule>((event, emit) async {
      emit(ScheduleLoading());
      schedules = event.schedules;
      crID = event.crID;
      emit(ScheduleSuccess(schedules: schedules));
    });
  }
}
