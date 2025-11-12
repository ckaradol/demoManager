part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
 class AuthLogin extends AuthState {
  final AppUser user;

  AuthLogin({required this.user});
}
final class AuthLogout extends AuthState {}
