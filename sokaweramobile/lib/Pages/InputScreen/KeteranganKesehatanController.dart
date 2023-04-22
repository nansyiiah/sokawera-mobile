import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sokaweramobile/Pages/InputScreen/DetailKeteranganKesehatan.dart';
import 'package:sokaweramobile/Pages/components/BottomNavBar.dart';

class KeteranganKesehatanController extends StatefulWidget {
  const KeteranganKesehatanController({super.key});

  @override
  State<KeteranganKesehatanController> createState() =>
      _KeteranganKesehatanControllerState();
}

class _KeteranganKesehatanControllerState
    extends State<KeteranganKesehatanController> {
  var total_data;
  var list_nama = [];
  var list_nik = [];
  bool _isFilled = false;

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

  _loadListKeteranganSosial() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getStringList("nama_anggota") ?? [];
    if (user != null) {
      for (var element in user) {
        var parsing = jsonDecode(element);
        if (user.length <= total_data) {
          list_nama.add(parsing["nama"]);
          list_nik.add(parsing['nik']);
        }
      }
      var kekurangan = total_data - user.length;
      for (var i = 0; i < kekurangan; i++) {
        list_nama.add("Belum diisi");
      }
      if (user.length == total_data) {
        _isFilled = true;
      }
    }
  }

  _deleteLocalKeteranganKesehatanData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove("keterangan_khusus_kesehatan");
    localStorage.remove("detail_keterangan_khusus_kesehatan");
    Get.to(BottomNavBar());
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadKeteranganTotalData();
    _loadListKeteranganSosial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text("Keterangan Kesehatan"),
        backgroundColor: Color(0xFF68b7d8),
        actions: [
          InkWell(
            onTap: () {
              _deleteLocalKeteranganKesehatanData();
            },
            child: Container(
              child: Icon(Icons.delete),
              padding: EdgeInsets.only(right: 15),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.75,
              child: ListView.builder(
                itemCount: total_data,
                itemBuilder: (context, index) {
                  var index_increment = index + 1;
                  return InkWell(
                    onTap: () {
                      Get.to(
                        DetailKeteranganKesehatan(
                          nama: list_nama[index],
                          nik: list_nik[index],
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
                                    : list_nama[index],
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
