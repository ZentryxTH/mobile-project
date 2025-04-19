import 'package:cloud_firestore/cloud_firestore.dart';

class EducationModel {
  String? id;
  String instructor;
  String faculty;
  String degree;
  String startDate;
  String endDate;

  EducationModel({
    this.id,
    required this.instructor,
    required this.faculty,
    required this.degree,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'instructor': instructor,
      'faculty': faculty,
      'degree': degree,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory EducationModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return EducationModel(
      instructor: data['instructor'] ?? '',
      faculty: data['faculty'] ?? '',
      degree: data['degree'] ?? '',
      startDate: data['startDate'] ?? '',
      endDate: data['endDate'] ?? '',
    );
  }
}
