import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sokaweramobile/Network/api.dart';

class DetailKeteranganSosialData extends StatefulWidget {
  final String judul;
  final String keyy;
  const DetailKeteranganSosialData(
      {super.key, required this.judul, required this.keyy});

  @override
  State<DetailKeteranganSosialData> createState() =>
      _DetailKeteranganSosialDataState();
}

class _DetailKeteranganSosialDataState
    extends State<DetailKeteranganSosialData> {
  List datas = [];
  late Future myFuture;

  _loadKeteranganSosial() async {
    var res = await Network().getData('keterangan_sosial/global');
    var jsonData = jsonDecode(res.body);
    datas.add(jsonData);
  }

  _loadAllData() async {
    await _loadKeteranganSosial();
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
                    child: ListView.builder(
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
                              crossAxisAlignment: CrossAxisAlignment.center,
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
