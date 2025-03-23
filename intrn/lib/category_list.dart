import 'package:flutter/material.dart';

class CategoryList {
  String name;
  Color boxColor;

  CategoryList({
    required this.name, required this.boxColor
  });

  static List<CategoryList> getCategories() {
    List<CategoryList> categories = [];

    categories.add(
      CategoryList(name: "All", boxColor: Color.fromARGB(255, 255, 120, 39))
    );
    categories.add(
      CategoryList(name: "Software Engineer", boxColor: Color(0xFFF5F5F5))
    );

    categories.add(
      CategoryList(name: "UX/UI Designer", boxColor: Color(0xFFF5F5F5))
    );

    categories.add(
      CategoryList(name: "Project Manager", boxColor: Color(0xFFF5F5F5))
    );

    categories.add(
      CategoryList(name: "IT Support", boxColor: Color(0xFFF5F5F5))
    );
    
    return categories;
  }
}