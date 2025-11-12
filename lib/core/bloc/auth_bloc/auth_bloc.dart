import 'package:bloc/bloc.dart';
import 'package:demomanager/core/models/app_user.dart';
import 'package:demomanager/core/routes/app_routes.dart';
import 'package:demomanager/core/services/firebase_auth_service/firebase_auth_service.dart';
import 'package:demomanager/core/services/navigator_service/navigator_service.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthInitialEvent>((event, emit) {
      Future.delayed(Duration(seconds: 1)).then((_) {
        FirebaseAuthService().authStateChanges().listen((value) {
          if (value != null) {
            NavigatorService.pushAndRemoveUntil(AppRoutes.home);
            add(LoggedInEvent(value));
          } else {
            NavigatorService.pushAndRemoveUntil(AppRoutes.login);
            add(LogoutEvent());
          }
        });
      });
    });

    on<LoggedInEvent>((event, emit) {
      emit(AuthLogin(user: event.user));
    });
    on<LogInEvent>((event, emit) {});
    on<LogoutEvent>((event, emit) {
      emit(AuthLogout());
    });
  }
}
