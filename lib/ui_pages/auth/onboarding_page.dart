import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:submission_flutter_untuk_pemula/ui_pages/auth/login_page.dart';

class OnboardingData {
  static const List<String> titles = [
    "Jual Beli Mobil Mudah",
    "Barang Full Inspeksi",
    "Gaskeun",
  ];

  static const List<String> subTitles = [
    "Menyediakan berbagai macam pilihan mobil yang sesuai dengan kebutuhan Anda",
    "Mobil sudah kita inspeksi agar customer puas",
    "Dah ayo buru pake aplikasi kita",
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
      body: SafeArea(
        child: LayoutBuilder(
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive image height
    final imageHeight = isWeb
        ? (screenHeight * 0.4).clamp(200.0, 400.0)
        : (screenHeight * 0.35).clamp(200.0, 331.0);

    // Responsive padding
    final horizontalPadding = isWeb
        ? (screenWidth * 0.1).clamp(20.0, 100.0)
        : 40.0;

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: screenHeight),
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image carousel with flexible height
              Flexible(
                flex: 3,
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: imageHeight,
                    minHeight: 200,
                  ),
                  child: CarouselSlider(
                    items: OnboardingData.images.map((imagePath) {
                      return Container(
                        width: screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            imagePath,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: imageHeight,
                      viewportFraction: isWeb ? 0.8 : 1.0,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: isWeb,
                      onPageChanged: (index, reason) {
                        onIndexChanged(index);
                      },
                    ),
                    carouselController: carouselController,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              // Content section
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Title
                      Text(
                        OnboardingData.titles[currentIndex],
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: isWeb ? 28 : 20,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // Subtitle
                      Text(
                        OnboardingData.subTitles[currentIndex],
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                          fontSize: isWeb ? 18 : 16,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      // Navigation controls
                      _buildNavigationControls(horizontalPadding),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationControls(double horizontalPadding) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isWeb ? 0 : 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Skip button - flexible width
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Opacity(
                opacity: currentIndex == 2 ? 0.0 : 1.0,
                child: TextButton(
                  onPressed: currentIndex == 2 ? null : onSkip,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: isWeb ? 16 : 12,
                      vertical: 8,
                    ),
                    minimumSize: Size.zero,
                  ),
                  child: Text(
                    'LEWATI',
                    style: TextStyle(
                      fontSize: isWeb ? 16 : 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Page indicators - center
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.only(right: index == 2 ? 0 : 8),
                  width: currentIndex == index ? 20 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: currentIndex == index
                        ? Colors.blue
                        : Colors.grey.withOpacity(0.5),
                  ),
                );
              }),
            ),
          ),

          // Next/Start button - flexible width
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onNext,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWeb ? 16 : 12,
                    vertical: 8,
                  ),
                  minimumSize: Size.zero,
                ),
                child: Text(
                  currentIndex == 2 ? 'MULAI' : 'LANJUTKAN',
                  style: TextStyle(
                    fontSize: isWeb ? 16 : 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
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
