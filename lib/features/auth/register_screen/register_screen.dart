import 'package:demomanager/core/bloc/text_form_cubit/text_form_cubit.dart';
import 'package:demomanager/core/constants/app_strings.dart';
import 'package:demomanager/core/enums/assets/app_images.dart';
import 'package:demomanager/core/extensions/app/app_column_gap_ext.dart';
import 'package:demomanager/core/extensions/assets/app_images_ext.dart';
import 'package:demomanager/core/services/navigator_service/navigator_service.dart';
import 'package:demomanager/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enums/app/app_spacing.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/firebase_auth_service/firebase_auth_service.dart';
import '../../../core/services/show_toast.dart';
import '../../../core/widgets/app_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => TextFormCubit(),
      child: BlocBuilder<TextFormCubit, bool>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  NavigatorService.pop();
                },
                icon: Icon(Icons.arrow_back),
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
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
                          Center(child: AppImages.registerScreen.toSvg()),

                          Text(AppStrings.registerTitle, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24)),
                          Column(
                            children: [
                              AppTextFormField(labelText: AppStrings.firstName, controller: context.read<TextFormCubit>().controllerFirstName),
                              AppTextFormField(labelText: AppStrings.lastName, controller: context.read<TextFormCubit>().controllerLastName),
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

                            ],
                          ).withGap(AppSpacing.mediumSpace),
                          AppButton(
                            loading:context.read<TextFormCubit>().loading ,
                            text: AppStrings.createAccount,
                            onTap: () async {
                              context.read<TextFormCubit>().changeLoading(true);
                              String mail = context.read<TextFormCubit>().controllerMail.text.trim();
                              String firstName = context.read<TextFormCubit>().controllerFirstName.text.trim();
                              String lastName = context.read<TextFormCubit>().controllerLastName.text.trim();
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

                              await FirebaseAuthService().signUpWithEmailPassword(mail, password, displayName: "$firstName $lastName");
                              context.read<TextFormCubit>().changeLoading(false);
                            },
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppStrings.alreadyHaveAccount),
                              TextButton(
                                onPressed: () {
                                  NavigatorService.pushNamed(AppRoutes.login);
                                },
                                child: Text(AppStrings.signIn),
                              ),
                            ],
                          ),

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
