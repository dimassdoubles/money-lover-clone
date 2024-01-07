import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:money_lover_clone/features/transaction/transaction.dart'
    as app_transaction;

@LazySingleton(as: app_transaction.TransactionRemoteRepo)
class FirebaseRemoteRepo implements app_transaction.TransactionRemoteRepo {
  static const collectionName = "transactions";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<void> addTransaction({
    required int amount,
    required app_transaction.TransactionCategory category,
    required DateTime dateTime,
    String? description,
    File? image,
  }) async {
    try {
      DateTime now = DateTime.now();
      String epochString = now.millisecondsSinceEpoch.toString();
      final String id =
          "TRX${now.year}${now.month.toString().padRight(2, '0')}${now.day.toString().padRight(2, '0')}-${epochString.substring(epochString.length - 4)}";
      String downloadUrl = await _upload(image);

      CollectionReference transactions = _firestore.collection(collectionName);
      transactions
          .doc(id)
          .set(
            {
              "amount": amount,
              "categoryName": category.name,
              "categoryIconPath": category.iconPath,
              "categoryType": category.type.name,
              "description": description ?? "",
              "image": downloadUrl,
              "dateTime": dateTime.toString(),
              "userId": _auth.currentUser!.uid,
            },
          )
          .then((value) => debugPrint("transaction added"))
          .catchError(
              (error) => debugPrint("Failed to add transaction: $error"));
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

  Future<String> _upload(File? image) async {
    String downloadUrl = "";
    if (image != null) {
      String uniqueFilename = DateTime.now().millisecondsSinceEpoch.toString();

      Reference dirUpload =
          _storage.ref().child('upload/${_auth.currentUser!.uid}');
      Reference storedDir = dirUpload.child(uniqueFilename);

      await storedDir.putFile(image);

      downloadUrl = await storedDir.getDownloadURL();
    }
    return downloadUrl;
  }

  @override
  Future<List<app_transaction.Transaction>> getTransactionList() async {
    try {
      CollectionReference transactions = _firestore.collection(collectionName);
      final data = await transactions
          .where(
            "userId",
            isEqualTo: _auth.currentUser!.uid,
          )
          .get();

      final List<app_transaction.Transaction> result = [];
      for (QueryDocumentSnapshot documentSnapshot in data.docs) {
        // Access data using documentSnapshot.data()
        final data = documentSnapshot.data() as Map<String, dynamic>;

        debugPrint("$data");
        result.add(app_transaction.TransactionMapper.fromJson(
            documentSnapshot.id, data));
      }
      return result;
    } catch (e) {
      debugPrint("$e");
      rethrow;
    }
  }

  @override
  Future<void> editTransaction({
    required String id,
    int? amount,
    app_transaction.TransactionCategory? category,
    String? description,
    DateTime? dateTime,
    File? imageFile,
  }) async {
    String? imageUrl;

    // upload gambar dulu jika ada edit gambar
    if (imageFile != null) {
      imageUrl = await _upload(imageFile);
    }

    try {
      final parameters = {
        "amount": amount,
        "categoryIconPath": category?.iconPath,
        "categoryName": category?.name,
        "categoryType": category?.type.name,
        "dateTime": dateTime?.toString(),
        "description": description,
        "image": imageUrl,
      };

      DocumentReference transactionRef =
          _firestore.collection(collectionName).doc(id);

      await transactionRef.update(
        Map.fromEntries(
          parameters.entries.where(
            (element) => element.value != null,
          ),
        ),
      );
    } catch (e) {
      debugPrint("$e");
      rethrow;
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _firestore.collection(collectionName).doc(id).delete();
    } catch (e) {
      debugPrint("repo gagal delete");
      rethrow;
    }
  }
}
