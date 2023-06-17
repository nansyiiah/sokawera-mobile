import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sokaweramobile/Network/api.dart';
import 'package:sokaweramobile/Pages/DetailKeteranganPerumahan/DetailKeteranganPerumahanData.dart';
import 'package:sokaweramobile/Pages/DetailPages/DetailUserUsahaData.dart';
import 'package:sokaweramobile/Pages/KejadianKelahiran/DetailKejadianKelahiranData.dart';
import 'package:sokaweramobile/Pages/KejadianKematian/DetailKejadianKematianData.dart';
import 'package:sokaweramobile/Pages/KeteranganKhususKesehatan/DetailKeteranganKhususKesehatanData.dart';
import 'package:sokaweramobile/Pages/KeteranganKhususPendidikan/DetailKeteranganKhususPendidikanData.dart';
import 'package:sokaweramobile/Pages/KeteranganSosial/DetailKeteranganSosialData.dart';

class DetailAllPageDashboard extends StatefulWidget {
  const DetailAllPageDashboard({super.key});

  @override
  State<DetailAllPageDashboard> createState() => _DetailAllPageDashboardState();
}

class _DetailAllPageDashboardState extends State<DetailAllPageDashboard> {
  late Future myFuture;
  List data_responden = [];
  List data_sosial = [];
  List data_pendidikan = [];
  List data_kesehatan = [];
  List data_kelahiran = [];
  List data_kematian = [];
  List data_usaha = [];
  List data_perumahan = [];
  _loadKeteranganResponden() async {
    var res = await Network().getData('keterangan_responden/global');
    var jsonData = jsonDecode(res.body);
    data_responden.add(jsonData);
  }

  _loadKeteranganSosial() async {
    var res = await Network().getData('keterangan_sosial/global');
    var jsonData = jsonDecode(res.body);
    data_sosial.add(jsonData);
  }

  _loadKeteranganPendidikan() async {
    var res = await Network().getData('keterangan_khusus_pendidikan/global');
    var jsonData = jsonDecode(res.body);
    data_pendidikan.add(jsonData);
  }

  _loadKeteranganKesehatan() async {
    var res = await Network().getData('keterangan_kesehatan/global');
    var jsonData = jsonDecode(res.body);
    data_kesehatan.add(jsonData);
  }

  _loadKejadianKelahiran() async {
    var res = await Network().getData('kejadian_kelahiran');
    var jsonData = jsonDecode(res.body);
    data_kelahiran.add(jsonData["kelahiran"]);
  }

  _loadKejadianKematian() async {
    var res = await Network().getData('kejadian_kematian');
    var jsonData = jsonDecode(res.body);
    data_kematian.add(jsonData["kematian"]);
  }

  _loadKeteranganUsaha() async {
    var res = await Network().getData('keterangan_usaha');
    var jsonData = jsonDecode(res.body);
    data_usaha.add(jsonData["usaha"]);
  }

  _loadKeteranganPerumahan() async {
    var res = await Network().getData('keterangan_perumahan/global');
    var jsonData = jsonDecode(res.body);
    data_perumahan.add(jsonData);
  }

