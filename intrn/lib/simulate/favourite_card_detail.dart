import 'package:flutter/material.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  int selectedIndex = 0;

  // final tabs = ["About", "Company", "Review"];
  final List<Widget> _contentPages = [
    const AboutContent(),
    const CompanyContent(),
    const ReviewContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: appbarCard(),
      body: SingleChildScrollView( 
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height + 50, 
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
                      padding: EdgeInsets.only(top: 60, left: 0, right: 0),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 40,left: 0,right: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildTabButton(0, 'About'),
                                _buildTabButton(1, 'Company'),
                                _buildTabButton(2, 'Review'),
                              ],
                            ),
                          ),
                          
                          Expanded(child: _contentPages[selectedIndex]),
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
      elevation: 3.5,
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

  Widget _buildTabButton(int index, String text) {
    bool isSelected = selectedIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white,
          borderRadius: BorderRadius.circular(0),
          boxShadow: isSelected ? [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 2,
              spreadRadius: 1,
              offset: const Offset(0, 1),
            )
          ] : [BoxShadow(
            color: Colors.grey.withOpacity(0.5),
              blurRadius: 0,
              spreadRadius: 1,
              offset: const Offset(1, -1),
          )],
          border: isSelected ? Border(
            bottom: BorderSide(
              color: Colors.orange,
              width: 3,
            ),
          ) : Border(
            top: BorderSide(
              color: const Color.fromARGB(255, 231, 231, 231)
            ),
            bottom: BorderSide(
              color: const Color.fromARGB(255, 231, 231, 231)
            ),
            left: BorderSide(
              color: const Color.fromARGB(255, 231, 231, 231)
            ),
            
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.orange : Colors.black,
          ),
        ),
      ),
    );
  }

}

class AboutContent extends StatelessWidget {
  const AboutContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About this job',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Job Description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Detailed job description goes here. This section would contain all the important information about the job responsibilities, requirements, and other relevant details.',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          const Text(
            'Requirements',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '• 3+ years of experience\n• Bachelor\'s degree in related field\n• Strong communication skills\n• Technical skills as required',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

class CompanyContent extends StatelessWidget {
  const CompanyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Company Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'About Us',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Company background and history goes here. This section would describe what the company does, its mission, vision, and values.',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          const Text(
            'Benefits',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '• Competitive salary\n• Health insurance\n• Flexible working hours\n• Professional development opportunities',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

class ReviewContent extends StatelessWidget {
  const ReviewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          
          const SizedBox(height: 16),
          _buildReviewCard(
            'John Doe',
            'Great company to work for with excellent benefits and work-life balance.',
            '5/5',
          ),
          const SizedBox(height: 12),
          _buildReviewCard(
            'Jane Smith',
            'Challenging projects and supportive team. Management could be better.',
            '4/5',
          ),
          const SizedBox(height: 12),
          _buildReviewCard(
            'Robert Johnson',
            'Good learning opportunities but salary could be more competitive.',
            '3.5/5',
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(String name, String review, String rating) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    rating,
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}