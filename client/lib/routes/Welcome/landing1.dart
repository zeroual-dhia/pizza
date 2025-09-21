import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:go_router/go_router.dart';

class Landing1 extends StatelessWidget {
  const Landing1({
    super.key,
    required this.controller,
    required this.count,
    required this.index,
  });
  final PageController controller;
  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      "assets/images/young-pretty-woman-eating-pizza-pizza.png",
      "assets/images/young-pretty-woman-eating-pizza-pizza1.png",
    ];
    List<String> texts = [
      "Get Delivered at your door step",
      "Pick Up Delivery at your door and enjoy",
    ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                  height: 450,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: index == 0 ? 28.0 : 15.0,
                ),
                child: Text(
                  texts[index],
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  "your food at your door step and just click on one step",
                  style: GoogleFonts.montserrat(
                    color: Color(0xff867878),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(3.1416),
                child: SmoothPageIndicator(
                  controller: controller,
                  count: count,
                  effect: ExpandingDotsEffect(
                    expansionFactor: 4,
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: const Color(0xFFEF1C26),
                    dotColor: Colors.red.shade200,
                  ),
                ),
              ),
              SizedBox(height: 50),
              InkWell(
                onTap: () {
                  if (index < count - 1) {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    context.go('/login');
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: index == 0 ? 130 : 100,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFEF1C26),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xffED8E92),
                        spreadRadius: 2,
                        blurRadius: 12,
                        offset: const Offset(5, 9),
                      ),
                    ],
                  ),
                  child: Text(
                    index == 0 ? "Next" : "Get Started",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
