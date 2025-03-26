import 'package:flutter/material.dart';
import 'package:intrn/category_filter.dart';
import 'package:intrn/job_card_list.dart';
import 'package:intrn/job_card.dart';
import 'package:intrn/recent_job.dart';
import 'package:intrn/recent_job_list.dart';

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
    List<RecentJobList> recentJobs = RecentJobList.getRecentJob();
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: homeAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: 16),
            JobListView(),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text("Recently Jobs",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: recentJobs.length,
              itemBuilder: (context, index) {
                return RecentJob(job: recentJobs[index]); // Updated to use RecentJob
              },
            )
          ],
        )
      ),
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

class JobListView extends StatelessWidget {
  const JobListView({super.key});

  @override
  Widget build(BuildContext context) {
    List<JobCardList> jobs = JobCardList.getJobList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: jobs.map((job) => JobCard(job: job)).toList(),
      ),
    );
 }
}