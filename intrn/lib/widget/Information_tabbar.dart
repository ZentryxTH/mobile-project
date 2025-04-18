import 'package:flutter/material.dart';

class AboutContent extends StatelessWidget {
  const AboutContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Text(
            'About this job',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Manage and administer equipment within the organization' ,
            style: TextStyle(color: Colors.grey[600]),
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
            'This job would contain all the important information about the job responsibilities, requirements, and other relevant details.',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          
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
          const SizedBox(height: 16),
          const Text(
            'About Company',
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
            'Location',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '• 9 Ratchadaphisek Road, Chatuchak Subdistrict,\n Chatuchak District, Bangkok 10900',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

class ReviewContent extends StatefulWidget {
  const ReviewContent({super.key});

  @override
  State<ReviewContent> createState() => _ReviewContentState();
}

class _ReviewContentState extends State<ReviewContent> {
  final List<Review> reviews = [
    Review(
      name: 'Ken Nigiyama',
      position: 'Ex-employee',
      review: 'I love to working with google! It has good environment and friendly employee. I recommend to work there.',
      isLiked: false,
      
    ),
    Review(
      name: 'Jane Smith',
      position: 'Current employee',
      review: 'Great company culture and work-life balance. The projects are challenging but rewarding.',
      isLiked: false,
      
    ),
    Review(
      name: 'Robert Johnson',
      position: 'Former intern',
      review: 'Learned a lot during my internship. The mentorship program was excellent.',
      isLiked: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          
          const SizedBox(height: 16),
          ...reviews.map((review) => _buildReviewCard(review)).toList(),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    return Card(
      color: const Color.fromARGB(255, 245, 245, 245),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                    image: const DecorationImage(
                      image: AssetImage('assets/images/scblogo.png'), 
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        review.position,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        review.isLiked ? Icons.thumb_up_alt_outlined : Icons.thumb_up_alt_outlined,
                        color: review.isLiked ? Colors.lightBlue : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          review.isLiked = !review.isLiked;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              review.review,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}

class Review {
  String name;
  String position;
  String review;
  bool isLiked;

  Review({
    required this.name,
    required this.position,
    required this.review,
    required this.isLiked,
    
  });
}