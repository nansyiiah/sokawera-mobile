import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sokaweramobile/Models/data_keterangan_responden_id.dart';
import 'package:http/http.dart' as http;
import 'package:sokaweramobile/Network/api.dart';
import 'package:sokaweramobile/Pages/DashboardScreen/DashboardScreen.dart';
import 'package:sokaweramobile/Pages/components/BottomNavBar.dart';

class DetailScreen extends StatefulWidget {
  final int item;
  final String nik;
  const DetailScreen({super.key, required this.item, required this.nik});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List data = [];
  var anak = {};
  var nama = "";
  var nik_kk = "";
  var nama_laki = [];
  var nama_perempuan = [];

  _deleteData(nik) async {
    var response = await Network().deleteDataNik(nik);
    var jsonData = jsonDecode(response.body);
    if (jsonData['code'] == 200) {
      Get.to(BottomNavBar());
    } else {
      showAlertDialog(context);
    }
  }

  Future _fetchData(id) async {
    var response = await http.get(
        Uri.parse("http://babygru.tech/api/keterangan_responden/${id}"),
        headers: {
          "Accept": "application/json",
        });
    var jsonData = jsonDecode(response.body);
    nama = jsonData['data']['nama_kepala_keluarga'];
    nik_kk = jsonData['data']['nik_kk'];
    for (var u in jsonData["data"]["anak"]) {
      anak = {
        'nama': u['nama'],
        'gender': u['jenis_kelamin'],
        'nik': u['nik'],
        'hubungan': u['hubungan'],
      };
      if (u['jenis_kelamin'] == 'Laki Laki' ||
          u['jenis_kelamin'] == 'Laki-Laki') {
        nama_laki.add(u['nama']);
      }
      if (u['jenis_kelamin'] == 'Perempuan') {
        nama_perempuan.add(u['nama']);
      }

      data.add(anak);
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.93),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _fetchData(widget.item),
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var data = (snapshot.data as List).toList();
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 15, top: size.height * 0.05),
                          child: Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding:
                            EdgeInsets.only(right: 15, top: size.height * 0.05),
                        child: PopupMenuButton<MenuItem>(
                          onSelected: (value) {
                            if (value == MenuItem.item1) {
                              _deleteData(widget.nik);
                            }
                          },
                          icon: Icon(Icons.more_horiz),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: MenuItem.item1,
                              child: Text("Delete"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: size.height * 0.15,
                      width: size.width * 0.3,
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 30, bottom: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFF68b7d8),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(blurRadius: 3, color: Colors.grey)
                        ],
                      ),
                      child: Icon(
                        Icons.person,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        "${nama}",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        "${nik_kk}",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          height: 80,
                          width: size.width * 0.35,
                          margin: EdgeInsets.only(left: 45),
                          decoration: BoxDecoration(
                            color: Color(0xFF68b7d8).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 15),
                                child: Text(
                                  "Laki Laki",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "${nama_laki.length}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 80,
                        width: size.width * 0.35,
                        margin: EdgeInsets.only(right: 45),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 15),
                              child: Text(
                                "Perempuan",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF68b7d8),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "${nama_perempuan.length}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF68b7d8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 25),
                    child: Text(
                      "Keterangan Hubungan",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: size.height * 0.5,
                    width: size.width,
                    child: data.isNotEmpty
                        ? ListView.builder(
                            padding: EdgeInsets.only(top: 10),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              // var nama = rtList[index]["nama_kepala_keluarga"];
                              // var rt = rtList[index]["rt"];
                              // var nik = rtList[index]["nik_kk"];
                              // var rw = rtList[index]["rw"];
                              var nama = data[index]['nama'];
                              var nik = data[index]['nik'];
                              var hubungan = data[index]['hubungan'];
                              return InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         DetailScreen(item: rtList[index]["id"]),
                                  //   ),
                                  // );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: 24,
                                    right: 24,
                                    bottom: 24,
                                  ),
                                  height: size.height * 0.1,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 3, color: Colors.grey)
                                    ],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 10, top: 15),
                                                child: Text(
                                                  "${nama}",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    right: 10, top: 15),
                                                child: Text(
                                                  "${hubungan}",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 10, top: 5),
                                            child: Text(
                                              "${nik}",
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text("No Data"),
                          ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

enum MenuItem {
  item1,
  item2,
  item3,
  item4,
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
      Get.to(BottomNavBar());
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text(
      "Error saat menghapus data !",
      style: GoogleFonts.poppins(),
    ),
    actions: [
      cancelButton,
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
