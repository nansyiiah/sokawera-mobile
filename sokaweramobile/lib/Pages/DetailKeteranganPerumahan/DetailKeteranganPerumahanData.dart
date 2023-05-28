import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sokaweramobile/Network/api.dart';

class DetailKeteranganPerumahanData extends StatefulWidget {
  final String judul;
  final String keyy;
  const DetailKeteranganPerumahanData(
      {super.key, required this.judul, required this.keyy});

  @override
  State<DetailKeteranganPerumahanData> createState() =>
      _DetailKeteranganPerumahanDataState();
}

class _DetailKeteranganPerumahanDataState
    extends State<DetailKeteranganPerumahanData> {
  List datas = [];
  late Future myFuture;

  _loadKeteranganPerumahan() async {
    var res = await Network().getData('keterangan_perumahan/global');
    var jsonData = jsonDecode(res.body);
    datas.add(jsonData);
  }

  _loadAllData() async {
    await _loadKeteranganPerumahan();
    var data = [];
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    myFuture = _loadAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Warga ${widget.judul}",
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height,
                    width: size.width,
                    child: datas[0][widget.keyy].isNotEmpty
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  // Get.to(
                                  //   DetailUserUsahaData(
                                  //     keterangan: "Keterangan Usaha",
                                  //     jsonData: [dataUsaha[index]],
                                  //   ),
                                  // );
                                },
                                child: Container(
                                  height: size.height * 0.05,
                                  width: size.width,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                            "${datas[0][widget.keyy][index]["warga"]["nama_kepala_keluarga"]}"),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: datas[0][widget.keyy].length,
                          )
                        : Center(
                            child: Text("No data"),
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
