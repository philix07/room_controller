part of 'classroom_bloc.dart';

sealed class ClassroomEvent {}

final class ClassroomFetchAll extends ClassroomEvent {}

final class ClassroomChangeIndex extends ClassroomEvent {
  final int newIndex;

  ClassroomChangeIndex({required this.newIndex});
}

