part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
 class AuthLogin extends AuthState {
  final AppUser user;
  final UserEntity userValue;

  AuthLogin( {required this.user,required this.userValue,});
}
final class AuthLogout extends AuthState {}
