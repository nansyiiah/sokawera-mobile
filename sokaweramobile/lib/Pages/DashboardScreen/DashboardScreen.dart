import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sokaweramobile/Network/api.dart';
import 'package:sokaweramobile/Pages/LoginScreen.dart';
import 'package:sokaweramobile/Pages/components/BottomNavBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String name = "";
  var jml_laki;
  var jml_perempuan;
  var total_penduduk;
  var jml_warga_merantau;
  var jml_anak_sekolah;
  var jml_warga_hamil;
  List data_responden = [];
  var data_res_json = {};
  late List<Widget> _children;
  @override
  void initState() {
    if (!mounted) return;
    _loadUserData();
    if (!mounted) return;
    _getLogsData();
    if (!mounted) return;
    _getSummaryData();
    if (!mounted) return;
    _getAnakSekolahData();
    if (!mounted) return;
    _getWargaHamilData();
    super.initState();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('user');
    if (user != null) {
      setState(() {
        name = user;
      });
    } else {
      setState(() {
        name = "null";
      });
    }
  }

  _getLogsData() async {
    var res = await Network().getData('keterangan_responden');
    var jsonData = jsonDecode(res.body);
    for (var element in jsonData['keterangan_responden']) {
      setState(() {
        data_res_json = {
          'nama_kepala_keluarga': element['nama_kepala_keluarga'],
          'rt': element['rt'],
          'rw': element['rw'],
          'petugas': element['petugas']['name'],
        };
        data_responden.add(data_res_json);
        jml_warga_merantau =
            element['jumlah_anggota_keluarga_tidak_tinggal_dirumah'];
      });
    }
  }

  _getSummaryData() async {
    var res = await Network().getData('keterangan_sosial/gender');
    var jsonData = jsonDecode(res.body);
    setState(() {
      jml_laki = jsonData["jml_laki"];
      jml_perempuan = jsonData['jml_perempuan'];
      total_penduduk = jsonData['total_penduduk'];
    });
  }

  _getAnakSekolahData() async {
    var res = await Network().getData('keterangan_sosial/sekolah/count');
    var jsonData = jsonDecode(res.body);
    setState(() {
      jml_anak_sekolah = jsonData['jumlah_anak_sekolah'];
    });
  }

  _getWargaHamilData() async {
    var res = await Network().getData('keterangan_sosial/hamil/count');
    var jsonData = jsonDecode(res.body);
    setState(() {
      jml_warga_hamil = jsonData['jumlah_warga_hamil'];
    });
  }

  showAlertDialog(BuildContext context) {
    _logout() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.clear();
      Get.to(LoginScreen());
    }

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Logout"),
      onPressed: () {
        _logout();
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text(
        "Are you sure want to log out ?",
        style: GoogleFonts.poppins(),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: size.height * 0.17,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 60),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width * 0.8,
                          child: RichText(
                            overflow: TextOverflow.visible,
                            text: TextSpan(
                              text: "Hello,\n",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              children: [
                                TextSpan(
                                  text: name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            showAlertDialog(context);
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Color(0xFF68b7d8),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.logout_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.16,
                    width: size.width * 0.25,
                    decoration: BoxDecoration(
                      color: Color(0xFF2ecc71).withOpacity(0.27),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: total_penduduk == null
                              ? CircularProgressIndicator()
                              : Text(
                                  "${total_penduduk}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Jumlah Penduduk",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.green,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: size.height * 0.16,
                    width: size.width * 0.23,
                    decoration: BoxDecoration(
                      color: Color(0xFFff9ff3).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: jml_perempuan == null
                              ? CircularProgressIndicator()
                              : Text(
                                  "${jml_perempuan}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                  ),
                                ),
                        ),
                        Container(
                          child: Text(
                            "Penduduk Perempuan",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.pink,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: size.height * 0.16,
                    width: size.width * 0.23,
                    decoration: BoxDecoration(
                      color: Color(0xFF48dbfb).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: jml_laki == null
                              ? CircularProgressIndicator()
                              : Text(
                                  "${jml_laki}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                        ),
                        Container(
                          child: Text(
                            "Penduduk Laki Laki",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueAccent,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      "Rincian Data",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.15,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                      color: Color(0xFF867070),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 3),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: jml_anak_sekolah == null
                              ? Text(
                                  "0",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                )
                              : Text(
                                  "${jml_anak_sekolah}",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                        ),
                        Container(
                          // padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Warga sedang sekolah",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.75),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: size.height * 0.15,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                      color: Color(0xFF8F43EE),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: jml_warga_merantau == null
                              ? Text(
                                  "0",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                )
                              : Text(
                                  "${jml_warga_merantau}",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Warga sedang merantau",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.75),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: size.height * 0.15,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                      color: Color(0xFF002B5B),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: jml_warga_hamil == null
                              ? Text(
                                  "0",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                )
                              : Text(
                                  "${jml_warga_hamil}",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                        ),
                        Container(
                          // padding: EdgeInsets.only(left: 5),
                          alignment: Alignment.center,
                          child: Text(
                            "Warga sedang hamil",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.75),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      "Recently Input",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.53,
              width: size.width,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                shrinkWrap: true,
                itemCount: data_responden.length,
                itemBuilder: (context, index) {
                  var nama = data_responden[index]['nama_kepala_keluarga'];
                  var rt = data_responden[index]['rt'];
                  var rw = data_responden[index]['rw'];
                  var petugas = data_responden[index]['petugas'];
                  return Container(
                    height: size.height * 0.1,
                    width: size.width,
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 1),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: size.height * 0.15,
                              width: size.width * 0.13,
                              margin: EdgeInsets.only(
                                left: 20,
                                top: 15,
                                bottom: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.person,
                                size: 36,
                                color: Color(0xFF68b7d8),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 15, left: 15),
                                  child: Container(
                                    width: size.width * 0.4,
                                    child: Text(
                                      'RT ${rt} / RW ${rw}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 5),
                                  child: Container(
                                    width: size.width * 0.4,
                                    child: Text(
                                      "${nama}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
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
