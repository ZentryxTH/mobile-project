import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:intrn/models/user_model.dart';
import 'package:intrn/data/database/image_database_helper.dart';
import 'package:intrn/models/user_extended_model.dart';

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
    if (!doc.exists) throw Exception("User not found");
    
    final user = UserModel.fromSnapshot(doc);
    final imageUrl = await _dbHelper.getImageUrlByUserId(userId);
    user.imageUrl = imageUrl ?? '';

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

  Future<void> createOrUpdateUserExtended(UserExtendedModel userExtended) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception("No authenticated user");

      await _db
          .collection('users')
          .doc(userId)
          .collection('extended')
          .doc('profile')
          .set(userExtended.toJson());
    } catch (e) {
      throw Exception("Failed to save extended user data: $e");
    }
  }

  Future<bool> userExists(String userId) async {
    final doc = await _db.collection('users').doc(userId).get();
    return doc.exists;
  }

  Future<UserExtendedModel?> getUserExtended() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return null;

    final doc = await _db
        .collection('users')
        .doc(userId)
        .collection('extended')
        .doc('profile')
        .get();

    if (!doc.exists) return null;

    return UserExtendedModel.fromSnapshot(doc);
  }

  Future<void> updateUserExtendedField(String field, dynamic value) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _db
        .collection('users')
        .doc(userId)
        .collection('extended')
        .doc('profile')
        .update({field: value});
  }
  }
