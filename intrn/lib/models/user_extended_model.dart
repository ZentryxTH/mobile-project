import 'package:cloud_firestore/cloud_firestore.dart';

class UserExtendedModel {
  String? biography;
  String? address1;
  String? address2;
  String? city;
  
  UserExtendedModel({
    this.biography,
    this.address1,
    this.address2,
    this.city,
  });

  Map<String, dynamic> toJson() => {
    "biography": biography,
    "address1": address1,
    "address2": address2,
    "city": city,
  };

  factory UserExtendedModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return UserExtendedModel(
      biography: data['biography'],
      address1: data['address1'],
      address2: data['address2'],
      city: data['city'],
    );
  }

  Future<void> saveUserExtendedData(String userId, UserExtendedModel extendedModel) async {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('extended')
        .doc('profile'); // fixed doc ID for easy retrieval

    await docRef.set(extendedModel.toJson());
  }

  Future<UserExtendedModel?> fetchUserExtendedData(String userId) async {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('extended')
        .doc('profile');

    final snapshot = await docRef.get();

    if (snapshot.exists) {
      return UserExtendedModel.fromSnapshot(snapshot);
    } else {
      return null; // no data yet
    }
  }
}