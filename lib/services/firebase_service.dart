import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../firebase_options.dart';

class FirebaseService {
  static init() async {
// Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }

  static FirebaseApp getAppInstance() {
    return Firebase.app();
  }

  static Future<void> deleteAppInstance() async {
    await Firebase.app().delete();
  }
}

class FireStoreService {
  late FirebaseFirestore firestore;

  late CollectionReference col;

  FireStoreService(String collectionName) {
    firestore = FirebaseFirestore.instance;
    col = firestore.collection(collectionName);
  }
  Stream<QuerySnapshot> retriveData() {
    return col.snapshots();
  }

  Future<Map<String, dynamic>> retriveDataMap() async {
    Map<String, dynamic> data = await col.get() as Map<String, dynamic>;
    return data;
  }

  getDatabyId(String docId) async {
    try {
      debugPrint(docId);
      return await col.doc(docId).get();
    } catch (e) {
      rethrow;
    }
  }

  insertData(Map<String, dynamic> value) async {
    try {
      await col.add(value);
      debugPrint("Data added value ");
    } catch (e) {
      rethrow;
    }
  }

  deleteData(String docId) async {
    try {
      await col.doc(docId).delete();
    } catch (e) {
      rethrow;
    }
  }

  updateData(String docId, Map<String, dynamic> newVal) async {
    try {
      await col.doc(docId).update(newVal);
    } catch (e) {
      rethrow;
    }
  }
}
