import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:submission_flutter_untuk_pemula/ui_pages/auth/login_page.dart';

class OnboardingPages extends StatefulWidget {
  const OnboardingPages({super.key});

  @override
  State<OnboardingPages> createState() => _OnboardingPagesState();
}

class _OnboardingPagesState extends State<OnboardingPages> {
  int currentIndex = 0;
  CarouselSliderController carouselController = CarouselSliderController();

  List<String> titles = [
    "One App For Everyone",
    "Build Using Our Heart",
    "Let's Go",
  ];

  List<String> subTitles = [
    "Our system is helping all people in one system",
    "System that make use our heart",
    "We will guide you to where you wanted it too",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              items: [
                Image.asset('images/bosscha.jpg', height: 331),
                Image.asset('images/farm-house.jpg', height: 331),
                Image.asset('images/kawah-putih.jpg', height: 331),
              ],
              options: CarouselOptions(
                height: 331,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              carouselController: carouselController,
            ),

            SizedBox(height: 30),

            Text(
              titles[currentIndex],
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 26),

            Text(
              subTitles[currentIndex],
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 60),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // carouselController.animateToPage(2);

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text('SKIP', style: TextStyle(fontSize: 18)),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == 0 ? Colors.blue : Colors.grey,
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == 1 ? Colors.blue : Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == 2 ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      if (currentIndex == 2) {
                      } else {
                        carouselController.nextPage();
                      }
                    },
                    child: const Text('NEXT', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
