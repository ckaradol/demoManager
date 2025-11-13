part of 'diploma_upload_cubit.dart';

abstract class DiplomaUploadState {}

class DiplomaInitial extends DiplomaUploadState {}

class DiplomaFileSelected extends DiplomaUploadState {
  final PlatformFile file;
  DiplomaFileSelected(this.file);
}

class DiplomaUploading extends DiplomaUploadState {
  final double progress;
  DiplomaUploading({required this.progress});
}

class DiplomaUploaded extends DiplomaUploadState {}
