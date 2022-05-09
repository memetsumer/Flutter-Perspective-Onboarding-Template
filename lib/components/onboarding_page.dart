import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/constants.dart';

class OnboardingPageView extends StatefulWidget {
  final ImageProvider imageProvider;
  final String text;
  const OnboardingPageView({
    Key? key,
    required this.imageProvider,
    required this.text,
  }) : super(key: key);

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: defaultPadding),
          Expanded(
            child: Image(
              fit: BoxFit.fitWidth,
              image: widget.imageProvider,
            ),
          ),
          Text(
            widget.text,
            style: GoogleFonts.poppins(
              fontSize: 23.0,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
