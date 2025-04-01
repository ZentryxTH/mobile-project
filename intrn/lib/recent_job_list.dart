class RecentJobList {
  String companyName;
  String country;
  String city;
  String jobRole;
  List<String> labels;
  String companyLogo;
  bool isFavorited;

  RecentJobList({
    required this.companyName,
    required this.country,
    required this.city,
    required this.jobRole,
    required this.labels,
    required this.companyLogo,
    required this.isFavorited
  });

  static List<RecentJobList> getRecentJob() {
    List<RecentJobList> recentJob = [];

    recentJob.add(
      RecentJobList(
        companyName: "Kiatnakin Phatra Financial Group",
        country: "Thailand",
        city: "Bangkok",
        jobRole: "Data Engineer",
        labels: ["Full-time", "Hybrid", "Senior"],
        companyLogo: "",
        isFavorited: false
      ),
    );

    recentJob.add(
      RecentJobList(
        companyName: "GO7",
        country: "Thailand",
        city: "Bangkok",
        jobRole: "Backend Java Engineer",
        labels: ["Full-time", "Onsite", "Senior"],
        companyLogo: "",
        isFavorited: false
      )
    );

    recentJob.add(
      RecentJobList(
        companyName: "Sertis",
        country: "Thailand",
        city: "Bangkok",
        jobRole: "Data Engineer",
        labels: ["Full-time", "Onsite", "Intern"],
        companyLogo: "",
        isFavorited: false
      )
    );

    recentJob.add(
      RecentJobList(
        companyName: "Seagate Technology",
        country: "Thailand",
        city: "Samut Prakan",
        jobRole: "Data Science & AI Intern",
        labels: ["Full-time", "Onsite", "Intern"],
        companyLogo: "",
        isFavorited: false
      )
    );

    recentJob.add(
      RecentJobList(
        companyName: "Michelin",
        country: "Thailand",
        city: "Bangkok",
        jobRole: "Data Analyst",
        labels: ["Full-time", "Hybrid", "Intern"],
        companyLogo: "",
        isFavorited: false
      )
    );

    recentJob.add(
      RecentJobList(
        companyName: "Shopee",
        country: "Thailand",
        city: "Bangkok",
        jobRole: "Business Intelligence",
        labels: ["Full-time", "Onsite", "Senior"],
        companyLogo: "",
        isFavorited: false
      )
    );

    return recentJob;
  }
}