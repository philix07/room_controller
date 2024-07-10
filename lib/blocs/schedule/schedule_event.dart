part of 'schedule_bloc.dart';

sealed class ScheduleEvent {}

class LoadSchedule extends ScheduleEvent {}

class AddSchedule extends ScheduleEvent {
  final Schedule schedule;

  AddSchedule(this.schedule);
}

class UpdateSchedule extends ScheduleEvent {
  final Schedule schedule;

  UpdateSchedule(this.schedule);
}

class DeleteSchedule extends ScheduleEvent {
  final String scheduleId;

  DeleteSchedule(this.scheduleId);
}