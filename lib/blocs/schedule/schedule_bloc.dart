// ignore_for_file: avoid_print

import 'package:aplikasi_kontrol_kelas/models/schedule.dart';
import 'package:bloc/bloc.dart';

import '../../data/repository/classroom_repository.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ClassroomRepository repo = ClassroomRepository();
  List<Schedule> schedules = [];
  late String crID;

  ScheduleBloc() : super(ScheduleLoading()) {
    on<LoadSchedule>((event, emit) async {
      emit(ScheduleLoading());
      schedules = event.schedules;
      crID = event.crID;
      emit(ScheduleSuccess(schedules: schedules));
    });

    on<UpdateSchedule>((event, emit) async {
      emit(ScheduleLoading());

      var result = await repo.updateSchedule(
        crID,
        event.schedule,
        event.daysOfWeek,
      );

      result.fold((error) {
        emit(ScheduleError(message: error));
      }, (data) {
        var index = Days.toIndex(event.daysOfWeek.value);

        schedules[index] = event.schedule;
        emit(ScheduleSuccess(schedules: schedules));
      });
    });
  }
}
