import 'package:demomanager/core/extensions/app/app_column_gap_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/text_form_cubit/text_form_cubit.dart';
import '../constants/app_strings.dart';
import '../enums/app/app_spacing.dart';
import '../services/firebase_auth_service/firebase_auth_service.dart';
import '../services/firestore_service/firestore_service.dart';
import '../services/navigator_service/navigator_service.dart';
import 'app_text_form_field.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    AuthState authState = context.read<AuthBloc>().state;
    return BlocProvider(
      create: (context) => TextFormCubit(),
      child: BlocBuilder<TextFormCubit, bool>(
        builder: (context, state) {
          return AlertDialog(
            title: Text(AppStrings.changeNameDialogTitle),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextFormField(labelText: AppStrings.firstName, controller: context.read<TextFormCubit>().controllerFirstName),
                AppTextFormField(labelText: AppStrings.lastName, controller: context.read<TextFormCubit>().controllerLastName),
              ],
            ).withGap(AppSpacing.defaultSpace),
            actions: [
              TextButton(
                onPressed: () {
                  NavigatorService.pop();
                },
                child: Text(AppStrings.cancel),
              ),
              ElevatedButton(
                onPressed: () {
                  if (authState is AuthLogin) {
                    FirebaseAuthService().updateName("${context.read<TextFormCubit>().controllerFirstName.text} ${context.read<TextFormCubit>().controllerLastName.text}");
                    FirestoreService().updateUserNameData(
                      userId: authState.user.uid,
                      fullName: "${context.read<TextFormCubit>().controllerFirstName.text} ${context.read<TextFormCubit>().controllerLastName.text}",
                    );
                  }
                },
                child: Text(AppStrings.confirm),
              ),
            ],
          );
        },
      ),
    );
  }
}
