import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

import '../../repository/diploma_repository.dart';

part 'diploma_upload_state.dart';

class DiplomaUploadCubit extends Cubit<DiplomaUploadState> {
  final DiplomaRepository repository;
  DiplomaUploadCubit({required this.repository}) : super(DiplomaInitial());

  PlatformFile? selectedFile;

  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      selectedFile = result.files.first;
      emit(DiplomaFileSelected(selectedFile!));
    }
  }

  Future<void> uploadFile(String userId) async {
    if (selectedFile == null) return;

    emit(DiplomaUploading(progress: 0));

    final file = File(selectedFile!.path!);
    final fileName = selectedFile!.name;

    final downloadUrl = await repository.uploadDiploma(
      userId: userId,
      file: file,
      fileName: fileName,
      onProgress: (p) => emit(DiplomaUploading(progress: p)),
    );

    await repository.saveDiplomaInfo(
      userId: userId,
      diplomaUrl: downloadUrl,
    );

    emit(DiplomaUploaded());
  }
}
