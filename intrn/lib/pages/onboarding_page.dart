import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:intrn/onboarding_controller.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  final controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              onBoardingPage(
                image: "assets/images/onboarding_images/Onboarding1.gif",
                title: "Search job easier\nand more Effective",
                subTitle: "Discover thousands of job opportunities tailored to your skills \n— all in one place.",
              ),
              onBoardingPage(
                image: "assets/images/onboarding_images/Onboarding2.gif",
                title: "Apply for job\nAnywhere & Anytime",
                subTitle: "No boundaries, no limits.\nSubmit your job application whenever and wherever you are.",
              ),
              onBoardingPage(
                image: "assets/images/onboarding_images/Onboarding3.gif",
                title: "Help Find the Right Job\nwith Your desire",
                subTitle: "Let us guide you to the perfect job \nthat fits your passion and goals.",
              ),
            ],
          ),

          onBoardingSkip(),

          onBoardingDot(),

          onBoardingNext()
        ],
      )
    );
  }
}

class onBoardingNext extends StatelessWidget {
  const onBoardingNext({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 64,
      right: 32,
      child: ElevatedButton(
        onPressed: () => OnboardingController.Instance.nextPage(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 255, 96, 0),
          elevation: 2,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: const StadiumBorder(),
        ),
        child: Text(
          "Next",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      )
    );
  }
}

class onBoardingSkip extends StatelessWidget {
  const onBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 64,
      left: 32,
      child: ElevatedButton(
        onPressed: () => OnboardingController.Instance.skipPage,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 2,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: const StadiumBorder(),
          side: BorderSide(color: Color.fromARGB(255, 255, 96, 0))
        ),
        child: Text(
          "Skip",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
            color: Color.fromARGB(255, 255, 96, 0),
          ),
        )
      )
    );
  }
}

class onBoardingDot extends StatelessWidget {
  
  const onBoardingDot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.Instance;

    return Positioned(
      bottom: 80,
      left: 0,
      right: 0,
      child: Center(
        child: SmoothPageIndicator(controller: controller.pageController, count: 3, 
          onDotClicked: controller.dotNavigationClick,
          effect: ExpandingDotsEffect(activeDotColor: Color.fromARGB(255, 255, 122, 39), dotHeight: 6),
        ),
      ),
    );
  }
}

class onBoardingPage extends StatelessWidget {
  const onBoardingPage({
    super.key,
    required this.image, required this.title, required this.subTitle
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 179, 117),
      ),
      child: Column(
        children: [
          SizedBox(height: 200,),
          Image(
            image: AssetImage(image),
            width: 320,
            height: 320,
          ),
          SizedBox(height: 32,),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft:Radius.circular(40), topRight: Radius.circular(40)),
              ),
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    SizedBox(height: 8,),
                    Text(
                      subTitle,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}