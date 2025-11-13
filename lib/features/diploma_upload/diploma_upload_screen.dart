import 'package:demomanager/core/constants/app_strings.dart';
import 'package:demomanager/core/services/diploma_service/diploma_service.dart';
import 'package:demomanager/core/services/firebase_auth_service/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/bloc/diploma_upload_cubit/diploma_upload_cubit.dart';
import '../../core/widgets/upload_diploma.dart';

class DiplomaUploadScreen extends StatelessWidget {
  const DiplomaUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => DiplomaUploadCubit(repository: DiplomaService()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              FirebaseAuthService().signOut();
            },
            color: Theme.of(context).colorScheme.onSurface,
            icon: Icon(Icons.arrow_back),
          ),
          elevation: 0,
          backgroundColor: theme.scaffoldBackgroundColor,
          title: Text(AppStrings.diplomaTitle, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
        ),
        body: UploadDiploma(),
      ),
    );
  }
}
