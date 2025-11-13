import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateDoctorDiplomaData({required String userId, required String diplomaUrl}) async {
    await _firestore.collection('users').doc(userId).update({'diplomaUrl': diplomaUrl, 'isVerified': false, 'verificationStatus': 'pending'});
  }

  Future<void> setUserValue({required String userId, required String email,required String fullName}) async {
    await _firestore.collection('users').doc(userId).set({
      "role":"doctor",
      "email":email,
      "fullName":fullName,
      'isVerified': false, 'verificationStatus': 'pending'});
  }
}
