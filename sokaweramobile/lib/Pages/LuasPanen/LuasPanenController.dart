import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sokaweramobile/Pages/LuasPanen/DetailLuasPanenController.dart';

class LuasPanenController extends StatefulWidget {
  const LuasPanenController({super.key});

  @override
  State<LuasPanenController> createState() => _LuasPanenControllerState();
}

class _LuasPanenControllerState extends State<LuasPanenController> {
  List list_kategori = [
    "Padi",
    "Jagung",
    "Kedelai",
    "Kacang Tanah",
    "Ketela Pohon"
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text("Luas Panen"),
        backgroundColor: Color(0xFF68b7d8),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.75,
              child: list_kategori.isEmpty
                  ? Center(
                      child: Text("No Data"),
                    )
                  : ListView.builder(
                      itemCount: list_kategori.length,
                      itemBuilder: (context, index) {
                        var index_increment = index + 1;
                        return InkWell(
                          onTap: () {
                            Get.to(
                              DetailLuasPanenController(
                                jenis_lahan: list_kategori[index],
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
                                    Container(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        "${index_increment}.",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      list_kategori[index],
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.arrow_right),
                                    )
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
      ),
    );
  }
}
