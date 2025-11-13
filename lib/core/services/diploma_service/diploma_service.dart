import 'dart:io';

import '../../repository/diploma_repository.dart';
import '../firebase_storage_service/firebase_storage_service.dart';
import '../firestore_service/firestore_service.dart';

class DiplomaService implements DiplomaRepository {
  final FirebaseStorageService storageService = FirebaseStorageService();
  final FirestoreService firestoreService = FirestoreService();

  @override
  Future<String> uploadDiploma({required String userId, required File file, required String fileName, Function(double)? onProgress}) async {
    return await storageService.uploadDiplomaFile(userId: userId, file: file, fileName: fileName, onProgress: onProgress);
  }

  @override
  Future<void> saveDiplomaInfo({required String userId, required String diplomaUrl}) async {
    await firestoreService.updateDoctorDiplomaData(userId: userId, diplomaUrl: diplomaUrl);
  }
}
