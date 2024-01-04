import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:money_lover_clone/features/transaction/data/repositories/remote/transaction_remote_repo.dart';
import 'package:money_lover_clone/features/transaction/domain/models/transaction_category.dart';

@LazySingleton(as: TransactionRemoteRepo)
class FirebaseRemoteRepo implements TransactionRemoteRepo {
  static const collectionName = "transactions";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addTransaction({
    required int amount,
    required TransactionCategory category,
    required DateTime dateTime,
    String? description,
    File? image,
  }) async {
    try {
      DateTime now = DateTime.now();
      String epochString = now.millisecondsSinceEpoch.toString();
      final String id =
          "TRX${now.year}${now.month.toString().padRight(2, '0')}${now.day.toString().padRight(2, '0')}-${epochString.substring(epochString.length - 4)}";

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
              "image": "",
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
}
