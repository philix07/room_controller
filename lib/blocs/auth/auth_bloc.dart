// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';

import '../../data/repository/auth_repository.dart';
import '../../models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authRepository = AuthRepository();
  var appUser = AppUser.dummy();

  AuthBloc() : super(AuthLoggedOut()) {
    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());

      var result = await _authRepository.signIn(
        emailController: event.email,
        passwordController: event.password,
      );

      result.fold((error) {
        emit(AuthError(message: error));
      }, (data) {
        appUser = data;
        emit(AuthLoggedIn(user: appUser));
      });
    });

    on<AuthRegister>((event, emit) async {
      emit(AuthLoading());

      var user = AppUser(
        id: '',
        email: event.email,
        username: event.username,
        role: UserRole.none,
        createdAt: DateTime.now(),
      );

      var result = await _authRepository.register(
        emailController: event.email,
        passwordController: event.password,
        user: user,
      );

      result.fold((error) {
        emit(AuthError(message: error));
      }, (data) {
        appUser = data;
        emit(AuthLoggedIn(user: appUser));
      });
    });

    on<AuthLogOut>((event, emit) async {
      await _authRepository.signOutUser();
      emit(AuthLoggedOut());
    });

    on<AuthInitial>((event, emit) async {
      emit(AuthLoading());

      //* Check if there is any user is currently authenticated
      var result = await _authRepository.isAuthenticated();
      result.fold((error) {
        emit(AuthError(message: error));
      }, (data) {
        appUser = data;
        if (appUser.id == AppUser.dummy().id) {
          emit(AuthLoggedOut());
        } else {
          emit(AuthLoggedIn(user: appUser));
        }
      });
    });

    on<AuthChangePassword>((event, emit) async {
      emit(AuthLoading());

      //* Send reset password link at email
      var result = await _authRepository.forgotPassword(event.email);

      result.fold((error) {
        emit(AuthError(message: error));
      }, (data) {
        if (appUser.id != AppUser.dummy().id) {
          emit(AuthLoggedIn(user: appUser));
        }
      });
    });
  }
}
