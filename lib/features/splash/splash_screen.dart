import 'package:demomanager/core/enums/assets/app_images.dart';
import 'package:demomanager/core/extensions/assets/app_images_ext.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: AppImages.logo.toImage(),),
    );
  }
}
