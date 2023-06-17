import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sokaweramobile/Network/api.dart';
import 'package:sokaweramobile/Pages/KejadianKelahiran/EditKejadianKelahiran.dart';
import 'package:sokaweramobile/Pages/KejadianKematian/EditKejadianKematian.dart';

class DetailKejadianKematianData extends StatefulWidget {
  final String judul;
  final String keyy;
  const DetailKejadianKematianData(
      {super.key, required this.judul, required this.keyy});

  @override
  State<DetailKejadianKematianData> createState() =>
      _DetailKejadianKematianDataState();
}

class _DetailKejadianKematianDataState
    extends State<DetailKejadianKematianData> {
  List datas = [];
  late Future myFuture;

  _loadKeteranganKhususPendidikan() async {
    var res = await Network().getData('kejadian_kematian');
    var jsonData = jsonDecode(res.body);
    datas.add(jsonData);
  }

  _loadAllData() async {
    await _loadKeteranganKhususPendidikan();
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
            fontSize: 20,
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
                                  Get.to(EditKejadianKematian(
                                      data: [datas[0]["kematian"][index]]));
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
                                            "${datas[0][widget.keyy][index]["nama"]}"),
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
