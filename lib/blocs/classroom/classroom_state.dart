part of 'classroom_bloc.dart';

sealed class ClassroomState {}

final class ClassroomInitial extends ClassroomState {}

final class ClassroomLoading extends ClassroomState {}

final class ClassroomError extends ClassroomState {
  final String message;

  ClassroomError({required this.message});
}

final class ClassroomSuccess extends ClassroomState {
  final List<Classroom> classrooms;
  final int classroomIndex;

  ClassroomSuccess({
    required this.classrooms,
    required this.classroomIndex,
  });
}
