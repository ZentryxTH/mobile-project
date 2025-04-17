import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:intrn/models/user_model.dart';

class UserRepository {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;

  Future<void> createUser(UserModel user) async {
    try {
      final userId = _auth.currentUser!.uid;
      await _db.collection('users').doc(userId).set(user.toJson());
    } catch (e) {
      throw Exception("Failed to create user: $e");
    }
  }

  Future<String> uploadImage(File imageFile) async {
    try {
      final userId = _auth.currentUser!.uid;
      final ref = _storage.ref().child('profileImages/$userId.jpg');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      throw Exception("Image upload failed: $e");
    }
  }

   Future<UserModel> getUserById(String userId) async {
    final doc = await _db.collection('users').doc(userId).get();
    return UserModel.fromSnapshot(doc);
  }
}