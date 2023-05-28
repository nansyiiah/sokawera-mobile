import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sokaweramobile/Pages/KejadianKelahiran/DetailKejadianKelahiran.dart';

class KejadianKelahiranController extends StatefulWidget {
  const KejadianKelahiranController({super.key});

  @override
  State<KejadianKelahiranController> createState() =>
      _KejadianKelahiranControllerState();
}

class _KejadianKelahiranControllerState
    extends State<KejadianKelahiranController> {
  var nomor_kk;
  List dataKelahiran = [];
  _loadDataKeluarga() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getInt('nomor_kk');
    if (user != null) {
      setState(() {
        nomor_kk = user;
      });
    }
  }

  _loadDataKelahiranFromLocal() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var data_kelahiran =
        localStorage.getStringList('detail_kejadian_kelahiran') ?? [];
    if (data_kelahiran != null) {
      for (var element in data_kelahiran) {
        var parsing = jsonDecode(element);
        dataKelahiran.add(parsing["nama_bayi"]);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadDataKeluarga();
    _loadDataKelahiranFromLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text("Kejadian Kelahiran"),
        backgroundColor: Color(0xFF68b7d8),
        actions: [
          InkWell(
            onTap: () {
              // showDeleteDialog(context);
              setState(() {
                dataKelahiran.add("Belum Diisi");
              });
            },
            child: Container(
              child: Icon(Icons.add),
              padding: EdgeInsets.only(right: 15),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white.withOpacity(0.93),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height * 0.75,
              child: ListView.builder(
                itemCount: dataKelahiran.length,
                itemBuilder: (context, index) {
                  var index_increment = index + 1;
                  return InkWell(
                    onTap: () {
                      Get.to(DetailKejadianKelahiran());
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
                                dataKelahiran[0][index] == null
                                    ? "Belum diisi"
                                    : dataKelahiran[index],
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.w400),
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
