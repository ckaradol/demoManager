import 'package:demomanager/core/bloc/text_form_cubit/text_form_cubit.dart';
import 'package:demomanager/core/constants/app_strings.dart';
import 'package:demomanager/core/enums/app/app_spacing.dart';
import 'package:demomanager/core/services/firebase_auth_service/firebase_auth_service.dart';
import 'package:demomanager/core/widgets/app_button.dart';
import 'package:demomanager/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/navigator_service/navigator_service.dart';
import '../../core/services/show_toast.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TextFormCubit(),
      child: BlocBuilder<TextFormCubit, bool>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              leading: IconButton(
                onPressed: () {
                  NavigatorService.pop();
                },
                icon: Icon(Icons.arrow_back),
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            body: ListView(
              padding: EdgeInsets.all(AppSpacing.defaultSpace),
              children: [
                AppTextFormField(labelText: AppStrings.emailId, controller: context.read<TextFormCubit>().controllerMail, textInputType: TextInputType.emailAddress),
                SizedBox(height: AppSpacing.defaultSpace),
                AppButton(
                  text: AppStrings.resetMyPassword,
                  onTap: () {
                    String mail = context.read<TextFormCubit>().controllerMail.text.trim();

                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(mail)) {
                      context.read<TextFormCubit>().changeLoading(false);

                      showToast("Hata", AppStrings.errorInvalidEmail, true);

                      return;
                    }

                    FirebaseAuthService().sendPasswordResetEmail(context.read<TextFormCubit>().controllerMail.text);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
