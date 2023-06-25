import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:sokaweramobile/Models/data_keterangan_tempat.dart';
import 'package:sokaweramobile/Models/data_keterangan_responden.dart';
import 'package:sokaweramobile/Pages/DetailPages/DetailScreen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  TextEditingController editingController = TextEditingController();
  @override
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
  var foundUser = [];
  var items = [];
  var warga_gaming = {};
  late Future myFuture;

  @override
  void initState() {
    // TODO: implement initState
    myFuture = getJsonRespondenData();
    foundUser = rtList;
    super.initState();
  }

  void filterSearchResults(String query) {
    // setState(() {
    //   items = rtList.where((item) => item.nama_kepala_keluarga).toList();
    // });
    List results = [];
    if (query.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = rtList;
    } else {
      results = rtList
          .where((user) => user["nama_kepala_keluarga"]
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      foundUser = results;
    });

    // print(rtList[0]["nama_kepala_keluarga"].contains(query));
  }

  getJsonRespondenData() async {
    var response = await http.get(
        Uri.parse("http://api.itsmegru.com/api/keterangan_responden"),
        headers: {
          "Accept": "application/json",
        });
    var jsonData = jsonDecode(response.body);
    List<KeteranganResponden> data = [];
    for (var u in jsonData["keterangan_responden"]) {
      warga_gaming = {
        "id": u["id"],
        "nama_kepala_keluarga": u["nama_kepala_keluarga"],
        "rt": u["rt"],
        "rw": u["rw"],
        "nik_kk": u["nik_kk"],
        "jumlah_anak": u["anak"].length,
      };
      rtList.add(warga_gaming);
    }
    return data;
  }

  // getJsonData() async {
  //   var keterangan_tempat = "keterangan_tempat";
  //   var response = await http
  //       .get(Uri.parse("http://api.itsmegru.com/api/keterangan_tempat"), headers: {
  //     "Accept": "application/json",
  //     // "Authorization": "Bearer $tokenLuar",
  //   });
  //   var jsonData = jsonDecode(response.body);
  //   List<KeteranganTempat> data = [];

  //   PetugasTempat data_petugas;
  //   List<Anak> data_anak = [];

  //   for (var u in jsonData["keterangan_tempat"]) {
  //     var rt = u["rt"];
  //     print("RT : $rt");
  //     // print(u["rt"]);
  //     print(u["data_warga"].length);

  //     for (var i in u["data_warga"]) {
  //       warga_gaming = {
  //         "id": i["id"],
  //         "nama": i["nama_kepala_keluarga"],
  //         "rt": i["rt"],
  //         "rw": i["rw"],
  //         "anak": i["anak"].length,
  //         "nik_kk": i["nik_kk"],
  //       };
  //       rtList.add(warga_gaming);
  //     }
  //   }

  //   return data;
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF68b7d8),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: myFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.only(top: size.height * 0.3),
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              var data = (snapshot.data as List<KeteranganResponden>).toList();
              return Column(
                children: [
                  Container(
                    height: size.height * 0.3,
                    width: size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/img/image-viewdata.png"),
                      ),
                      color: Color(0xFF68b7d8),
                    ),
                  ),
                  Container(
                    height: size.height * 5,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 24, top: 40),
                                      child: Container(
                                        child: Text(
                                          "List all data",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 24, bottom: 14),
                                      child: Container(
                                        child: Text(
                                          "Search your data",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.only(right: 24, top: 50),
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.pink,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 55,
                              width: size.width,
                              margin: EdgeInsets.symmetric(horizontal: 24),
                              child: TextField(
                                onChanged: (value) {
                                  filterSearchResults(value);
                                },
                                controller: editingController,
                                decoration: InputDecoration(
                                  labelText: "Search",
                                  hintText: "Search",
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.5,
                              width: size.width,
                              child: foundUser.isNotEmpty
                                  ? ListView.builder(
                                      padding: EdgeInsets.only(top: 10),
                                      shrinkWrap: true,
                                      itemCount: foundUser.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                  item: foundUser[index]["id"],
                                                  nik: foundUser[index]
                                                      ['nik_kk'],
                                                  // kk: rtList[index]['nik_kk'],
                                                ),
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
                                                    blurRadius: 3,
                                                    color: Colors.grey)
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 15),
                                                          child: Text(
                                                            foundUser[index][
                                                                    "nama_kepala_keluarga"]
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 10,
                                                                  top: 15),
                                                          child: Text(
                                                            "RT ${foundUser[index]["rt"].toString()} / RW ${foundUser[index]["rw"].toString()}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10, top: 5),
                                                      child: Text(
                                                        foundUser[index]
                                                                ["nik_kk"]
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
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
                                      child: const Text(
                                        'No results found',
                                        style: TextStyle(fontSize: 24),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ],
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
