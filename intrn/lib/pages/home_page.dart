import 'package:flutter/material.dart';
import 'package:intrn/category_filter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = "All";

  void onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  void initState() {
    super.initState();
    // _getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: homeAppBar(),
      body: Column(
        children: [
          SizedBox(height: 24),
          Center(
            child: SizedBox(
              width: 320,
              child: searchBox(),
            ),
          ),
          SizedBox(height: 16,),
          CategoryFilter(onCategorySelected: onCategorySelected),
          const SizedBox(height: 20),
        ],
      )
    );
  }

  AppBar homeAppBar() {
    return AppBar(
      title: Text(
        "Hello, John Doe",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: "Poppins",
        )
      ),
      backgroundColor: Color(0xFFF5F5F5),
      leading: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image(image: AssetImage("assets/images/Intrnip.png"))
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.notifications_outlined,
                      color: Colors.black,
                      size: 32,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat_outlined,
                      color: Colors.black,
                      size: 32,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      centerTitle: false,
      shadowColor: Colors.black,
      elevation: 2,
    );
  }

  SearchBar searchBox() {
    return SearchBar(
              leading: const Icon(Icons.search, size: 32),
              hintText: "Search",
              hintStyle: WidgetStateProperty.all(
                TextStyle(
                  fontFamily: "Poppins", 
                  fontSize: 16, 
                  color: Colors.grey,
                ),
              ),
              backgroundColor: WidgetStateProperty.all(Colors.white),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: Colors.black,
                    width: 1.5,
                  ),
                ),
              ),
              padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(horizontal: 16.0),
              ),
              trailing: [
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black, // Background color of the button
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                    child: Icon(Icons.tune, color: Colors.white), // Sorting icon
                  ),
                )
              ],
              textStyle: WidgetStateProperty.all(
                TextStyle(fontFamily: "Poppins",fontSize: 16,color: Colors.black)
              ),
            );
  }
}
