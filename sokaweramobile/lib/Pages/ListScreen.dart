import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:sokaweramobile/Network/data_keterangan_tempat.dart';
import 'package:sokaweramobile/Network/data_keterangan_responden.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  String tokenLuar = "";
  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        tokenLuar = token;
      });
    } else {
      setState(() {
        tokenLuar = "null";
      });
    }
  }

  final String url = "http://10.0.2.2:8000/api/";
  List data_nama_kk = [];
  List<DataWarga> data_warga = [];
  var element = {};
  var newList = [];
  List rtList = [];
  var warga_gaming = {};

  getJsonRespondenData() async {
    var response = await http.get(
        Uri.parse("http://10.0.2.2:8000/api/keterangan_responden"),
        headers: {
          "Accept": "application/json",
        });
    var jsonData = jsonDecode(response.body);
    List<KeteranganResponden> data = [];
    for (var u in jsonData["keterangan_responden"]) {
      print(u["petugas"]);
    }
    return data;
  }

  getJsonData() async {
    var keterangan_tempat = "keterangan_tempat";
    var response = await http
        .get(Uri.parse("http://10.0.2.2:8000/api/keterangan_tempat"), headers: {
      "Accept": "application/json",
      // "Authorization": "Bearer $tokenLuar",
    });
    // var jsonData = jsonDecode(response.body);
    var jsonData = jsonDecode(response.body);
    // print(jsonData);
    // List<DataKeteranganTempat> data = [];
    List<KeteranganTempat> data = [];

    PetugasTempat data_petugas;
    List<Anak> data_anak = [];

    for (var u in jsonData["keterangan_tempat"]) {
      var rt = u["rt"];
      print("RT : $rt");
      // print(u["rt"]);
      print(u["data_warga"].length);

      for (var i in u["data_warga"]) {
        warga_gaming = {
          "id": i["id"],
          "nama": i["nama_kepala_keluarga"],
          "rt": i["rt"],
          "rw": i["rw"],
          "anak": i["anak"].length,
          "nik_kk": i["nik_kk"],
        };
        rtList.add(warga_gaming);
      }
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getJsonData(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var data = (snapshot.data as List<KeteranganTempat>).toList();
              return Column(
                children: [
                  Container(
                    height: size.height * 0.3,
                    child: Stack(
                      children: [
                        Container(
                          height: size.height * 0.27 - 25,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Color(0xFF68b7d8),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                // margin: EdgeInsets.symmetric(horizontal: 50),
                                // width: size.width / 2,
                                child: Image.asset(
                                    "assets/img/image-viewdata.png"),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            width: size.width,
                            height: size.height * 0.065,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Search",
                                      suffixIcon: Icon(Icons.search),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.65,
                    width: size.width,
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 5),
                      shrinkWrap: true,
                      itemCount: rtList.length,
                      itemBuilder: (context, index) {
                        var nama = rtList[index]["nama"];
                        var rt = rtList[index]["rt"];
                        var nik = rtList[index]["nik_kk"];
                        var rw = rtList[index]["rw"];
                        print(rtList[index]);
                        return InkWell(
                          onTap: () {
                            print("awikwok => $index");
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
                                BoxShadow(blurRadius: 3, color: Colors.grey)
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 10, top: 15),
                                          child: Text(
                                            nama,
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
                                            "RT $rt / RW $rw",
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
                                      padding:
                                          EdgeInsets.only(left: 10, top: 5),
                                      child: Text(
                                        nik,
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