  _loadAllData() async {
    await _loadKeteranganResponden();
    await _loadKeteranganSosial();
    await _loadKeteranganPendidikan();
    await _loadKeteranganKesehatan();
    await _loadKeteranganUsaha();
    await _loadKeteranganPerumahan();
    await _loadKejadianKelahiran();
    await _loadKejadianKematian();
    var data = [];
    return data;
  }

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
          "Detail",
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
                child: Padding(
                  padding: EdgeInsets.only(top: size.height * 0.3),
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              var data = (snapshot.data as List).toList();
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 24, top: 24, bottom: 24),
                    child: Text(
                      "Keterangan Responden",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.05,
                    width: size.width,
                    margin: EdgeInsets.symmetric(horizontal: 24),
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
                          child: Text("Jumlah kepala keluarga"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                              "${data_responden[0]['jumlah_kepala_keluarga']}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: size.height * 0.05,
                    width: size.width,
                    margin: EdgeInsets.symmetric(horizontal: 24),
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
                          child: Text("Jumlah Warga sedang menjadi TKI"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child:
                              Text("${data_responden[0]['jumlah_warga_tki']}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: size.height * 0.05,
                    width: size.width,
                    margin: EdgeInsets.symmetric(horizontal: 24),
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
                          child: Text("Jumlah Warga memiliki usaha"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                              "${data_responden[0]['jumlah_warga_usaha']}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: size.height * 0.05,
                    width: size.width,
                    margin: EdgeInsets.symmetric(horizontal: 24),
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
                          child: Text("Jumlah Warga punya jaminan kesehatan"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                              "${data_responden[0]['jumlah_warga_memiliki_bpjs']}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: size.height * 0.05,
                    width: size.width,
                    margin: EdgeInsets.symmetric(horizontal: 24),
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
                          child: Text("Jumlah Warga menjadi abdi negara"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                              "${data_responden[0]['jumlah_warga_menjadi_pns']}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: size.height * 0.05,
                    width: size.width,
                    margin: EdgeInsets.symmetric(horizontal: 24),
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
                          child: Text("Jumlah Warga sedang menyusui"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                              "${data_responden[0]['jumlah_warga_sedang_menyusui']}"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24, top: 24, bottom: 24),
                    child: Text(
                      "Keterangan Sosial",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        DetailKeteranganSosialData(
                          judul: "Janda Atau Duda",
                          keyy: "data_janda_duda",
                        ),
                      );
                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
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
                            child: Text("Jumlah Warga Janda atau Duda"),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Text(
                                "${data_sosial[0]['jumlah_warga_janda_atau_duda']}"),
                          ),
                          Icon(Icons.arrow_right_rounded),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        DetailKeteranganSosialData(
                          judul: "Tidak Bekerja",
                          keyy: "data_tidak_bekerja",
                        ),
                      );
                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
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
                            child: Text("Jumlah Warga Tidak Bekerja"),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Text(
                                "${data_sosial[0]['jumlah_warga_tidak_bekerja']}"),
                          ),
                          Icon(Icons.arrow_right_rounded),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        DetailKeteranganSosialData(
                          judul: "yang bekerja",
                          keyy: "data_bekerja",
                        ),
                      );
                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
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
                            child: Text("Jumlah Warga yang Bekerja"),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Text(
                                "${data_sosial[0]['jumlah_warga_yang_bekerja']}"),
                          ),
                          Icon(Icons.arrow_right_rounded),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        DetailKeteranganSosialData(
                          judul: "lansia",
                          keyy: "data_lansia",
                        ),
                      );
                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
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
                            child: Text("Jumlah Warga lansia ≥60 tahun"),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Text(
                                "${data_sosial[0]['jumlah_warga_lansia']}"),
                          ),
                          Icon(Icons.arrow_right_rounded),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24, top: 24, bottom: 24),
                    child: Text(
                      "Keterangan Khusus Pendidikan",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        DetailKeteranganKhususPendidikanData(
                          judul: "sedang ngekos",
                          keyy: "data_warga_kost",
                        ),
                      );
                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
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
                            child: Text("Jumlah Warga sedang ngekos"),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Text("${data_pendidikan[0]['jml_kost']}"),
                          ),
                          Icon(Icons.arrow_right_rounded),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        DetailKeteranganKhususPendidikanData(
                          judul: "mendapat beasiswa",
                          keyy: "data_warga_beasiswa",
                        ),
                      );
                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
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
                            child: Text("Jumlah Warga mendapat beasiswa"),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child:
                                Text("${data_pendidikan[0]['jml_beasiswa']}"),
                          ),
                          Icon(Icons.arrow_right_rounded),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24, top: 24, bottom: 24),
                    child: Text(
                      "Keterangan Khusus Kesehatan",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        DetailKeteranganKhususKesehatanData(
                          judul: "memiliki penyakit menahun",
                          keyy: "data_warga_penyakit",
                        ),
                      );
                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
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
                            child: Text("Jml Warga memiliki penyakit menahun"),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Text(
                                "${data_kesehatan[0]['jml_warga_penyakit']}"),
                          ),
                          Icon(Icons.arrow_right_rounded),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        DetailKeteranganKhususKesehatanData(
                          judul: "pernah covid",
                          keyy: "data_warga_covid",
                        ),
                      );
                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
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
                            child: Text("Jml Warga pernah terpapar covid"),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child:
                                Text("${data_kesehatan[0]['jml_warga_covid']}"),
                          ),
                          Icon(Icons.arrow_right_rounded),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        DetailKeteranganKhususKesehatanData(
                          judul: "sudah vaksin",
                          keyy: "data_warga_vaksin",
                        ),
                      );
                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
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
                            child: Text("Jml Warga sudah vaksin"),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Text(
                                "${data_kesehatan[0]['jml_warga_vaksin']}"),
                          ),
                          Icon(Icons.arrow_right_rounded),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        DetailKeteranganKhususKesehatanData(
                          judul: "punya cacat",
                          keyy: "data_warga_cacat",
                        ),
                      );
                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
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
                            child: Text("Jml Warga mempunyai cacat"),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child:
                                Text("${data_kesehatan[0]['jml_warga_cacat']}"),
                          ),
                          Icon(Icons.arrow_right_rounded),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        DetailKeteranganKhususKesehatanData(
                          judul: "pernah opname",
                          keyy: "data_warga_opname",
                        ),
                      );
                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
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
                            child: Text("Jml Warga pernah diopname"),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Text(
                                "${data_kesehatan[0]['jml_warga_opname']}"),
                          ),
                          Icon(Icons.arrow_right_rounded),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24, top: 24, bottom: 24),
                    child: Text(
                      "Kejadian Kelahiran dan Kematian",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        DetailKejadianKelahiranData(
                            judul: "kelahiran", keyy: "kelahiran"),
                      );
                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
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
                            child: Text("Jml Warga kelahiran sejak 2020"),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Text("${data_kelahiran[0].length}"),
                          ),
                          Icon(Icons.arrow_right_rounded),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        DetailKejadianKematianData(
                            judul: "kematian", keyy: "kematian"),
                      );
                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
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
                            child: Text("Jml Warga kematian sejak 2020"),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Text("${data_kematian[0].length}"),
                          ),
                          Icon(Icons.arrow_right_rounded),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24, top: 24, bottom: 24),
                    child: Text(
                      "Keterangan Usaha",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.2,
                    width: size.width,
                    child: data_usaha[0].isNotEmpty
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(
                                    DetailUserUsahaData(
                                      keterangan: "Keterangan Usaha",
                                      jsonData: [data_usaha[0][index]],
                                    ),
                                  );
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
                                            "${data_usaha[0][index]["nama"]}"),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(
                                            Icons.keyboard_arrow_right_sharp),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: data_usaha[0].length,
                          )
                        : Center(
                            child: Text("No Data"),
                          ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24, top: 24, bottom: 24),
                    child: Text(
                      "Keterangan Perumahan",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        DetailKeteranganPerumahanData(
                            judul: "tidak punya fasilitas BAB",
                            keyy: 'data_warga_tidak_punya_fasilitas_bab'),
                      );
                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 20),
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
                            child: Text("Jml Warga tidak punya fasilitas BAB"),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                                "${data_perumahan[0]['jml_warga_tidak_punya_fasilitas_bab']}"),
                          ),
                          Icon(Icons.arrow_right_rounded),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        DetailKeteranganPerumahanData(
                            judul: "tidak punya fasilitas cuci tangan",
                            keyy:
                                'data_warga_tidak_punya_fasilitas_cuci_tangan'),
                      );
                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 20),
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
                                "Jml Warga tidak punya fasilitas cuci tangan"),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                                "${data_perumahan[0]['jml_warga_tidak_punya_fasilitas_cuci_tangan']}"),
                          ),
                          Icon(Icons.arrow_right_rounded),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        DetailKeteranganPerumahanData(
                            judul: "tidak pakai Listrik PLN",
                            keyy: 'data_warga_tidak_pakai_listrik_pln'),
                      );
                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 20),
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
                            child: Text("Jml Warga tidak pakai Listrik PLN"),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                                "${data_perumahan[0]['jml_warga_tidak_pakai_listrik_pln']}"),
                          ),
                          Icon(Icons.arrow_right_rounded),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
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
