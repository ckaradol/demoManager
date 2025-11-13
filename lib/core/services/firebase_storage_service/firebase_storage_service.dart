import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadDiplomaFile({
    required String userId,
    required File file,
    required String fileName,
    Function(double)? onProgress,
  }) async {
    final ref = _storage.ref().child('doctor_diplomas/$userId/$fileName');
    final uploadTask = ref.putFile(file);

    uploadTask.snapshotEvents.listen((event) {
      final progress = event.bytesTransferred / event.totalBytes;
      if (onProgress != null) onProgress(progress);
    });

    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }
}
