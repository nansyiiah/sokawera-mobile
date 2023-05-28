import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sokaweramobile/Network/api.dart';
import 'package:sokaweramobile/Pages/DetailPages/DetailPerumahanData.dart';
import 'package:sokaweramobile/Pages/DetailPages/DetailUserUsahaData.dart';

class DetailAllData extends StatefulWidget {
  final String name;
  final String nik;
  const DetailAllData({super.key, required this.name, required this.nik});

  @override
  State<DetailAllData> createState() => _DetailAllDataState();
}

class _DetailAllDataState extends State<DetailAllData> {
  var nik_local;
  List dataResponden = [];
  List dataUsaha = [];
  List dataTernak = [];
  List dataKorban = [];
  List dataPerumahan = [];
  List dataPembangunan = [];
  var jml_keluarga_sesuai_kk,
      jumlah_anggota_keluarga_menyusui,
      jumlah_anggota_keluarga_tinggal_dirumah,
      jumlah_anggota_keluarga_sedang_tki,
      jumlah_anggota_keluarga_ikatan_dinas,
      jumlah_anggota_keluarga_jaminan_kesehatan,
      jml_hamil,
      jml_sekolah,
      jml_beasiswa,
      jml_kost,
      jumlah_orang_sudah_vaksin,
      jumlah_orang_penyakit,
      jumlah_pernah_covid,
      ac,
      kulkas,
      mesin_cuci,
      televisi,
      komputer_laptop,
      mobil,
      motor,
      sepeda;

  _loadAllData(nik_local) async {
    await _loadResponden(nik_local);
    await _loadSosial(nik_local);
    await _loadPendidikan(nik_local);
    await _loadKesehatan(nik_local);
    await _loadUsaha(nik_local);
    await _loadAset(nik_local);
    await _loadTernak(nik_local);
    await _loadEval(nik_local);
    await _loadKeteranganPerumahan(nik_local);
    var data = [];
    return data;
  }

  _loadResponden(nik) async {
    var res = await Network().getData('keterangan_responden/nik/${nik}');
    var jsonData = jsonDecode(res.body);
    var data = [];
    for (var element in jsonData['data']) {
      jml_keluarga_sesuai_kk = element['jumlah_anggota_keluarga_sesuai_kk'];
      jumlah_anggota_keluarga_menyusui =
          element['jumlah_anggota_keluarga_menyusui'];
      jumlah_anggota_keluarga_tinggal_dirumah =
          element['jumlah_anggota_keluarga_tinggal_dirumah'];
      jumlah_anggota_keluarga_sedang_tki =
          element['jumlah_anggota_keluarga_sedang_tki'];
      jumlah_anggota_keluarga_ikatan_dinas =
          element['jumlah_anggota_keluarga_ikatan_dinas'];
      jumlah_anggota_keluarga_jaminan_kesehatan =
          element['jumlah_anggota_keluarga_jaminan_kesehatan'];
    }
    return data;
  }

  _loadSosial(nik) async {
    var res = await Network().getData('keterangan_sosial/nik/${nik}');
    var jsonData = jsonDecode(res.body);
    var data = [];
    jml_hamil = jsonData['jml_hamil'];
    jml_sekolah = jsonData['jml_sekolah'];
    return data;
  }

  _loadPendidikan(nik) async {
    var res =
        await Network().getData('keterangan_khusus_pendidikan/nik/${nik}');
    var jsonData = jsonDecode(res.body);
    var data = [];
    jml_beasiswa = jsonData['jml_beasiswa'];
    jml_kost = jsonData['jml_kost'];
    return data;
  }

  _loadKesehatan(nik) async {
    var res = await Network().getData('keterangan_kesehatan/nik/${nik}');
    var jsonData = jsonDecode(res.body);
    var data = [];
    jumlah_orang_sudah_vaksin = jsonData['jumlah_orang_sudah_vaksin'];
    jumlah_orang_penyakit = jsonData['jumlah_orang_penyakit'];
    jumlah_pernah_covid = jsonData['jumlah_pernah_covid'];
    return data;
  }

