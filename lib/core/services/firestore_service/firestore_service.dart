import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demomanager/core/models/categories_model.dart';
import 'package:demomanager/core/models/product_model.dart';

import '../../models/user_entity.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateDoctorDiplomaData({required String userId, required String diplomaUrl}) async {
    await _firestore.collection('users').doc(userId).update({'diplomaUrl': diplomaUrl, 'isVerified': false, 'verificationStatus': 'pending'});
  }
 Future<void> updateUserNameData({required String userId, required String fullName}) async {
    await _firestore.collection('users').doc(userId).update({'fullName': fullName,});
  }

  Future<void> setUserValue({required String userId, required String email, required String fullName}) async {
    await _firestore.collection('users').doc(userId).set({"role": "doctor", "email": email, "fullName": fullName, 'isVerified': false, 'verificationStatus': 'pending'});
  }

  Stream<UserEntity?> usersSnapshotStream(String userId) {
    return _firestore.collection('users').doc(userId).snapshots().map((snapshot) {
      final data = snapshot.data();
      if (data == null) {
        return null;
      }

      return UserEntity.fromJson(data, snapshot.id);
    });
  }

  Stream<List<CategoryModel>?> categorySnapshotStream() {
    return _firestore.collection('categories').snapshots().map((snapshot) {
      return snapshot.docs.map((e) => CategoryModel.fromJson(e.data(), e.id)).toList();
    });
  }

  Stream<List<ProductModel>?> productsSnapshotStream({
    String? fields,
    String? catId,
  }) {
    Query query = _firestore.collection('products');

    if (fields != null && fields.trim().isNotEmpty) {
      query = query.where("searchKeywords", arrayContains: fields.toLowerCase().trim());
    }

    if (catId != null && catId.trim().isNotEmpty) {
      query = query.where("category", isEqualTo: catId);
    }

    return query.snapshots().map((snap) {
      return snap.docs.map((doc) => ProductModel.fromMap(doc.data() as Map<String,dynamic>)).toList();
    });
  }
}
