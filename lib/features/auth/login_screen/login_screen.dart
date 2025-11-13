import 'package:demomanager/core/bloc/text_form_cubit/text_form_cubit.dart';
import 'package:demomanager/core/constants/app_strings.dart';
import 'package:demomanager/core/enums/app/app_user_type.dart';
import 'package:demomanager/core/enums/assets/app_images.dart';
import 'package:demomanager/core/extensions/app/app_column_gap_ext.dart';
import 'package:demomanager/core/extensions/assets/app_images_ext.dart';
import 'package:demomanager/core/routes/app_routes.dart';
import 'package:demomanager/core/services/firebase_auth_service/firebase_auth_service.dart';
import 'package:demomanager/core/services/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enums/app/app_spacing.dart';
import '../../../core/services/navigator_service/navigator_service.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TextFormCubit(),
      child: BlocBuilder<TextFormCubit, bool>(
        builder: (context, state) {
          return Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.xLargeSpace),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: AppImages.loginScreen.toSvg()),
                          RadioGroup<AppUserType>(
                            onChanged: (value) {
                              context.read<TextFormCubit>().changeUserType(value ?? AppUserType.doctor);
                            },
                            groupValue: context.read<TextFormCubit>().userType,
                            child: Wrap(
                              children: [
                                Container(
                                  constraints: BoxConstraints(maxWidth: 150),
                                  child: ListTile(
                                    onTap: () {
                                      context.read<TextFormCubit>().changeUserType(AppUserType.doctor);
                                    },
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(AppStrings.doctor),
                                    leading: Radio(value: AppUserType.doctor),
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(maxWidth: 150),
                                  child: ListTile(
                                    onTap: () {
                                      context.read<TextFormCubit>().changeUserType(AppUserType.sales);
                                    },
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(AppStrings.salesRepresentative),
                                    leading: Radio(value: AppUserType.sales),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(AppStrings.loginTitle, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24)),
                          Column(
                            children: [
                              AppTextFormField(labelText: AppStrings.emailId, controller: context.read<TextFormCubit>().controllerMail, textInputType: TextInputType.emailAddress),

                              AppTextFormField(
                                obsecureText: context.read<TextFormCubit>().obsecureText,
                                labelText: AppStrings.password,
                                controller: context.read<TextFormCubit>().controllerPassword,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    context.read<TextFormCubit>().changeObsecureText(!context.read<TextFormCubit>().obsecureText);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 15),
                                    decoration: BoxDecoration(
                                      border: Border(left: BorderSide(color: Color(0xffD9D9D9))),
                                    ),
                                    child: context.read<TextFormCubit>().obsecureText ? AppImages.eyeOff.toSvg() : AppImages.eye.toSvg(),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [TextButton(onPressed: () {}, child: Text(AppStrings.forgetPassword))],
                              ),
                              AppButton(
                                loading: context.read<TextFormCubit>().loading,
                                text: AppStrings.loginButton,
                                onTap: () async {
                                  context.read<TextFormCubit>().changeLoading(true);
                                  String mail = context.read<TextFormCubit>().controllerMail.text.trim();
                                  String password = context.read<TextFormCubit>().controllerPassword.text.trim();

                                  if (mail.isEmpty || password.isEmpty) {
                                    context.read<TextFormCubit>().changeLoading(false);

                                    showToast("Hata", AppStrings.errorEmptyFields, true);
                                    return;
                                  }

                                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                                  if (!emailRegex.hasMatch(mail)) {
                                    context.read<TextFormCubit>().changeLoading(false);

                                    showToast("Hata", AppStrings.errorInvalidEmail, true);

                                    return;
                                  }

                                  if (password.length < 6) {
                                    context.read<TextFormCubit>().changeLoading(false);

                                    showToast("Hata", AppStrings.errorShortPassword, true);

                                    return;
                                  }

                                  await FirebaseAuthService().signInWithEmailPassword(mail, password);
                                  context.read<TextFormCubit>().changeLoading(false);

                                },
                              ),
                            ],
                          ).withGap(AppSpacing.mediumSpace),
                          if (!(context.read<TextFormCubit>().userType == AppUserType.sales))
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(child: Divider(color: Color(0xffBEC5D2))),
                                    Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text(AppStrings.or)),
                                    Expanded(child: Divider(color: Color(0xffBEC5D2))),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        FirebaseAuthService().signInWithGoogle();
                                      },
                                      child: AppImages.google.toSvg(),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(AppStrings.signUpText),
                                    TextButton(
                                      onPressed: () {
                                        NavigatorService.pushNamed(AppRoutes.register);
                                      },
                                      child: Text(AppStrings.signUpButton),
                                    ),
                                  ],
                                ),
                              ],
                            ).withGap(AppSpacing.largeSpace),
                          SizedBox(),
                        ],
                      ).withGap(AppSpacing.defaultSpace),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}


