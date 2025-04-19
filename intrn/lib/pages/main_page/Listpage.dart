import 'package:flutter/material.dart';
import 'package:intrn/widgets/list_card.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => ListPagetate();
}

class ListPagetate extends State<ListPage> {
  List<String> favouriteList = ['IT Support'];
  List<String> inProgressList = ['IT Support'];
  List<String> appliedlist = ['IT Support'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbars(),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 235, 235, 235),
              child: const TabBar(
                indicatorColor: Colors.deepOrangeAccent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: 'Favourite'),
                  Tab(text: 'In progress'),
                  Tab(text: 'Applied'),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: TabBarView(
                  children: [
                    _buildJobList(favouriteList, "Don't have any favourite", isInProgress: false, isApplied: false),
                    _buildJobList(inProgressList, "Don't have any in progress", isInProgress: true, isApplied: false),
                    _buildJobList(appliedlist, "Don't have any applications", isInProgress: false, isApplied: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appbars() {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: Colors.transparent,
      flexibleSpace: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: AssetImage("assets/images/CardTemplate.png"),
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Job List',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildJobList(List<String> jobs, String emptyMessage, {required bool isInProgress, required bool isApplied}) {
    if (jobs.isEmpty) return _buildEmptyState(emptyMessage);

    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        return Mycard(
          jobTitle: jobs[index],
          isInProgress: isInProgress,
          isApplied: isApplied,
          onFavoriteToggle: (title, isFav) {
            setState(() {
              if (isFav) {
                favouriteList.add(title);
              } else {
                favouriteList.remove(title);
              }
            });
          },
        );
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.add_box_outlined,
            size: 70.0,
            color: Colors.grey,
          ),
          const SizedBox(height: 8.0),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
