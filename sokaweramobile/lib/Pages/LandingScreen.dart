import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sokaweramobile/Pages/LoginScreen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 100),
              child: Image.asset("assets/img/character_landing.png"),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                "Save your time",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 35,
            ),
            child: Text(
              "Sebuah aplikasi yang akan membantu pekerjaan petugas pendataan.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
          Container(
            child: SizedBox(
              height: 50,
              width: 140,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Color(0xFF68b7d8),
                ),
                onPressed: () {
                  Get.to(LoginScreen());
                },
                child: Icon(
                  Icons.arrow_right_rounded,
                  color: Colors.white,
                  size: 52,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