  _loadUsaha(nik) async {
    var res = await Network().getData('keterangan_usaha/nik/${nik}');
    var jsonData = jsonDecode(res.body);
    var data = [];
    for (var element in jsonData['data']) {
      var warga = {
        'id': "${element['id']}",
        'nama': element['nama'],
        "nik": element["nik"],
        "nomor_kk": element["nomor_kk"],
        "lokasi_usaha": element["lokasi_usaha"],
        "tempat_usaha": element["tempat_usaha"],
        "jumlah_karyawan": element["jumlah_karyawan"],
        "pekerja_tetap_dibayar": element["pekerja_tetap_dibayar"],
        "pekerja_keluarga_tdk_dibayar": element["pekerja_keluarga_tdk_dibayar"],
        "komoditas": element["komoditas"],
        "memiliki_IUMK": element["memiliki_IUMK"],
        "omset_penjualan": element["omset_penjualan"],
      };
      dataUsaha.add(warga);
    }
    return data;
  }

  _loadAset(nik) async {
    var res = await Network().getData('kepemilikan_aset/nik/${nik}');
    var jsonData = jsonDecode(res.body);
    var data = [];

    for (var element in jsonData['data']) {
      ac = element["ac"];
      kulkas = element["kulkas"];
      mesin_cuci = element["mesin_cuci"];
      televisi = element["televisi"];
      komputer_laptop = element["komputer_laptop"];
      mobil = element["mobil"];
      motor = element["motor"];
      sepeda = element["sepeda"];
    }
    return data;
  }

  _loadTernak(nik) async {
    var res = await Network().getData('kepemilikan_hewan/nik/${nik}');
    var jsonData = jsonDecode(res.body);
    var data = [];
    for (var element in jsonData['kepemilikan_ternak']) {
      var warga = {
        'jenis_ternak': element["jenis_ternak"],
        'jumlah_ternak': element["jumlah_ternak_dikuasai"],
      };
      dataTernak.add(warga);
    }
    return data;
  }

  _loadEval(nik) async {
    var res = await Network().getData('eval_pembangunan/nik/${nik}');
    var jsonData = jsonDecode(res.body);
    var data = [];
    for (var element in jsonData['data']) {
      var warga = {
        'jml_anggota_keluarga_korban_kejahatan':
            element['jml_anggota_keluarga_korban_kejahatan'],
        'jml_anggota_keluarga_korban_bencana':
            element['jml_anggota_keluarga_korban_bencana'],
      };
      dataKorban.add(warga);
    }
    return data;
  }

