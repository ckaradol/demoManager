import 'dart:async';

import 'package:demomanager/core/services/firestore_service/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/app_user.dart';
import '../../repository/auth_repository.dart';
import '../show_toast.dart';

class FirebaseAuthService implements AuthRepository {
  final fb.FirebaseAuth _auth;

  FirebaseAuthService({fb.FirebaseAuth? auth}) : _auth = auth ?? fb.FirebaseAuth.instance;

  @override
  AppUser? get currentUser => _auth.currentUser == null ? null : AppUser.fromFirebaseUser(_auth.currentUser!);

  @override
  Stream<AppUser?> authStateChanges() => _auth.authStateChanges().map((u) => u == null ? null : AppUser.fromFirebaseUser(u));

  @override
  Future<AppUser?> signInWithEmailPassword(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return cred.user == null ? null : AppUser.fromFirebaseUser(cred.user!);
    } on fb.FirebaseAuthException catch (e) {
      showToast("Error", e.message ?? "", true);
      return null;
    }
  }

  @override
  Future<AppUser?> signUpWithEmailPassword(String email, String password, {String? displayName, DateTime? dateTime}) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (displayName != null && cred.user != null) {
        await cred.user!.updateDisplayName(displayName);
        await FirestoreService().setUserValue(userId: cred.user?.uid ?? "", email: email, fullName: displayName);
        await cred.user!.reload();
      }
      return cred.user == null ? null : AppUser.fromFirebaseUser(cred.user!);
    } on fb.FirebaseAuthException catch (e) {
      showToast("Error", e.message ?? "", true);
      return null;
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user == null) throw StateError('No current user');
    await user.sendEmailVerification();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<AppUser?> signInWithGoogle() async {
    try {
      GoogleSignIn.instance.initialize(serverClientId: "1015054323027-gi1ongon2gjo0854340fhvrrqoae0tfn.apps.googleusercontent.com");
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = fb.GoogleAuthProvider.credential(idToken: googleAuth.idToken);

      final userCred = await _auth.signInWithCredential(credential);
      final user = userCred.user;

      if (user != null) {
        await FirestoreService().setUserValue(userId: user.uid, email: user.email ?? "", fullName: user.displayName ?? "");
      }
      return user == null ? null : AppUser.fromFirebaseUser(user);
    } on fb.FirebaseAuthException catch (e) {
      showToast("Error", e.message ?? "", true);
      return null;
    } on GoogleSignInException catch (e) {
      showToast("Error", e.description ?? "", true);
      return null;
    }
  }

  @override
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    Duration timeout = const Duration(seconds: 60),
    required void Function(String verificationId, int? resendToken) codeSent,
    required void Function(AppUser user) verificationCompleted,
    required void Function(String verificationId) codeAutoRetrievalTimeout,
    int? forceResendingToken,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeout,
        forceResendingToken: forceResendingToken,
        verificationCompleted: (fb.PhoneAuthCredential credential) async {
          try {
            final currentUser = _auth.currentUser;
            if (currentUser != null) {
              final userCred = await currentUser.linkWithCredential(credential);
              final user = userCred.user;
              if (user != null) verificationCompleted(AppUser.fromFirebaseUser(user));
            } else {
              final userCred = await _auth.signInWithCredential(credential);
              final user = userCred.user;
              if (user != null) verificationCompleted(AppUser.fromFirebaseUser(user));
            }
          } on fb.FirebaseAuthException catch (e) {
            showToast("Error", e.message ?? "", true);
          }
        },
        verificationFailed: (value) {
          showToast("Error", value.message ?? "", true);
        },
        codeSent: (String verificationId, int? resendToken) async {
          codeSent(verificationId, resendToken);
        },
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } on fb.FirebaseAuthException catch (e) {
      showToast("Error", e.message ?? "", true);
    }
  }

  @override
  Future<AppUser?> signInWithSmsCode(String verificationId, String smsCode, DateTime dateTime) async {
    try {
      final credential = fb.PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

      final currentUser = _auth.currentUser;
      fb.UserCredential userCred;

      if (currentUser != null) {
        userCred = await currentUser.linkWithCredential(credential);
      } else {
        userCred = await _auth.signInWithCredential(credential);
      }

      return userCred.user == null ? null : AppUser.fromFirebaseUser(userCred.user!);
    } on fb.FirebaseAuthException catch (e) {
      showToast("Error", e.message ?? "", true);
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await Future.wait([_auth.signOut(), GoogleSignIn.instance.signOut()]);
  }
}
