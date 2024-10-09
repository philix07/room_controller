part of 'schedule_bloc.dart';

sealed class ScheduleEvent {}

class LoadSchedule extends ScheduleEvent {
  final List<Schedule> schedules;
  final String crID;

  LoadSchedule({required this.schedules, required this.crID});
}

//? this method probably won't be used
class AddSchedule extends ScheduleEvent {
  final ScheduleDetail scheduleDetail;
  final Days daysOfWeek;

  AddSchedule(this.scheduleDetail, this.daysOfWeek);
}

class UpdateSchedule extends ScheduleEvent {
  final Schedule schedule;
  final Days daysOfWeek;

  UpdateSchedule({required this.schedule, required this.daysOfWeek});
}

//? this method probably won't be used
class DeleteSchedule extends ScheduleEvent {
  final String scheduleId;

  DeleteSchedule(this.scheduleId);
}
