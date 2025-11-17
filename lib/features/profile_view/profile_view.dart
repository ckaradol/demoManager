import 'package:demomanager/core/bloc/auth_bloc/auth_bloc.dart';
import 'package:demomanager/core/services/firebase_auth_service/firebase_auth_service.dart';
import 'package:demomanager/core/services/navigator_service/navigator_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/bloc/theme_cubit/theme_cubit.dart';
import '../../core/constants/app_strings.dart';
import '../../core/helper/change_language.dart';
import '../../core/widgets/change_name.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    AuthState authState = context.read<AuthBloc>().state;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(AppStrings.profile, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
      ),
      body: ListView(
        children: [
          if (authState is AuthLogin)
            ListTile(
              onTap: () {
                showDialog(context: context, builder: (context) => ChangeName());
              },
              title: Text(authState.userValue.fullName),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
            ),
          ListTile(
            onTap: () async {
              changeLanguage(context);
            },
            title: Text(AppStrings.language),
            trailing: Text(context.locale.languageCode == "tr" ? "🇹🇷" : "🇬🇧"),
          ),
          ListTile(
            onTap: () {
              context.read<ThemeCubit>().setTheme(
                context.read<ThemeCubit>().state == ThemeMode.dark ? ThemeMode.light : (context.read<ThemeCubit>().state == ThemeMode.light ? ThemeMode.system : ThemeMode.dark),
              );
            },
            title: Text(
              context.watch<ThemeCubit>().state == ThemeMode.dark
                  ? AppStrings.darkMode
                  : context.watch<ThemeCubit>().state == ThemeMode.light
                  ? AppStrings.lightMode
                  : AppStrings.systemMode,
            ),
            trailing: Icon(
              context.watch<ThemeCubit>().state == ThemeMode.dark
                  ? Icons.shield_moon
                  : context.watch<ThemeCubit>().state == ThemeMode.system
                  ? Icons.phone_android
                  : Icons.sunny,
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(AppStrings.logout),
                  content: Text(AppStrings.logoutQuestion),
                  actions: [
                    TextButton(
                      onPressed: () {
                        NavigatorService.pop();
                      },
                      child: Text(AppStrings.logoutCancel),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        FirebaseAuthService().signOut();
                      },
                      child: Text(AppStrings.logoutConfirm),
                    ),
                  ],
                ),
              );
            },
            title: Text(AppStrings.logout),
            trailing: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
