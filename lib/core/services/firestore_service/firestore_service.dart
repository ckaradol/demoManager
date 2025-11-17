import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demomanager/core/models/categories_model.dart';
import 'package:demomanager/core/models/product_model.dart';
import 'package:demomanager/core/models/stock_model.dart';

import '../../models/sale_model.dart';
import '../../models/user_entity.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateDoctorDiplomaData({required String userId, required String diplomaUrl}) async {
    await _firestore.collection('users').doc(userId).update({'diplomaUrl': diplomaUrl, 'isVerified': false, 'verificationStatus': 'pending'});
  }

  Future<void> updateUserNameData({required String userId, required String fullName}) async {
    await _firestore.collection('users').doc(userId).update({'fullName': fullName});
  }

  Future<void> updateOrderData({required String docId, required String saleId}) async {
    await _firestore.collection('order').doc(docId).update({'saleId': saleId});
  }

  Future<void> setUserValue({required String userId, required String email, required String fullName}) async {
    await _firestore.collection('users').doc(userId).set({"role": "doctor", "email": email, "fullName": fullName, 'isVerified': false, 'verificationStatus': 'pending'});
  }

  Future<void> setOrderValue({required String userId, required ProductModel product, required String region, required int count, required String docs}) async {
    Stock stock = Stock(total: product.stock.total - count, criticalLevel: product.stock.criticalLevel, skt: product.stock.skt);
    await _firestore.collection('order').add({"userId": userId, "productId": product.docId, "region": region, "count": count, "createdAt": DateTime.now().toIso8601String(), "saleId": null});
    _firestore.collection("products").doc(product.docId).update({"stock": stock.toMap()});
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

  Stream<List<SaleModel>> salesSnapshotStream(String userId, {bool sale = false, String? region}) {
    Query<Map<String, dynamic>> orderRef;
    if (sale) {
      orderRef = _firestore.collection('order').where('saleId', isEqualTo: userId);
    } else if (region != null) {
      orderRef = _firestore.collection('order').where('region', isEqualTo: region).where("saleId", isNull: true);
    } else {
      orderRef = _firestore.collection('order').where('userId', isEqualTo: userId);
    }

    return orderRef.snapshots().asyncMap((snapshot) async {
      final saleList = <SaleModel>[];

      for (final doc in snapshot.docs) {
        final data = doc.data();
        final productId = data['productId'];

        final productSnap = await _firestore.collection('products').doc(productId).get();
        final product = productSnap.exists ? ProductModel.fromMap(productSnap.data()!, productSnap.id) : null;

        saleList.add(SaleModel.fromJson(data, doc.id, product: product));
      }

      return saleList;
    });
  }

  Stream<List<ProductModel>?> productsSnapshotStream({String? fields, String? catId}) {
    Query query = _firestore.collection('products');

    if (fields != null && fields.trim().isNotEmpty) {
      query = query.where("searchKeywords", arrayContains: fields.toLowerCase().trim());
    }

    if (catId != null && catId.trim().isNotEmpty) {
      query = query.where("category", isEqualTo: catId);
    }

    return query.snapshots().map((snap) {
      return snap.docs.map((doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }
}
