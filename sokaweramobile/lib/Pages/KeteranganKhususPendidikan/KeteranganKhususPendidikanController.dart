import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sokaweramobile/Network/api.dart';
import 'package:sokaweramobile/Pages/KeteranganKhususPendidikan/DetailKeteranganPendidikan.dart';

class KeteranganKhususPendidikanController extends StatefulWidget {
  const KeteranganKhususPendidikanController({super.key});

  @override
  State<KeteranganKhususPendidikanController> createState() =>
      _KeteranganKhususPendidikanControllerState();
}

class _KeteranganKhususPendidikanControllerState
    extends State<KeteranganKhususPendidikanController> {
  var nomor_kk;
  List nama_sekolah = [];
  _loadDataKeluarga() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getInt('nomor_kk');
    if (user != null) {
      setState(() {
        nomor_kk = user;
      });
    }
  }

  _loadDataSekolahFromServer() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var keterangan_sosial = localStorage.getStringList('nama_anggota') ?? [];
    if (keterangan_sosial != null) {
      for (var element in keterangan_sosial) {
        var parsing = jsonDecode(element);
        if (parsing['partisipasi'] == 'Masih Sekolah') {
          nama_sekolah.add(parsing['nama']);
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadDataKeluarga();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _loadDataSekolahFromServer();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text("Keterangan Khusus Pendidikan"),
        backgroundColor: Color(0xFF68b7d8),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.75,
              child: nama_sekolah.isEmpty
                  ? Center(
                      child: Text("No Data"),
                    )
                  : ListView.builder(
                      itemCount: nama_sekolah.length,
                      itemBuilder: (context, index) {
                        var index_increment = index + 1;
                        return InkWell(
                          onTap: () {
                            Get.to(DetailKeteranganPendidikan(
                              nama: nama_sekolah[index],
                            ));
                            // Get.to(DetailInputscreen(item: index_increment));
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
                                      nama_sekolah.isEmpty
                                          ? "Belum diisi"
                                          : nama_sekolah[index],
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
