import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:intrn/models/user_model.dart';
import 'package:intrn/data/database/image_database_helper.dart';

class UserRepository {
  final _dbHelper = ImageDatabaseHelper.instance;
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  
  // Save user data to Firestore (excluding image URL)
  Future<void> createUser(UserModel user) async {
    try {
      final userId = _auth.currentUser!.uid;
      
      // Store the rest of the user data in Firestore
      await _db.collection('users').doc(userId).set(user.toJson());
      
      // Check if imageUrl is null and insert an empty string if so
      final imageUrlToSave = user.imageUrl ?? ''; // Fallback to empty string if null
      
      // Save the image URL to SQLite
      await _dbHelper.insertImage(userId, imageUrlToSave);
    } catch (e) {
      throw Exception("Failed to create user: $e");
    }
  }

  // Get user data from Firestore
  Future<UserModel> getUserById(String userId) async {
    final doc = await _db.collection('users').doc(userId).get();
    final user = UserModel.fromSnapshot(doc);

    // Retrieve image URL from SQLite
    final imageUrl = await _dbHelper.getImageUrlByUserId(userId);
    user.imageUrl = imageUrl ?? '';  // Use the local image URL if available

    return user;
  }

  // Update user image URL in SQLite
  Future<void> updateImage(String userId, String imageUrl) async {
    try {
      // Update the image URL in SQLite
      await _dbHelper.insertImage(userId, imageUrl);

      // Optionally, you can also update the image URL in Firestore if needed
      await _db.collection('users').doc(userId).update({'imageUrl': imageUrl});
    } catch (e) {
      throw Exception("Failed to update image: $e");
    }
  }

  Future<bool> userExists(String userId) async {
    final doc = await _db.collection('users').doc(userId).get();
    return doc.exists;
  }
}
