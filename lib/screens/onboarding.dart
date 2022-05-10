import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '/helpers/utils.dart';
import '../components/animated_particle.dart';
import '../components/background.dart';
import '../components/onboarding_page.dart';
import '../helpers/constants.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late PageController pageController;
  late int currentIndex;
  late Timer timer;

  late StreamSubscription<GyroscopeEvent> _gyroscopeSubscription;
  final List<double> _gyroscopeValues = [0, 0];

  final pages = const [
    OnboardingPageView(
        imageProvider: AssetImage('assets/design.png'),
        text: 'Design with our best tools'),
    OnboardingPageView(
        imageProvider: AssetImage('assets/treat.png'),
        text: 'Maintain and grow your business'),
    OnboardingPageView(
      imageProvider: AssetImage('assets/ship.png'),
      text: 'Ship your products to the world!',
    ),
  ];

  @override
  void initState() {
    pageController = PageController();
    currentIndex = 0;

    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues[0] = event.x;
        _gyroscopeValues[1] = event.z;
      });
    });

    timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (currentIndex < 2) {
        currentIndex++;

        pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      } else if (currentIndex == 2) {
        currentIndex = 0;
        pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _gyroscopeSubscription.cancel();

    timer.cancel();
    pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Stack(
          children: [
            ...List<Widget>.generate(
                200,
                (int index) =>
                    AnimatedParticle(accelerometerValues: _gyroscopeValues)),
            BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container()),
            Column(
              children: [
                Expanded(
                    child: PageView(
                  children: pages,
                  controller: pageController,
                  onPageChanged: (int idx) {
                    setState(() {
                      currentIndex = idx;
                    });
                  },
                )),
                buildIndicator(context),
                _buildGetStartedButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: defaultPadding * 2, bottom: defaultPadding * 2),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(defaultPadding))),
        onPressed: () {},
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  HexColor("5f2c82"),
                  HexColor("49a09d"),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.circular(defaultPadding)),
          child: Container(
            width: 180,
            height: 70,
            alignment: Alignment.center,
            child: Text(
              'Get Started',
              style: GoogleFonts.poppins(
                fontSize: 23.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(context) {
    return SmoothPageIndicator(
        controller: pageController,
        count: 3,
        effect: WormEffect(
          activeDotColor: HexColor("49a09d"),
          dotColor: HexColor("5f2c82"),
        ));
  }
}