  _loadKeteranganPerumahan(nik) async {
    var res = await Network().getData('keterangan_perumahan/nik/${nik}');
    var jsonData = jsonDecode(res.body);
    var data = [];
    for (var element in jsonData['data']) {
      var warga = {
        "status_penggunaan_bangunan_tempat_tinggal":
            element["status_penggunaan_bangunan_tempat_tinggal"],
        "status_lahan_bangunan_tempat_tinggal":
            element["status_lahan_bangunan_tempat_tinggal"],
        "jumlah_kk_tinggal_dibangunan": element["jumlah_kk_tinggal_dibangunan"],
        "luas_lantai": element["luas_lantai"],
        "jenis_lantai_terluas": element["jenis_lantai_terluas"],
        "jenis_dinding_terluas": element["jenis_dinding_terluas"],
        "jumlah_ruangan_seluruhnya": element["jumlah_ruangan_seluruhnya"],
        "sumber_air_minum": element["sumber_air_minum"],
        "sumber_penerangan_utama": element["sumber_penerangan_utama"],
        "daya_terpasang": element["daya_terpasang"],
        "bahan_bakar_utama_memasak": element["bahan_bakar_utama_memasak"],
        "penggunaan_fasilitas_tempat_bab":
            element["penggunaan_fasilitas_tempat_bab"],
        "jenis_kloset": element["jenis_kloset"],
        "tempat_pembuangan_akhir_tinja":
            element["tempat_pembuangan_akhir_tinja"],
        "jumlah_fasilitas_cuci_tangan": element["jumlah_fasilitas_cuci_tangan"],
        "nomor_kk": element["nomor_kk"],
      };
      dataPerumahan.add(warga);
    }

    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      nik_local = widget.nik;
    });

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Detail",
          style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white.withOpacity(0.93),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _loadAllData(widget.nik),
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
                          child: Text("Jumlah keluarga sesuai daftar KK"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("${jml_keluarga_sesuai_kk}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                          child:
                              Text("Jumlah anggota keluarga sedang menyusui"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("${jumlah_anggota_keluarga_menyusui}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                          child:
                              Text("Jumlah anggota keluarga tinggal dirumah"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                              "${jumlah_anggota_keluarga_tinggal_dirumah}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                          child: Text("Jumlah AK sedang menjadi TKI"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("${jumlah_anggota_keluarga_sedang_tki}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                          child: Text("Jumlah AK menjadi TNI/Polri/Pensiunan"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child:
                              Text("${jumlah_anggota_keluarga_ikatan_dinas}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                          child: Text("Jumlah AK memiliki jaminan kesehatan"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                              "${jumlah_anggota_keluarga_jaminan_kesehatan}"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24, top: 24, bottom: 10),
                    child: Text(
                      "Keterangan Sosial",
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
                          child: Text("Jumlah AK sedang sekolah"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("${jml_sekolah}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                          child: Text("Jumlah AK sedang hamil"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("${jml_hamil}"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24, top: 24, bottom: 10),
                    child: Text(
                      "Keterangan Khusus Pendidikan",
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
                          child: Text("Jumlah AK pernah mendapat beasiswa"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("${jml_beasiswa}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                          child: Text("Jumlah AK sedang ngekos"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("${jml_kost}"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24, top: 24, bottom: 10),
                    child: Text(
                      "Keterangan Khusus Kesehatan",
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
                          child: Text("Jumlah AK mempunyai penyakit kronis"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("${jumlah_orang_penyakit}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                          child: Text("Jumlah AK sudah vaksin"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("${jumlah_orang_sudah_vaksin}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                          child: Text("Jumlah AK pernah terpapar covid"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("${jumlah_pernah_covid}"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24, top: 24, bottom: 10),
                    child: Text(
                      "Anggota keluarga yang mempunyai usaha",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.15,
                    width: size.width,
                    child: dataUsaha.isEmpty
                        ? Center(
                            child: Text("No Data"),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(
                                    DetailUserUsahaData(
                                      keterangan: "Keterangan Usaha",
                                      jsonData: [dataUsaha[index]],
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
                                        child:
                                            Text("${dataUsaha[index]["nama"]}"),
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
                            itemCount: dataUsaha.length,
                          ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24, top: 24, bottom: 10),
                    child: Text(
                      "Detail keterangan rumah",
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
                  InkWell(
                    onTap: () {
                      Get.to(DetailPerumahanData(jsonData: dataPerumahan));
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
                            child: Text("Keterangan Perumahan"),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(Icons.keyboard_arrow_right_sharp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24, top: 24, bottom: 10),
                    child: Text(
                      "Kepemilikan Aset",
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
                          child: Text("Air Conditioner (AC)"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("${ac}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                          child: Text("Lemari Es / Kulkas"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("${kulkas}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                          child: Text("Mesin Cuci"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("${mesin_cuci}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                          child: Text("Televisi"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("${televisi}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                          child: Text("Komputer / Laptop"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("${komputer_laptop}"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24, top: 24, bottom: 10),
                    child: Text(
                      "Kepemilikan Kendaraan Transportasi",
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
                          child: Text("Mobil"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("${mobil}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                          child: Text("Sepeda Motor"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("${motor}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                          child: Text("Sepeda"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("${sepeda}"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24, top: 24, bottom: 10),
                    child: Text(
                      "Penguasaan Hewan Ternak",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.15,
                    width: size.width,
                    child: dataTernak.isEmpty
                        ? Center(
                            child: Text("No Data"),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {},
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
                                            "${dataTernak[index]["jenis_ternak"]}"),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Text(
                                            "${dataTernak[index]["jumlah_ternak"]}"),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: dataTernak.length,
                          ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24, top: 24, bottom: 10),
                    child: Text(
                      "Keterangan Bencana & Kejahatan",
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
                          child: Text("Jml AK korban kejahatan"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                              "${dataKorban[0]['jml_anggota_keluarga_korban_kejahatan']}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                          child: Text("Jml AK korban bencana alam"),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                              "${dataKorban[0]['jml_anggota_keluarga_korban_bencana']}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
