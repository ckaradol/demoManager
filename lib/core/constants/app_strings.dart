import 'package:easy_localization/easy_localization.dart';

class AppStrings {
  static String get doctor => "doctor".tr();

  static String get salesRepresentative => "sales_representative".tr();

  static String get loginTitle => "login_title".tr();

  static String get registerTitle => "register_title".tr();

  static String get emailId => "email_id".tr();

  static String get password => "password".tr();

  static String get forgetPassword => "forget_password".tr();

  static String get firstName => "first_name".tr();

  static String get lastName => "last_name".tr();

  static String get errorEmptyFields => 'error_empty_fields'.tr();

  static String get errorInvalidEmail => 'error_invalid_email'.tr();

  static String get errorShortPassword => 'error_short_password'.tr();

  static String get loginSuccess => 'login_success'.tr();

  static String get createAccount => "create_account".tr();

  static String get alreadyHaveAccount => "already_have_account".tr();

  static String get signIn => "sign_in".tr();

  static String get loginButton => "login_button".tr();

  static String get or => "or".tr();

  static String get signUpText => "sign_up_text".tr();

  static String get signUpButton => "sign_up_button".tr();

  static String get diplomaTitle => "diploma_title".tr();

  static String get diplomaNoFile => "diploma_no_file".tr();

  static String get diplomaChooseFile => "diploma_choose_file".tr();

  static String get diplomaUpload => "diploma_upload".tr();

  static String diplomaLoadingPercent(String percent) => "diploma_loading_percent".tr(args: [percent]);

  static String get diplomaSuccessTitle => "diploma_success_title".tr();

  static String get diplomaSuccessMessage => "diploma_success_message".tr();

  static String get diplomaHint => "diploma_hint".tr();

  static String get diplomaUploading => "diploma_uploading".tr();

  static String get accountStatus => "account_status".tr();

  static String get statusApprovedTitle => "status_approved_title".tr();

  static String get statusApprovedMessage => "status_approved_message".tr();

  static String get statusRejectedTitle => "status_rejected_title".tr();

  static String get statusRejectedMessage => "status_rejected_message".tr();

  static String get statusPendingTitle => "status_pending_title".tr();

  static String get statusPendingMessage => "status_pending_message".tr();

  static String get refreshButton => "refresh_button".tr();
  static String get resetMyPassword => "reset_my_password".tr();
  static String get resetPasswordSuccess => "reset_password_success".tr();
}
