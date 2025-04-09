class CategoryFilterList {
  String name;

  CategoryFilterList({
    required this.name,
  });

  static List<CategoryFilterList> getCategories() {
    List<CategoryFilterList> categories = [];

    categories.add(
      CategoryFilterList(name: "All",)
    );
    categories.add(
      CategoryFilterList(name: "Software Engineer",)
    );

    categories.add(
      CategoryFilterList(name: "UX/UI Designer",)
    );

    categories.add(
      CategoryFilterList(name: "Project Manager",)
    );

    categories.add(
      CategoryFilterList(name: "IT Support",)
    );

    categories.add(
      CategoryFilterList(name: "Graphic DEsigner")
    );
    
    return categories;
  }
}