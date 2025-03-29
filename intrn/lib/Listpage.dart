import 'package:flutter/material.dart';

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
  int pageindex = 0 ;
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
      body: appbars(),
    );
  }
}

class appbars extends StatefulWidget {
  const appbars({super.key});

  @override
  State<appbars> createState() => AppbarState();
}

class AppbarState extends State<appbars> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
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
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_box_outlined, 
                              size: 70.0, 
                              color: Colors.grey, 
                            ),
                            SizedBox(
                              height: 8.0,
                            ), 
                            Text(
                              "Don't have any applications.", 
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(child: Text('In progress')),
                      Center(child: Text('Applied')),
                    ],
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
