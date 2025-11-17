import 'package:demomanager/core/bloc/auth_bloc/auth_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import 'core/bloc/theme_cubit/theme_cubit.dart';
import 'core/constants/app_translate.dart';
import 'core/helper/flutter_local_notifications.dart';
import 'core/routes/app_router.dart';
import 'core/routes/app_routes.dart';
import 'core/services/navigator_service/navigator_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  runApp(
    BlocProvider(
      create: (_) => ThemeCubit(),
      child: EasyLocalization(supportedLocales: AppTranslate.supportedLocales, path: AppTranslate.assetLocations, fallbackLocale: AppTranslate.fallBackLocale, child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(AuthInitialEvent()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLogin) {
            initNotifications(context);
            FirebaseMessaging.onMessage.listen((RemoteMessage message) {
              showNotification(message);
            });
            FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
          }
        },
        builder: (context, state) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, state) {
              return ToastificationWrapper(
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Demo',
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  navigatorKey: NavigatorService.navigatorKey,
                  onGenerateRoute: AppRouter.onGenerateRoute,
                  initialRoute: AppRoutes.splash,
                  darkTheme: ThemeData(
                    fontFamily: "Rubik",
                    useMaterial3: false,
                    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff0063E6), brightness: Brightness.dark),
                  ),
                  themeMode: state,
                  theme: ThemeData(
                    fontFamily: "Rubik",
                    useMaterial3: false,
                    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff0063E6)),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
