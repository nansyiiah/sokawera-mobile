import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sokaweramobile/Pages/InputScreen1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  bool _isFilled = false;
  void initState() {
    _getKeteranganTempatFromLocal();
    super.initState();
  }

  _getKeteranganTempatFromLocal() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var data = localStorage.getString('keterangan_tempat');
    if (data != null) {
      _isFilled = true;
      return data;
    } else {
      return null;
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
              height: size.height * 0.7,
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
                      SizedBox(
                        height: size.height * 0.55,
                        width: size.width,
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 24),
                          shrinkWrap: true,
                          itemCount: ketList.length,
                          itemBuilder: (context, index) {
                            int index_increment = index + 1;
                            return InkWell(
                              onTap: () {
                                switch (index_increment) {
                                  case 1:
                                    Get.to(InputScreen1());
                                    break;
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 24, right: 24, bottom: 24),
                                height: size.height * 0.055,
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(blurRadius: 3, color: Colors.grey)
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Text(
                                            'Step $index_increment: ',
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          margin: EdgeInsets.only(right: 20),
                                          alignment: Alignment.center,
                                          child: Text(
                                            ketList[index],
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(
                                            right: 10,
                                          ),
                                          child: Icon(
                                              Icons.check_box_outline_blank),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
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
