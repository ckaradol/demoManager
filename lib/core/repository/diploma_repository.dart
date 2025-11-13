import 'dart:io';

abstract class DiplomaRepository {
  Future<String> uploadDiploma({
    required String userId,
    required File file,
    required String fileName,
    Function(double)? onProgress,
  });

  Future<void> saveDiplomaInfo({
    required String userId,
    required String diplomaUrl,
  });
}
