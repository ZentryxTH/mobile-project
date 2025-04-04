import 'package:flutter/material.dart';
import 'simulate/Homepage.dart';
import 'package:intrn/widget/list_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: NavigationBars(),
      initialRoute: '/listpage',
      routes: {
        '/homepage': (context) =>  Homepage(),
        '/listpage': (context) =>  NavigationBars(),
        // '/profilepage': (context) => const ProfilePage(),
      },
    );
  }
}
class NavigationBars extends StatefulWidget {
  const NavigationBars({super.key});

  @override
  State<NavigationBars> createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationBars>{
  // const NavigationBars({super.key});
  int pageindex = 1 ;
  List<String> titles = <String>['Favourite', 'In progess', 'Applied'];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty .resolveWith<TextStyle>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(color: Colors.deepOrangeAccent);
            }else{
              return TextStyle(color: Colors.black);
            }
          }),
        ),
    child: NavigationBar(
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      selectedIndex: pageindex,
      onDestinationSelected: (int index) {
        setState(() {
          pageindex = index;
        });
        if (index == 0) {
              Navigator.pushNamed(context, '/homepage');
            } 
      },
      
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.home_outlined, color: pageindex == 0 ? Colors.deepOrangeAccent : null),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.list_alt_outlined, color: pageindex == 1 ? Colors.deepOrangeAccent : null),
          label: 'List',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outlined, color: pageindex == 2 ? Colors.deepOrangeAccent : null),
          label: 'Profile',
        ),
      ],
    ),
      ),
      body: Listpages(),
    );
  }
}

class Listpages extends StatefulWidget {
  const Listpages({super.key});

  @override
  State<Listpages> createState() => Listpagestate();
}

class Listpagestate extends State<Listpages> {
  List<String> favouriteList = ['data scrience'];
  List<String> inProgressList = [];
  List<String> applicationList = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3, 
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrangeAccent,
            title: Text(
              'Job List',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          
          ),
          body: Column(
            children: [
              Container(
                color: const Color.fromARGB(255, 235, 235, 235), 
                child: TabBar(
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
                     favouriteList.isEmpty
                          ? _buildEmptyState("Don't have any favourite")
                          : ListView.builder(
                            itemCount: favouriteList.length,
                            itemBuilder: (context, index) {
                              return Mycard(
                                jobTitle: favouriteList[index],
                                onFavoriteToggle: (title, isFav) {
                                  setState(() {
                                    if (isFav) {
                                      favouriteList.add(title);
                                    } else {
                                      favouriteList.remove(title);
                                    }
                                  }
                                  );
                                },
                              );

                            },
                          ),
                      inProgressList.isEmpty
                          ? _buildEmptyState("Don't have any in progress")
                          : ListView.builder(
                            itemCount: inProgressList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Text(inProgressList[index]),
                                ),
                              );
                            },
                          ),
                      applicationList.isEmpty
                          ? _buildEmptyState("Don't have any applications")
                          : ListView.builder(
                            itemCount: applicationList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Text(applicationList[index]),
                                ),
                              );
                            },
                          ),
                    ],
                ),
                ),
              ),
            ],
          ),
        ),

    );
  }
  Widget _buildEmptyState(String message) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_box_outlined,
          size: 70.0,
          color: Colors.grey,
        ),
        SizedBox(height: 8.0),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20.0,
          ),
        ),
      ],
    ),
  );
}
}
