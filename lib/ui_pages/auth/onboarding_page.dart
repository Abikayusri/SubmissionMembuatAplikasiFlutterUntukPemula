import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:submission_flutter_untuk_pemula/ui_pages/auth/login_page.dart';

class OnboardingData {
  static const List<String> titles = [
    "One App For Everyone",
    "Build Using Our Heart",
    "Let's Go",
  ];

  static const List<String> subTitles = [
    "Our system is helping all people in one system",
    "System that make use our heart",
    "We will guide you to where you wanted it too",
  ];

  static const List<String> images = [
    'images/bosscha.jpg',
    'images/farm-house.jpg',
    'images/kawah-putih.jpg',
  ];
}

class OnboardingPages extends StatefulWidget {
  const OnboardingPages({super.key});

  @override
  State<OnboardingPages> createState() => _OnboardingPagesState();
}

class _OnboardingPagesState extends State<OnboardingPages> {
  int currentIndex = 0;
  final CarouselSliderController carouselController =
      CarouselSliderController();

  void _updateIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _handleNext() {
    if (currentIndex == 2) {
      _navigateToLogin();
    } else {
      carouselController.nextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return OnboardingMobile(
              currentIndex: currentIndex,
              carouselController: carouselController,
              onIndexChanged: _updateIndex,
              onSkip: _navigateToLogin,
              onNext: _handleNext,
            );
          } else {
            return OnboardingWeb(
              currentIndex: currentIndex,
              carouselController: carouselController,
              onIndexChanged: _updateIndex,
              onSkip: _navigateToLogin,
              onNext: _handleNext,
            );
          }
        },
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final int currentIndex;
  final CarouselSliderController carouselController;
  final Function(int) onIndexChanged;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final bool isWeb;

  const OnboardingContent({
    super.key,
    required this.currentIndex,
    required this.carouselController,
    required this.onIndexChanged,
    required this.onSkip,
    required this.onNext,
    this.isWeb = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            items: OnboardingData.images.map((imagePath) {
              return Image.asset(
                imagePath,
                height: 331,
                width: isWeb ? double.infinity : null,
                fit: isWeb ? BoxFit.cover : BoxFit.contain,
              );
            }).toList(),
            options: CarouselOptions(
              height: 331,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                onIndexChanged(index);
              },
            ),
            carouselController: carouselController,
          ),

          const SizedBox(height: 30),

          Text(
            OnboardingData.titles[currentIndex],
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 26),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              OnboardingData.subTitles[currentIndex],
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 60),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: onSkip,
                  child: const Text('SKIP', style: TextStyle(fontSize: 18)),
                ),

                Row(
                  children: List.generate(3, (index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentIndex == index
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    );
                  }),
                ),

                TextButton(
                  onPressed: onNext,
                  child: const Text('NEXT', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingMobile extends StatelessWidget {
  final int currentIndex;
  final CarouselSliderController carouselController;
  final Function(int) onIndexChanged;
  final VoidCallback onSkip;
  final VoidCallback onNext;

  const OnboardingMobile({
    super.key,
    required this.currentIndex,
    required this.carouselController,
    required this.onIndexChanged,
    required this.onSkip,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingContent(
      currentIndex: currentIndex,
      carouselController: carouselController,
      onIndexChanged: onIndexChanged,
      onSkip: onSkip,
      onNext: onNext,
      isWeb: false,
    );
  }
}

class OnboardingWeb extends StatelessWidget {
  final int currentIndex;
  final CarouselSliderController carouselController;
  final Function(int) onIndexChanged;
  final VoidCallback onSkip;
  final VoidCallback onNext;

  const OnboardingWeb({
    super.key,
    required this.currentIndex,
    required this.carouselController,
    required this.onIndexChanged,
    required this.onSkip,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingContent(
      currentIndex: currentIndex,
      carouselController: carouselController,
      onIndexChanged: onIndexChanged,
      onSkip: onSkip,
      onNext: onNext,
      isWeb: true,
    );
  }
}
