part of 'schedule_bloc.dart';

sealed class ScheduleEvent {}

class LoadSchedule extends ScheduleEvent {
  final List<Schedule> schedules;
  final String crID;

  LoadSchedule({required this.schedules, required this.crID});
}

class AddSchedule extends ScheduleEvent {
  final ScheduleDetail scheduleDetail;
  final Days daysOfWeek;

  AddSchedule(this.scheduleDetail, this.daysOfWeek);
}

class UpdateSchedule extends ScheduleEvent {
  final Schedule schedule;

  UpdateSchedule(this.schedule);
}

class DeleteSchedule extends ScheduleEvent {
  final String scheduleId;

  DeleteSchedule(this.scheduleId);
}
