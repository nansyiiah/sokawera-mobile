import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sokaweramobile/Pages/KeteranganUsaha/DetailKeteranganUsaha.dart';

class KeteranganUsahaController extends StatefulWidget {
  const KeteranganUsahaController({super.key});

  @override
  State<KeteranganUsahaController> createState() =>
      _KeteranganUsahaControllerState();
}

class _KeteranganUsahaControllerState extends State<KeteranganUsahaController> {
  var total_data;
  List list_nama = [];
  _loadKeteranganTotalData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getInt('total_keluarga_full');
    if (user != null) {
      setState(() {
        total_data = user;
      });
    } else {
      return null;
    }
  }

  _loadAllDatafromLocal() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getStringList("nama_anggota");
    if (user != null) {
      for (var element in user) {
        var parsing = jsonDecode(element);
        if (parsing["usaha"] == "Ya") {
          var data = {
            'nama': parsing['nama'],
            'nik': parsing['nik'],
            'nomor_kk': parsing['nik_kk']
          };
          list_nama.add(data);
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadKeteranganTotalData();
    _loadAllDatafromLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text("Keterangan Khusus Usaha"),
        backgroundColor: Color(0xFF68b7d8),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.75,
              child: list_nama.isEmpty
                  ? Center(
                      child: Text("No Data"),
                    )
                  : ListView.builder(
                      itemCount: list_nama.length,
                      itemBuilder: (context, index) {
                        var index_increment = index + 1;
                        return InkWell(
                          onTap: () {
                            Get.to(
                              DetailKeteranganUsaha(
                                nama: list_nama[index]['nama'],
                                nik: list_nama[index]['nik'],
                                nomor_kk: list_nama[index]['nomor_kk'],
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
                                      list_nama.isEmpty
                                          ? "Belum diisi"
                                          : list_nama[index]['nama'],
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
