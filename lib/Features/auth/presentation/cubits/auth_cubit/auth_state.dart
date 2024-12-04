part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserClass user;

  AuthAuthenticated(this.user);
}

class AuthCompleteGoogleAuthProcess extends AuthState {
  final OAuthCredential oAuthCredential;

  AuthCompleteGoogleAuthProcess(this.oAuthCredential);
}

class AuthGoToHome extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
