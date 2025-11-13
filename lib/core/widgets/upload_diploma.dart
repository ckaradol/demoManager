import 'package:demomanager/core/extensions/app/app_column_gap_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/diploma_upload_cubit/diploma_upload_cubit.dart';
import '../constants/app_strings.dart';
import '../enums/app/app_spacing.dart';
import '../routes/app_routes.dart';
import '../services/navigator_service/navigator_service.dart';
import '../services/show_toast.dart';

class UploadDiploma extends StatelessWidget {
  const UploadDiploma({super.key});

  @override
  Widget build(BuildContext context) {
    AuthState authState = context.read<AuthBloc>().state;
    final theme = Theme.of(context);
    return Padding(
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
                decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12)),
                child: file == null
                    ? Text(AppStrings.diplomaNoFile)
                    : Text(
                  '${file.name} '
                      '(${(file.size / 1024 / 1024).toStringAsFixed(2)} MB)',
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(onPressed: () => cubit.selectFile(), icon: const Icon(Icons.attach_file), label: Text(AppStrings.diplomaChooseFile)),
                  ),
                  const SizedBox(width: 12),
                  if (authState is AuthLogin)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: state is DiplomaUploading ? null : () => cubit.uploadFile(authState.user.uid),
                        icon: const Icon(Icons.upload),
                        label: Text(AppStrings.diplomaUpload),
                      ),
                    ),
                ],
              ),
              if (state is DiplomaUploading)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LinearProgressIndicator(value: progress),

                    Text(AppStrings.diplomaLoadingPercent((progress * 100).toStringAsFixed(0))),
                  ],
                ).withGap(AppSpacing.smallSpace),
              SizedBox(),
              Text(AppStrings.diplomaHint, style: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            ],
          ).withGap(AppSpacing.defaultSpace);
        },
      ),
    );
  }
}
