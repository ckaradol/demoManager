import 'package:demomanager/features/auth/login_screen/login_screen.dart';
import 'package:demomanager/features/auth/register_screen/register_screen.dart';
import 'package:demomanager/features/diploma_upload/diploma_upload_screen.dart';
import 'package:demomanager/features/home/home_screen.dart';
import 'package:demomanager/features/product_detail_screen/product_detail_screen.dart';
import 'package:demomanager/features/splash/splash_screen.dart';
import 'package:demomanager/features/verification_wait_screen/verification_wait_screen.dart';
import 'package:flutter/material.dart';

import '../../features/forgot_password/forgot_password.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.register:
        return _fadeRoute(const RegisterScreen(), settings);
      case AppRoutes.splash:
        return _fadeRoute(const SplashScreen(), settings);
      case AppRoutes.login:
        return _fadeRoute(const LoginScreen(), settings);
      case AppRoutes.home:
        return _fadeRoute(const HomeScreen(), settings);
      case AppRoutes.upload:
        return _fadeRoute(const DiplomaUploadScreen(), settings);
      case AppRoutes.wait:
        return _fadeRoute(const VerificationWaitScreen(), settings);
      case AppRoutes.forgotPassword:
        return _fadeRoute(const ForgotPassword(), settings);
      case AppRoutes.productDetail:
        return _fadeRoute(const ProductDetailScreen(), settings);
      default:
        return _fadeRoute(const Scaffold(body: Center(child: Text('Route not found'))), settings);
    }
  }

  static PageRouteBuilder _fadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
