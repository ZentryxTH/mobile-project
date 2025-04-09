import 'package:flutter/material.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: appbarCard(),
      body: SingleChildScrollView( 
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height + 200, 
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      padding: EdgeInsets.only(top: 60, left: 16, right: 16),
                      child: Column(
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'IT Support',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'SCB',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.map, color: Colors.orangeAccent),
                                    SizedBox(width: 4),
                                    Text(
                                      'Thailand, Bangkok',
                                      style:
                                          TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),
                          Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            alignment: WrapAlignment.center,
                            children: [
                              infoCard(Icons.monetization_on, "Salary"),
                              infoCard(Icons.work, "Job type\nFull-time"),
                              infoCard(Icons.wifi, "Work model\nOnline"),
                              infoCard(Icons.stacked_line_chart, "Level\nInternship"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 8,
              right: 8,
              child: applyButton(),
              ),
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/scblogo.png",
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appbarCard() {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: Colors.transparent,
      flexibleSpace: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: AssetImage("assets/images/CardTemplate.png"),
            fit: BoxFit.cover,
          ),
          Align(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                height: 10,
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.favorite_border),
                    Icon(Icons.share),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget infoCard(IconData icon, String text) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 5,
      child: Container(
        width: 150,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFE5D3),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(8),
              child: Icon(icon, color: Colors.orange),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 14),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget applyButton() {
    return ElevatedButton(
      onPressed: () {
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Text(
        'Apply the job',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
