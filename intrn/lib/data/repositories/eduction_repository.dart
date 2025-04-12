import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intrn/models/education_model.dart';

class EducationRepository {
  final _db = FirebaseFirestore.instance;

  // CREATE
  Future<void> createEducation(EducationModel education) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");

    await _db
        .collection('users')
        .doc(uid)
        .collection('education')
        .add(education.toJson());
  }

  // READ
  Future<List<EducationModel>> getEducationList() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");

    final snapshot = await _db
        .collection('users')
        .doc(uid)
        .collection('education')
        .get();

    return snapshot.docs
        .map((doc) => EducationModel.fromSnapshot(doc))
        .toList();
  }

  // UPDATE
  Future<void> updateEducation(String eduId, EducationModel education) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");

    await _db
        .collection('users')
        .doc(uid)
        .collection('education')
        .doc(eduId)
        .update(education.toJson());
  }

  // DELETE
  Future<void> deleteEducation(String eduId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");

    await _db
        .collection('users')
        .doc(uid)
        .collection('education')
        .doc(eduId)
        .delete();
  }
}
