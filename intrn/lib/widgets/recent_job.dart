import 'package:flutter/material.dart';
import 'package:intrn/models/recent_job_list.dart';

class RecentJob extends StatefulWidget {
  final RecentJobList job;

  const RecentJob({super.key, required this.job});

  @override
  State<RecentJob> createState() => _RecentJobTileState();
}

class _RecentJobTileState extends State<RecentJob> {
  late bool isFavorited;

  @override
  void initState() {
    super.initState();
    isFavorited = widget.job.isFavorited;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 239, 239, 239),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 202, 202, 202),
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: _buildCompanyLogo(),
        title: _buildJobTitle(),
        subtitle: _buildJobLabels(),
        trailing: _buildFavoriteIcon(),
      ),
    );
  }

  // Company Logo Widget
  Widget _buildCompanyLogo() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        widget.job.companyLogo,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            Icon(Icons.business, size: 50, color: Colors.grey),
      ),
    );
  }

  // Job Title Widget
  Widget _buildJobTitle() {
    return Text(
      widget.job.jobRole,
      style: TextStyle(
        fontSize: 16,
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  // Job Labels Widget
  Widget _buildJobLabels() {
    return Wrap(
      spacing: 6,
      children: widget.job.labels.map((label) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: _getLabelColor(label),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 8,
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        );
      }).toList(),
    );
  }

  // Favorite Icon Widget
  Widget _buildFavoriteIcon() {
    return IconButton(
      onPressed: () {
        setState(() {
          isFavorited = !isFavorited;
        });
      },
      icon: Icon(
        isFavorited ? Icons.favorite : Icons.favorite_border,
        color: isFavorited ? Colors.red : Colors.black,
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
