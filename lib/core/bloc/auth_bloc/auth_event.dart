part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
class AuthInitialEvent extends AuthEvent{}
class LoggedInEvent extends AuthEvent{
  final AppUser user;
  final UserEntity? userValue;

  LoggedInEvent(this.user, this.userValue);
}
class LogoutEvent extends AuthEvent{}
class LogInEvent extends AuthEvent{}