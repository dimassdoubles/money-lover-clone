import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_lover_clone/features/auth/auth.dart';

@LazySingleton(as: AuthRemoteRepo)
class FirebaseAuthRepo implements AuthRemoteRepo {
  static const collectionName = "users";
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<AppUser> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      // tambah user baru di firebase auth
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // menyimpan informasi user di firebase firestore
      CollectionReference users = _firestore.collection(collectionName);
      users
          .doc(userCredential.user!.uid)
          .set(
            {
              "name": name,
              "email": email,
              "phone": phone,
            },
          )
          .then((value) => debugPrint("User Added"))
          .catchError((error) => debugPrint("Failed to add user: $error"));

      return AppUser(
        id: userCredential.user!.uid,
        name: name,
        phone: phone,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }

      rethrow;
    } catch (e) {
      debugPrint("$e");
      rethrow;
    }
  }

  @override
  Future<AppUser> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      debugPrint("repo disini brooo");

      // cari data profil user
      CollectionReference users = _firestore.collection(collectionName);
      debugPrint("repo disini brooo 3");
      final data = await users.doc(credential.user!.uid).get();
      debugPrint("repo disini broo 2");

      return AppUser(
        id: credential.user!.uid,
        name: data["name"],
        phone: data["phone"],
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }

      rethrow;
    } catch (e) {
      debugPrint("$e");
      rethrow;
    }
  }
}
