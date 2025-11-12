part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
class AuthInitialEvent extends AuthEvent{}
class LoggedInEvent extends AuthEvent{
  final AppUser user;

  LoggedInEvent(this.user);
}
class LogoutEvent extends AuthEvent{}
class LogInEvent extends AuthEvent{}