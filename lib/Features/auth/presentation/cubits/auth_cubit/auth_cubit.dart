import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/auth/data/models/signup_model.dart';
import 'package:online_shopping/Features/auth/domain/entities/user.dart';
import 'package:online_shopping/Features/auth/domain/repo_interface/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepository authRepo;

  void resetPassword(String email) async {
    emit(AuthLoading());
    try {
      await authRepo.sendPasswordResetLink(email);
      emit(AuthSuccess());
    } catch (e) {
      if (e is FirebaseException) {
        emit(AuthError(e.code));
      } else {
        emit(AuthError("Something went wrong"));
      }
    }
  }

  Future<void> loginWithGoogle() async {
    emit(AuthLoading());
    try {
      final OAuthCredential oAuthCredential;
      final UserClass? user;

      (oAuthCredential, user) = await authRepo.googleSignup();
      if (user == null) {
        emit(AuthCompleteGoogleAuthProcess(oAuthCredential));
      } else {
        emit(AuthGoToHome());
      }
    } catch (e) {
      if (e is FirebaseException) {
        emit(AuthError(e.code));
      } else {
        emit(AuthError("Something went wrong"));
      }
    }
  }

  Future<void> completeGoogleSignin(DateTime dateOfBirth, String name, OAuthCredential oAuthCredential) async {
    emit(AuthLoading());
    try {
      final UserClass? user = await authRepo.completeSignupWithGoogleProcess(dateOfBirth, name, oAuthCredential);
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError("Login failed"));
      }
    } catch (e) {
      if (e is FirebaseException) {
        emit(AuthError(e.code));
      } else {
        emit(AuthError("Something went wrong"));
      }
    }
  }

  void loginUser(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await authRepo.login(email, password);
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError("Login failed"));
      }
    } catch (e) {
      if (e is FirebaseException) {
        emit(AuthError(e.code));
      } else if (e is Exception) {
        emit(AuthError(e.toString().split(': ').last));
      } else {
        emit(AuthError("Something went wrong"));
      }
    }
  }

  void signupUser(String name, String email, DateTime dateOfBirth, String password) async {
    emit(AuthLoading());
    try {
      SignupModel model = SignupModel(email: email, name: name, dateOfBirth: dateOfBirth);
      final user = await authRepo.signup(model, password);
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError("Signup failed"));
      }
    } catch (e) {
      if (e is FirebaseException) {
        emit(AuthError(e.code));
      } else {
        emit(AuthError("Something went wrong"));
      }
    }
  }
}
