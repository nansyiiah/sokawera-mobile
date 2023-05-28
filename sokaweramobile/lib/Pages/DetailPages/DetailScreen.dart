import 'dart:async';
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
import 'package:sokaweramobile/Pages/DetailPages/DetailAllData.dart';
import 'package:sokaweramobile/Pages/DetailPages/DetailKeteranganHubungan.dart';
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
  late Future myFuture;
  var anak = {};
  var id;
  var nama = "";
  var nik_kk = "";
  var nama_laki = [];
  var nama_perempuan = [];
  var jsonKetSosial = [];
  var jsonPendidikan = [];
  var dusun, no_urut_rumah, rt, rw, nama_jalan;

  _deleteData(nik) async {
    var response = await Network().deleteDataNik(nik);
    var jsonData = jsonDecode(response.body);
    if (jsonData['code'] == 200) {
      Get.to(BottomNavBar());
    } else {
      showAlertDialog(context);
    }
  }

  _fetchData(id) async {
    var response = await http.get(
        Uri.parse("http://api.itsmegru.com/api/keterangan_responden/${id}"),
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
          u['jenis_kelamin'] == 'Laki-Laki' ||
          u['jenis_kelamin'] == 'Laki-laki') {
        nama_laki.add(u['nama']);
      }
      if (u['jenis_kelamin'] == 'Perempuan' ||
          u['jenis_kelamin'] == 'perempuan') {
        nama_perempuan.add(u['nama']);
      }

      data.add(anak);
    }
    // _loadData(widget.item);
    _loadData(widget.nik);
    return data;
  }

  void initState() {
// TODO: implement initState

    _loadKeteranganSosial(widget.nik);
    _loadKeteranganKhususPendidikan(widget.nik);
    myFuture = _fetchData(widget.item);
    super.initState();
  }

  _loadData(nik_kk) async {
    var res = await Network().getData('keterangan_tempat/nik/${nik_kk}');
    var jsonData = jsonDecode(res.body);
    // print(jsonData[0]);

    setState(() {
      nama_jalan = jsonData["keterangan_tempat"][0]["nama_jalan"];
      rt = jsonData["keterangan_tempat"][0]["rt"];
      rw = jsonData["keterangan_tempat"][0]["rw"];
      dusun = jsonData["keterangan_tempat"][0]["dusun"];
      no_urut_rumah = jsonData["keterangan_tempat"][0]['nomor_urut_rumah'];
    });
  }

  _loadKeteranganSosial(nik_kk) async {
    var res = await Network().getData('keterangan_sosial/nik_kk/${nik_kk}');
    var jsonData = jsonDecode(res.body);
    for (var element in jsonData['data']) {
      var warga = {
        "nik_kk": element["nik_kk"],
        "rt": element["rt"],
        "rw": element["rw"],
        "nama": element["nama"],
        "nik": element["nik"],
        "hubungan": element["hubungan"],
        "tinggal": element["tinggal"],
        "jenis_kelamin": element["jenis_kelamin"],
        "umur": element["umur"],
        "status": element["status"],
        "status_kehamilan": element["status_kehamilan"],
        "partisipasi": element["partisipasi"],
        "ijazah_tertinggi": element["ijazah_tertinggi"],
        "bekerja": element["bekerja"],
        "lapangan_kerja": element["lapangan_kerja"],
        "status_kerja": element["status_kerja"],
      };
      jsonKetSosial.add(warga);
    }
  }

  _loadKeteranganKhususPendidikan(nik) async {
    var res =
        await Network().getData('keterangan_khusus_pendidikan/nik/${nik}');
    var jsonData = jsonDecode(res.body);
    var data = [];
    for (var element in jsonData['data']) {
      var warga = {
        "id": element["id"],
        "nama": element["nama"],
        "jenjang_pendidikan_ditempuh": element["jenjang_pendidikan_ditempuh"],
        "nama_sekolah": element["nama_sekolah"],
        "kelas": element["kelas"],
        "kost_tidak": element["kost_tidak"],
        "beasiswa_tidak": element["beasiswa_tidak"],
        "melanjutkan_sekolah_tidak": element["melanjutkan_sekolah_tidak"],
        "nama_sekolah_tujuan": element["nama_sekolah_tujuan"],
        "jumlah_biaya_sekolah": element["jumlah_biaya_sekolah"],
        "nik_kk": element["nik_kk"],
      };
      jsonPendidikan.add(warga);
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // _loadData(widget.item);
    // print(widget.item);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.93),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: myFuture,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                  Container(
                    height: size.height * 0.15,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Center(
                          child: Container(
                            alignment: Alignment.center,
                            height: size.height * 0.1,
                            width: size.width * 0.2,
                            margin: EdgeInsets.only(
                                left: 24, right: 20, top: 30, bottom: 20),
                            decoration: BoxDecoration(
                              color: Color(0xFF68b7d8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 25),
                                  child: Text(
                                    "${nama}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  // margin: EdgeInsets.only(right: 20),
                                  child: Text(
                                    "${nama_jalan}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    "${nik_kk}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 23,
                                      width: 70,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: Text(
                                          "RT: ${rt}",
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(50.0),
                                          ),
                                          backgroundColor: Color(0xFF68b7d8),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      height: 23,
                                      width: 85,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: Text(
                                          "RW: ${rw}",
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(50.0),
                                          ),
                                          backgroundColor: Color(0xFF68b7d8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
                            color: Color(0xFF68b7d8),
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
                  InkWell(
                    onTap: () {
                      Get.to(DetailAllData(
                        name: nama,
                        nik: nik_kk,
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      height: size.height * 0.055,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: 1),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 25),
                            child: Text(
                              "Detail semua data",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.keyboard_arrow_right_sharp,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
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
                    child: jsonKetSosial.isNotEmpty
                        ? ListView.builder(
                            padding: EdgeInsets.only(top: 10),
                            shrinkWrap: true,
                            itemCount: jsonKetSosial.length,
                            itemBuilder: (context, index) {
                              var nama = data[index]['nama'];
                              var nik = data[index]['nik'];
                              var hubungan = data[index]['hubungan'];
                              return InkWell(
                                onTap: () {
                                  Get.to(
                                    DetailKeteranganHubungan(
                                      jsonData: [jsonKetSosial[index]],
                                      jsonPendidikan: jsonPendidikan,
                                    ),
                                  );
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
                                    borderRadius: BorderRadius.circular(10),
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
