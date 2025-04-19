import 'package:flutter/material.dart';
import 'package:tugaskelompok/loginpage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Text(
                'Welcome to our app',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 0),
                      blurRadius: 10.0,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 150,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF90BFFF),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 30,
                            left: 0,
                            right: 0,
                            bottom: 20,
                            child: _buildProfileImages(),
                          ),
                          Positioned(
                            top: 20,
                            left: 20,
                            child: _buildTag('Stopwatch', Colors.white),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: _buildTag('Cek Bilangan', Colors.white),
                          ),
                          Positioned(
                            bottom: 80,
                            left: 80,
                            child: _buildTag('Tracking LBS', Colors.white),
                          ),
                          Positioned(
                            bottom: 20,
                            right: 80,
                            child: _buildTag('Situs Rekomendasi', Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Text(
                          //   'Yahooodd',
                          //   style: TextStyle(
                          //     fontSize: 24,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.black,
                          //   ),
                          // ),
                          // const SizedBox(height: 10),
                          // const Text(
                          //   'Aplikasi makin yahooddddd...',
                          //   style: TextStyle(
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.w400,
                          //     color: Colors.grey,
                          //   ),
                          // ),
                          const SizedBox(height: 10),
                          _buildGetStartedButton(context),
                        ],
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

  Widget _buildProfileImages() {
    return Stack(
      children: [
        Positioned(
          top: 60,
          left: 30,
          child: Container(
            width: 150,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFFFD54F),
            ),
          ),
        ),
        Positioned(
          top: 100,
          right: 30,
          child: Container(
            width: 120,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFB6D5FF),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String text, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xFFFFD54F),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Get Started',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 5),
            Icon(Icons.arrow_forward, size: 18),
          ],
        ),
      ),
    );
  }
}
