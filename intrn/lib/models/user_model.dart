import 'package:cloud_firestore/cloud_firestore.dart';


class UserModel {
  final String? id; // Firebase document ID (optional)
  final String firstName;
  final String lastName;
  final String email;
  final String birthDate;
  final String phone;
  final String country;
  String? imageUrl; // Nullable imageUrl to handle missing image

  // Constructor
  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthDate,
    required this.phone,
    required this.country,
    this.imageUrl, // Make imageUrl nullable here
  });

  // Convert object to JSON for saving to Firebase
  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "birthDate": birthDate,
      "phone": phone,
      "country": country,
      "imageUrl": imageUrl, // imageUrl can be null
    };
  }

  // Convert Firebase document to UserModel (for reading)
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return UserModel(
      id: doc.id,
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      birthDate: data['birthDate'],
      phone: data['phone'],
      country: data['country'],
      imageUrl: data['imageUrl'], // imageUrl can be null in Firestore
    );
  }
}