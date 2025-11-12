import 'package:bloc/bloc.dart';
import 'package:demomanager/core/enums/app/app_user_type.dart';
import 'package:flutter/cupertino.dart';


class TextFormCubit extends Cubit<bool> {
  TextFormCubit() : super(true);
  final TextEditingController controllerMail = TextEditingController();
  final TextEditingController controllerFirstName = TextEditingController();
  final TextEditingController controllerLastName = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  AppUserType userType=AppUserType.doctor;
  bool obsecureText = true;
  bool loading = false;

  void changeObsecureText(bool obSecureText) {
    obsecureText=obSecureText;
    emit(!state);
  }void changeLoading(bool loading) {
    this.loading=loading;
    emit(!state);
  }
  void changeUserType(AppUserType userType){
    this.userType=userType;
    emit(!state);
  }
}
