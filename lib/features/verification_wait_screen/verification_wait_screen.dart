import 'package:demomanager/core/bloc/auth_bloc/auth_bloc.dart';
import 'package:demomanager/core/bloc/diploma_upload_cubit/diploma_upload_cubit.dart';
import 'package:demomanager/core/enums/app/app_spacing.dart';
import 'package:demomanager/core/extensions/app/app_column_gap_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_strings.dart';
import '../../core/models/user_entity.dart';
import '../../core/services/diploma_service/diploma_service.dart';
import '../../core/widgets/upload_diploma.dart';

class VerificationWaitScreen extends StatelessWidget {
  const VerificationWaitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthState authState = context.read<AuthBloc>().state;
    return BlocProvider(
      create: (_) => DiplomaUploadCubit(repository: DiplomaService()),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.accountStatus), elevation: 0, backgroundColor: Theme.of(context).scaffoldBackgroundColor),
        body: Padding(
          padding:  EdgeInsets.all(AppSpacing.defaultSpace),
          child: Builder(
            builder: (context) {
              if (authState is! AuthLogin) {
                return const Center(child: CircularProgressIndicator());
              }

              if (authState.userValue.status == UserStatus.approved) {
                return _buildStatus(icon: Icons.verified, color: Colors.green, title: AppStrings.statusApprovedTitle, message: AppStrings.statusApprovedMessage);
              }

              if (authState.userValue.status == UserStatus.rejected) {
                return _buildStatus(
                    diplomaUpload: true,
                    icon: Icons.error_outline, color: Colors.red, title: AppStrings.statusRejectedTitle, message: AppStrings.statusRejectedMessage);
              }

              return _buildStatus(icon: Icons.hourglass_top, color: Colors.amber.shade800, title: AppStrings.statusPendingTitle, message: AppStrings.statusPendingMessage);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStatus({required IconData icon, required Color color, required String title, required String message,bool? diplomaUpload}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: color),
          Text(
            title,
            style: TextStyle(fontSize: 22, color: color, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(message, style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
          if(diplomaUpload==true)
          UploadDiploma(),
        ],
      ).withGap(AppSpacing.largeSpace),
    );
  }
}
