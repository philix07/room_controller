part of 'schedule_bloc.dart';

sealed class ScheduleState {}

final class ScheduleInitial extends ScheduleState {}

final class ScheduleLoading extends ScheduleState {}

final class ScheduleEmpty extends ScheduleState {}

final class ScheduleError extends ScheduleState {
  final String message;

  ScheduleError({required this.message});
}

final class ScheduleSuccess extends ScheduleState {
  final List<Schedule> schedules;

  ScheduleSuccess({required this.schedules});


}
