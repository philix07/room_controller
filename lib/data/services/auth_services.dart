// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../models/user.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _userRef = FirebaseDatabase.instance.ref().child('users');

  Future<Either<String, AppUser>> register({
    required String emailController,
    required String passwordController,
    required AppUser user,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailController,
        password: passwordController,
      );

      // Set the user id to match the firebase auth user id
      var newUser = AppUser(
        id: _firebaseAuth.currentUser!.uid,
        email: user.email,
        username: user.username,
        role: user.role,
        createdAt: user.createdAt,
      );

      // If There's Error While Inputing Data Into The DB
      // Then Delete The User
      await _userRef.child(_firebaseAuth.currentUser!.uid).set(newUser.toMap());

      return Right(newUser);
    } catch (e) {
      return const Left('Failed To Register Your Account');
    }
  }

  Future<Either<String, AppUser>> signIn({
    required String emailController,
    required String passwordController,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailController,
        password: passwordController,
      );

      var userId = _firebaseAuth.currentUser!.uid;
      var snapshot = await _userRef.child(userId).get();
      var data = Map<String, dynamic>.from(snapshot.value as Map);

      var appUser = AppUser.fromMap(data);

      return Right(appUser);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<String> signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      return 'Successfully Signed Out';
    } catch (e) {
      return 'Failed to Sign Out';
    }
  }

  Future<Either<String, String>> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return const Right('Link Sent');
    } catch (e) {
      print('Error Occured: ${e.toString()}');
      return const Left('Email Not Found');
    }
  }

  Future<Either<String, AppUser>> isAuthenticated() async {
    try {
      var user = _firebaseAuth.currentUser;

      if (user != null) {
        print('In service layer: user not null, trying to get user information with id ${user.uid}');

        var result = await _userRef.child(user.uid).get();
        print('In service layer: user data fetched'); 

        var data = Map<String, dynamic>.from(result.value as Map);

        print('In service layer: User is authenticated, not dummy');
        return Right(AppUser.fromMap(data));
      }

      print('In service layer: User dummy, not logged in');
      return Right(AppUser.dummy());
    } catch (e) {
      return const Left('Error While Checking Authentication Status');
    }
  }
}
