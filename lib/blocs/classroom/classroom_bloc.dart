import 'package:aplikasi_kontrol_kelas/data/repository/classroom_repository.dart';
import 'package:aplikasi_kontrol_kelas/models/classroom.dart';
import 'package:bloc/bloc.dart';

part 'classroom_event.dart';
part 'classroom_state.dart';

class ClassroomBloc extends Bloc<ClassroomEvent, ClassroomState> {
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
        emit(ClassroomSuccess(classrooms: classrooms));
      });
    });
  }
}
