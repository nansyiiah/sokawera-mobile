import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sokaweramobile/Pages/KeteranganTernak/DetailHewanTernak.dart';

class PenguasaanHewanTernakController extends StatefulWidget {
  const PenguasaanHewanTernakController({super.key});

  @override
  State<PenguasaanHewanTernakController> createState() =>
      _PenguasaanHewanTernakControllerState();
}

class _PenguasaanHewanTernakControllerState
    extends State<PenguasaanHewanTernakController> {
  List nama_hewan = ["Sapi", "Kerbau", "Kambing atau Domba"];
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text("Penguasaan Hewan Ternak"),
        backgroundColor: Color(0xFF68b7d8),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.75,
              child: nama_hewan.isEmpty
                  ? Center(
                      child: Text("No Data"),
                    )
                  : ListView.builder(
                      itemCount: nama_hewan.length,
                      itemBuilder: (context, index) {
                        var index_increment = index + 1;
                        return InkWell(
                          onTap: () {
                            Get.to(DetailHewanTernak(nama: nama_hewan[index]));
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
                                      nama_hewan.isEmpty
                                          ? "Belum diisi"
                                          : nama_hewan[index],
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
