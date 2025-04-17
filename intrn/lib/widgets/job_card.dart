import 'package:flutter/material.dart';
import 'package:intrn/models/job_card_list.dart';

class JobCard extends StatefulWidget {
  final JobCardList job;

  const JobCard({super.key, required this.job});

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 160,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage("assets/images/CardTemplate.png"),
          fit: BoxFit.fill,
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                widget.job.companyLogo,width: 40, height: 40,
                errorBuilder: (context, error, StackTrace) => Icon(Icons.business, size: 40, color: Colors.white),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.job.companyName,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 4,
                          color:  Color.fromARGB(255, 77, 77, 77),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "${widget.job.country}, ${widget.job.city}",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )
                  ),
                ],
              ),
              IconButton(
                onPressed: ((){
                  setState(() {
                    widget.job.isFavorited = !widget.job.isFavorited;
                  });
                }), 
                icon: Icon
                (
                  widget.job.isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: widget.job.isFavorited ? Colors.red : Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            widget.job.jobRole,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(2,2),
                  blurRadius: 4,
                  color: Colors.grey,
                )
              ],
            ),
          ),
          SizedBox(height: 6),
          Wrap(
            spacing: 6,
            children: widget.job.labels.map((label) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6), // Padding inside the capsule
                decoration: BoxDecoration(
                  color: _getLabelColor(label),
                  borderRadius: BorderRadius.circular(30), // Makes it capsule-shaped
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

Color _getLabelColor(String label) {
  switch (label) {
    case "Full-time":
      return Color.fromARGB(255, 255, 230, 199);
    case "Online":
      return Color.fromARGB(255, 75, 180, 255);
    case "Intern":
      return Color.fromARGB(255, 255, 206, 116);
    case "Hybrid":
      return Color.fromARGB(255, 255, 140, 140);
    case "Senior":
      return Color.fromARGB(255, 162, 255, 81);
    case "Onsite":
      return Color.fromARGB(255, 230, 230, 230);
    case "Part-time":
      return Color.fromARGB(255, 255, 199, 221);
    case "Junior":
      return Color.fromARGB(255, 208, 126, 255);
    case "New-Grad":
      return Color.fromARGB(255, 117, 140, 255);
    default:
      return Colors.black;
  }
}


