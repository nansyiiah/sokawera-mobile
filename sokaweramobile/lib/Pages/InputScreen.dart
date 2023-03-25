import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'InputScreen/InputScreen1.dart';
import 'InputScreen/InputScreen2.dart';
import 'InputScreen/InputScreen3.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'InputScreen/InputScreen1.dart';
import 'InputScreen/InputScreen2.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  String name = "";
  String initial = "";
  bool _isFilled1 = false;
  bool _isFilled2 = false;

  void initState() {
    _getKeteranganTempatFromLocal();
    _getKeteranganPetugasFromLocal();
    _loadUserData();
    super.initState();
  }

  _getKeteranganTempatFromLocal() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var data = localStorage.getString('keterangan_tempat');

    if (data != null) {
      setState(() {
        _isFilled1 = true;
      });
      print(data);
    } else {
      return null;
    }
  }

  _getKeteranganPetugasFromLocal() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var data = localStorage.getString('keterangan_petugas');

    if (data != null) {
      setState(() {
        _isFilled2 = true;
      });
      print(data);
    } else {
      return null;
    }
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('user');
    if (user != null) {
      var inisial = localStorage.getString('username');
      setState(() {
        name = user;
        initial = inisial!;
      });
    } else {
      setState(() {
        name = "null";
      });
    }
  }

  List ketList = [
    "Keterangan Tempat",
    "Keterangan Responden",
    "Keterangan Sosial",
    "Khusus Pendidikan",
    "Kejadian Kelahiran",
    "Kejadian Kematian",
    "Khusus Kesehatan",
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFF68b7d8),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: size.height * 0.3,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/image-input.png"),
                ),
                color: Color(0xFF68b7d8),
              ),
            ),
            Container(
              height: size.height * 1,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 24, top: 40),
                                child: Container(
                                  child: Text(
                                    "Input data",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 24),
                                child: Container(
                                  child: Text(
                                    "All you need to do is follow these steps",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 24, top: 50),
                            child: Icon(
                              Icons.favorite,
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Wrap(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(InputScreen1());
                                },
                                child: Container(
                                  height: size.height * 0.06,
                                  margin: EdgeInsets.only(
                                    left: 24,
                                    right: 24,
                                    top: 24,
                                  ),
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  alignment: Alignment.center,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 0.3,
                                        color: Colors.grey,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Stack(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Step 1:",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            "Keterangan Tempat",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Spacer(),
                                          Icon(
                                            _isFilled1
                                                ? Icons.check_box_outlined
                                                : Icons.check_box_outline_blank,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InputScreen2(
                                        name: name,
                                        inisial: initial,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: size.height * 0.06,
                                  margin: EdgeInsets.only(
                                    left: 24,
                                    right: 24,
                                    top: 24,
                                  ),
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  alignment: Alignment.center,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 0.3,
                                        color: Colors.grey,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Stack(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Step 2:",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            "Keterangan Petugas",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Spacer(),
                                          Icon(
                                            _isFilled2
                                                ? Icons.check_box_outlined
                                                : Icons.check_box_outline_blank,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InputScreen3(
                                        name: name,
                                        inisial: initial,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: size.height * 0.06,
                                  margin: EdgeInsets.only(
                                    left: 24,
                                    right: 24,
                                    top: 24,
                                  ),
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  alignment: Alignment.center,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 0.3,
                                        color: Colors.grey,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Stack(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Step 3:",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            "Keterangan Responden",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Spacer(),
                                          Icon(
                                            _isFilled2
                                                ? Icons.check_box_outlined
                                                : Icons.check_box_outline_blank,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
