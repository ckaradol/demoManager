import 'package:demomanager/core/bloc/auth_bloc/auth_bloc.dart';
import 'package:demomanager/core/constants/app_strings.dart';
import 'package:demomanager/core/extensions/app/app_column_gap_ext.dart';
import 'package:demomanager/core/routes/app_routes.dart';
import 'package:demomanager/core/services/diploma_service/diploma_service.dart';
import 'package:demomanager/core/services/firebase_auth_service/firebase_auth_service.dart';
import 'package:demomanager/core/services/navigator_service/navigator_service.dart';
import 'package:demomanager/core/services/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/bloc/diploma_upload_cubit/diploma_upload_cubit.dart';
import '../../core/enums/app/app_spacing.dart';
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
            icon: Icon(Icons.arrow_back),
          ),
          elevation: 0,
          backgroundColor: theme.scaffoldBackgroundColor,
          title: Text(AppStrings.diplomaTitle),
        ),
        body: UploadDiploma(),
      ),
    );
  }
}

