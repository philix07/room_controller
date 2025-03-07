import 'package:aplikasi_kontrol_kelas/data/repository/classroom_repository.dart';
import 'package:aplikasi_kontrol_kelas/models/classroom.dart';
import 'package:bloc/bloc.dart';

part 'classroom_event.dart';
part 'classroom_state.dart';

class ClassroomBloc extends Bloc<ClassroomEvent, ClassroomState> {
  int currentActiveClassroomIndex = 0;
  ClassroomRepository repo = ClassroomRepository();
  List<Classroom> classrooms = [];

  ClassroomBloc() : super(ClassroomInitial()) {
    on<ClassroomFetchAll>((event, emit) async {
      emit(ClassroomLoading());

      var result = await repo.fetchClassroomData();
      result.fold((error) {
        emit(ClassroomError(message: error));
      }, (data) {
        classrooms = data;
        classrooms.sort((a, b) {
          return double.parse(a.name.split(" ")[1])
              .compareTo(double.parse(b.name.split(" ")[1]));
        });

        emit(ClassroomSuccess(
          classrooms: classrooms,
          classroomIndex: currentActiveClassroomIndex,
        ));
      });
    });

    on<ClassroomChangeIndex>((event, emit) async {
      emit(ClassroomLoading());

      currentActiveClassroomIndex = event.newIndex;

      emit(ClassroomSuccess(
        classrooms: classrooms,
        classroomIndex: currentActiveClassroomIndex,
      ));
    });
  }
}
