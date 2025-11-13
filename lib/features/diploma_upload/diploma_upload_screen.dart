import 'package:demomanager/core/bloc/auth_bloc/auth_bloc.dart';
import 'package:demomanager/core/constants/app_strings.dart';
import 'package:demomanager/core/routes/app_routes.dart';
import 'package:demomanager/core/services/diploma_service/diploma_service.dart';
import 'package:demomanager/core/services/firebase_auth_service/firebase_auth_service.dart';
import 'package:demomanager/core/services/navigator_service/navigator_service.dart';
import 'package:demomanager/core/services/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/bloc/diploma_upload_cubit/diploma_upload_cubit.dart';
import '../../core/enums/app/app_spacing.dart';

class DiplomaUploadScreen extends StatelessWidget {
  const DiplomaUploadScreen({super.key});



  @override
  Widget build(BuildContext context) {
    AuthState authState=context.read<AuthBloc>().state;
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => DiplomaUploadCubit(repository: DiplomaService()),
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(onPressed: (){
              FirebaseAuthService().signOut();
            }, icon: Icon(Icons.arrow_back)),
            elevation: 0,
            backgroundColor: theme.scaffoldBackgroundColor,
            title:  Text(AppStrings.diplomaTitle)),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocConsumer<DiplomaUploadCubit, DiplomaUploadState>(
            listener: (context, state) {
              if (state is DiplomaUploaded) {
               showToast(AppStrings.diplomaSuccessTitle, AppStrings.diplomaSuccessMessage, false);
               NavigatorService.pushAndRemoveUntil(AppRoutes.home);
              }
            },
            builder: (context, state) {
              final cubit = context.read<DiplomaUploadCubit>();
              final file = cubit.selectedFile;

              double progress = 0;
              if (state is DiplomaUploading) progress = state.progress;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: file == null
                        ?  Text(AppStrings.diplomaNoFile)
                        : Text('${file.name} '
                        '(${(file.size / 1024 / 1024).toStringAsFixed(2)} MB)'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => cubit.selectFile(),
                          icon: const Icon(Icons.attach_file),
                          label:  Text(AppStrings.diplomaChooseFile),
                        ),
                      ),
                      const SizedBox(width: 12),
                      if(authState is AuthLogin)
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: state is DiplomaUploading
                              ? null
                              : () => cubit.uploadFile(authState.user.uid),
                          icon: const Icon(Icons.upload),
                          label:  Text(AppStrings.diplomaUpload),
                        ),
                      ),
                    ],
                  ),
                  if (state is DiplomaUploading) ...[
                    const SizedBox(height: 20),
                    LinearProgressIndicator(value: progress),
                    const SizedBox(height: 8),
                    Text(AppStrings.diplomaLoadingPercent((progress * 100).toStringAsFixed(0))),
                  ],
                  SizedBox(height: AppSpacing.xLargeSpace,),
                  Text(
                    AppStrings.diplomaHint,
                    style: theme.textTheme.bodySmall!
                        .copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
