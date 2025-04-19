class JobCardList {
  String companyName;
  String country;
  String city;
  String jobRole;
  List<String> labels;
  String companyLogo;
  bool isFavorited;

  JobCardList({
    required this.companyName,
    required this.country,
    required this.city,
    required this.jobRole,
    required this.labels,
    required this.companyLogo,
    required this.isFavorited
  });

  static List<JobCardList> getJobList() {
    List<JobCardList> jobList = [];

    jobList.add(
      JobCardList(
        companyName: "Google",
        country: "Thailand",
        city: "Bangkok",
        jobRole: "IT Support",
        labels: ["Full-time", "Online", "Intern"],
        companyLogo: "assets/logo/google.png",
        isFavorited: false
      )
    );

    jobList.add(
      JobCardList(
        companyName: "IBM",
        country: "Thailand",
        city: "Bangkok",
        jobRole: "Data Engineer",
        labels: ["Full-time", "Hybrid", "Senior"],
        companyLogo: "assets/logo/ibm.png",
        isFavorited: false
      )
    );

    jobList.add(
      JobCardList(
        companyName: "Nike",
        country: "USA",
        city: "San Francisco",
        jobRole: "Marketing",
        labels: ["Full-time", "Hybrid", "Senior"],
        companyLogo: "assets/logo/nike.png",
        isFavorited: false
      )
    );

    jobList.add(
      JobCardList(
        companyName: "Suki Teenoi",
        country: "Thailand",
        city: "Bangkok",
        jobRole: "Cashier",
        labels: ["Part-time", "Onsite", "Junior"],
        companyLogo: "assets/logo/teenoi.png",
        isFavorited: false
      )
    );

    jobList.add(
      JobCardList(
        companyName: "Taobin",
        country: "Thailand",
        city: "Bangkok",
        jobRole: "Software Developer",
        labels: ["Full-time", "Hybrid", "Intern"],
        companyLogo: "assets/logo/taobin.png",
        isFavorited: false
      )
    );

     jobList.add(
      JobCardList(
        companyName: "Riot game",
        country: "USA",
        city: "Los Angeles",
        jobRole: "Game Developer",
        labels: ["Full-time", "Hybrid", "New-Grad"],
        companyLogo: "assets/logo/riot.png",
        isFavorited: false
      )
    );

    return jobList;
  }
}