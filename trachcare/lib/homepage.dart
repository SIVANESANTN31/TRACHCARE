import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight * 0.9, // 90% of screen height
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: screenHeight * 0.47, // 47% of screen height
                    child: Container(
                      width: screenWidth,
                      height: screenHeight * 0.53, // 53% of screen height
                      decoration: const ShapeDecoration(
                        color: Color(0xFFEAE6FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.055, // 5.5% of screen width
                    top: screenHeight * 0.623, // 62.3% of screen height
                    child: Container(
                      width: screenWidth * 0.465, // 46.5% of screen width
                      height: screenHeight * 0.04, // 4% of screen height
                      decoration: ShapeDecoration(
                        color: const Color(0xFF3F3CFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.055, // 5.5% of screen width
                    top: screenHeight * 0.74, // 74% of screen height
                    child: Container(
                      width: screenWidth * 0.465, // 46.5% of screen width
                      height: screenHeight * 0.04, // 4% of screen height
                      decoration: ShapeDecoration(
                        color: const Color(0xFF3F3CFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.065, // 6.5% of screen width
                    top: screenHeight * 0.629, // 62.9% of screen height
                    child: SizedBox(
                      width: screenWidth * 0.18, // 18% of screen width
                      height: screenHeight * 0.02, // 2% of screen height
                      child: Text(
                        'Patient',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp, // Using Sizer for responsive font size
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.065, // 6.5% of screen width
                    top: screenHeight * 0.513, // 51.3% of screen height
                    child: SizedBox(
                      width: screenWidth * 0.17, // 17% of screen width
                      height: screenHeight * 0.019, // 1.9% of screen height
                      child: Text(
                        'Doctor',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp, // Using Sizer for responsive font size
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.07, // 7% of screen width
                    top: screenHeight * 0.746, // 74.6% of screen height
                    child: SizedBox(
                      width: screenWidth * 0.165, // 16.5% of screen width
                      height: screenHeight * 0.019, // 1.9% of screen height
                      child: Text(
                        'Admin',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp, // Using Sizer for responsive font size
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: screenWidth,
                      height: screenHeight * 0.4, // 40% of screen height
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(".assets/images/DASH.jpg"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
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
