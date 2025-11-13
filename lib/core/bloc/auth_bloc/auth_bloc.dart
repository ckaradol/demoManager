import 'package:bloc/bloc.dart';
import 'package:demomanager/core/enums/app/app_user_type.dart';
import 'package:demomanager/core/models/app_user.dart';
import 'package:demomanager/core/models/user_entity.dart';
import 'package:demomanager/core/routes/app_routes.dart';
import 'package:demomanager/core/services/firebase_auth_service/firebase_auth_service.dart';
import 'package:demomanager/core/services/firestore_service/firestore_service.dart';
import 'package:demomanager/core/services/navigator_service/navigator_service.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthInitialEvent>((event, emit) {
      Future.delayed(Duration(seconds: 1)).then((_) {
        FirebaseAuthService().authStateChanges().listen((user) {
          if (user != null) {
            FirestoreService().usersSnapshotStream(user.uid).listen((value) {
              if (value?.role == AppUserType.doctor) {
                if(value?.diplomaUrl==null) {
                  NavigatorService.pushAndRemoveUntil(AppRoutes.upload);
                }else if(value?.isVerified==false){
                  NavigatorService.pushAndRemoveUntil(AppRoutes.wait);
                }else if(value?.status==UserStatus.approved){
                  NavigatorService.pushAndRemoveUntil(AppRoutes.home);
                }
              } else {
                NavigatorService.pushAndRemoveUntil(AppRoutes.home);
              }
              add(LoggedInEvent(user,value));
            });


          } else {
            NavigatorService.pushAndRemoveUntil(AppRoutes.login);
            add(LogoutEvent());
          }
        });
      });
    });

    on<LoggedInEvent>((event, emit) {
      if(event.userValue!=null) {
        emit(AuthLogin(user: event.user,userValue: event.userValue!));
      }
    });
    on<LogInEvent>((event, emit) {});
    on<LogoutEvent>((event, emit) {
      emit(AuthLogout());
    });
  }
}
