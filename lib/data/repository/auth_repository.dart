import 'package:dartz/dartz.dart';

import '../../models/user.dart';
import '../services/auth_services.dart';

class AuthRepository {
  final _authService = AuthService();

  Future<Either<String, AppUser>> signIn({
    required String emailController,
    required String passwordController,
  }) async {
    var result = await _authService.signIn(
      emailController: emailController,
      passwordController: passwordController,
    );

    var isError = false;
    var errorMessage = '';
    AppUser userData = AppUser.dummy();

    result.fold((error) {
      isError = true;
      errorMessage = error;
    }, (data) {
      userData = data;
    });

    if (isError) {
      return Left(errorMessage);
    }
    return Right(userData);
  }

  Future<Either<String, AppUser>> register({
    required String emailController,
    required String passwordController,
    required AppUser user,
  }) async {
    var result = await _authService.register(
      emailController: emailController,
      passwordController: passwordController,
      user: user,
    );

    var isError = false;
    var errorMessage = '';
    AppUser userData = AppUser.dummy();

    result.fold((error) {
      isError = true;
      errorMessage = error;
    }, (data) {
      userData = data;
    });

    if (isError) {
      return Left(errorMessage);
    }
    return Right(userData);
  }

  Future<String> signOutUser() async {
    return await _authService.signOutUser();
  }

  Future<Either<String, String>> forgotPassword(String email) async {
    var result = await _authService.forgotPassword(email);

    var isError = false;
    var errorMessage = '';
    var message = '';

    result.fold((error) {
      isError = true;
      errorMessage = error;
    }, (data) {
      message = data;
    });

     if (isError) {
      return Left(errorMessage);
    }
    return Right(message);
  }

  Future<Either<String, AppUser>> isAuthenticated() async {
    var result = await _authService.isAuthenticated();

    var isError = false;
    var errorMessage = '';
    var appUser = AppUser.dummy();

    result.fold((error) {
      isError = true;
      errorMessage = error;
    }, (data) {
      appUser = data;
    });

    if (isError) {
      return Left(errorMessage);
    }
    return Right(appUser);
  }
}
