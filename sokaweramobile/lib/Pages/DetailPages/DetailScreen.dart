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
import 'package:sokaweramobile/Pages/LengkapiData/main.dart';
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
  List data_kurang = [];
  late Future myFuture;
  var anak = {};
  var id;
  var nama = "";
  var nik_kk = "";
  var nama_laki = [];
  var nama_perempuan = [];
  var jsonKetSosial = [];
  var jsonPendidikan = [];
  List dataResponden = [];
  List dataSosial = [];
  List dataKesehatan = [];
  List dataUsaha = [];
  List dataTernak = [];
  List dataKorban = [];
  List dataPerumahan = [];
  List dataPembangunan = [];
  List dataPendidikan = [];
  List dataAset = [];
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
    await _loadData(widget.nik);
    await _loadResponden(widget.nik);
    await _loadSosial(widget.nik);
    await _loadPendidikan(widget.nik);
    await _loadKesehatan(widget.nik);
    await _loadUsaha(widget.nik);
    await _loadAset(widget.nik);
    await _loadTernak(widget.nik);
    await _loadEval(widget.nik);
    await _loadKeteranganPerumahan(widget.nik);
    await getStatus();
    return data;
  }

  _loadResponden(nik) async {
    var res = await Network().getData('keterangan_responden/nik/${nik}');
    var jsonData = jsonDecode(res.body);
    for (var element in jsonData['data']) {
      var warga = {
        'jumlah_anggota_keluarga_sesuai_kk':
            element['jumlah_anggota_keluarga_sesuai_kk'],
        'jumlah_anggota_keluarga_menyusui':
            element['jumlah_anggota_keluarga_menyusui'],
        'jumlah_anggota_keluarga_tinggal_dirumah':
            element['jumlah_anggota_keluarga_tinggal_dirumah'],
        'jumlah_anggota_keluarga_sedang_tki':
            element['jumlah_anggota_keluarga_sedang_tki'],
        'jumlah_anggota_keluarga_ikatan_dinas':
            element['jumlah_anggota_keluarga_ikatan_dinas'],
        'jumlah_anggota_keluarga_jaminan_kesehatan':
            element['jumlah_anggota_keluarga_jaminan_kesehatan'],
      };
      dataResponden.add(warga);
    }
    return dataResponden;
  }

  _loadSosial(nik) async {
    var res = await Network().getData('keterangan_sosial/nik/${nik}');
    var jsonData = jsonDecode(res.body);
    var warga = {
      'jml_hamil': jsonData['jml_hamil'],
      'jml_sekolah': jsonData['jml_sekolah']
    };
    dataSosial.add(warga);
    return dataSosial;
  }

  _loadPendidikan(nik) async {
    var res =
        await Network().getData('keterangan_khusus_pendidikan/nik/${nik}');
    var jsonData = jsonDecode(res.body);
    if (jsonData['data'].length == 0) {
      var warga = {
        'jml_beasiswa': jsonData['jml_beasiswa'],
        'jml_kost': jsonData['jml_kost'],
      };
      dataPendidikan.add(warga);
    } else {
      var warga = {
        'jml_beasiswa': jsonData['jml_beasiswa'],
        'jml_kost': jsonData['jml_kost'],
      };
      dataPendidikan.add(warga);
    }
    return dataPendidikan;
  }

  _loadKesehatan(nik) async {
    var res = await Network().getData('keterangan_kesehatan/nik/${nik}');
    var jsonData = jsonDecode(res.body);
    var warga = {
      'jumlah_orang_sudah_vaksin': jsonData['jumlah_orang_sudah_vaksin'],
      'jumlah_orang_penyakit': jsonData['jumlah_orang_penyakit'],
      'jumlah_pernah_covid': jsonData['jumlah_pernah_covid'],
    };
    dataKesehatan.add(warga);
    return data;
  }

  _loadUsaha(nik) async {
    var res = await Network().getData('keterangan_usaha/nik/${nik}');
    var jsonData = jsonDecode(res.body);
    if (jsonData['data'].length == 0) {
      dataUsaha = [];
    } else {
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
          "pekerja_keluarga_tdk_dibayar":
              element["pekerja_keluarga_tdk_dibayar"],
          "komoditas": element["komoditas"],
          "memiliki_IUMK": element["memiliki_IUMK"],
          "omset_penjualan": element["omset_penjualan"],
        };
        dataUsaha.add(warga);
      }
    }
    return dataUsaha;
  }

  bool _isHaveAset = true;
  _loadAset(nik) async {
    var res = await Network().getData('kepemilikan_aset/nik/${nik}');
    var jsonData = jsonDecode(res.body);

    if (jsonData['data'].length == 0) {
      dataAset = [];
      data_kurang.add('Kepemilikan Aset');
      setState(() {
        _isHaveAset = false;
      });
    } else {
      for (var element in jsonData['data']) {
        var warga = {
          "ac": element["ac"],
          "kulkas": element["kulkas"],
          "mesin_cuci": element["mesin_cuci"],
          "televisi": element["televisi"],
          "komputer_laptop": element["komputer_laptop"],
          "mobil": element["mobil"],
          "motor": element["motor"],
          "sepeda": element["sepeda"],
        };
        dataAset.add(warga);
      }
      setState(() {
        _isHaveAset = true;
      });
    }
    return dataAset;
  }

  _loadTernak(nik) async {
    var res = await Network().getData('kepemilikan_hewan/nik/${nik}');
    var jsonData = jsonDecode(res.body);
    var data = [];
    if (jsonData['kepemilikan_ternak'].length == 0) {
      dataTernak = [];
    } else {
      for (var element in jsonData['kepemilikan_ternak']) {
        var warga = {
          'jenis_ternak': element["jenis_ternak"],
          'jumlah_ternak': element["jumlah_ternak_dikuasai"],
        };
        dataTernak.add(warga);
      }
    }
    return data;
  }

  bool _isFilledKuisioner = true;
  _loadEval(nik) async {
    var res = await Network().getData('eval_pembangunan/nik/${nik}');
    var jsonData = jsonDecode(res.body);
    if (jsonData['data'].length == 0) {
      data_kurang.add('Kuisioner');
      setState(() {
        _isFilledKuisioner = false;
      });
    } else {
      for (var element in jsonData['data']) {
        var warga = {
          'jml_anggota_keluarga_korban_kejahatan':
              element['jml_anggota_keluarga_korban_kejahatan'],
          'jml_anggota_keluarga_korban_bencana':
              element['jml_anggota_keluarga_korban_bencana'],
        };
        dataKorban.add(warga);
      }
      _isFilledKuisioner = true;
    }

    return dataKorban;
  }

  bool _isFilledKeteranganPerumahan = true;
  _loadKeteranganPerumahan(nik) async {
    var res = await Network().getData('keterangan_perumahan/nik/${nik}');
    var jsonData = jsonDecode(res.body);
    if (jsonData['data'].length == 0) {
      data_kurang.add('Keterangan Perumahan');
      setState(() {
        _isFilledKeteranganPerumahan = false;
      });
    } else {
      for (var element in jsonData['data']) {
        var warga = {
          "status_penggunaan_bangunan_tempat_tinggal":
              element["status_penggunaan_bangunan_tempat_tinggal"],
          "status_lahan_bangunan_tempat_tinggal":
              element["status_lahan_bangunan_tempat_tinggal"],
          "jumlah_kk_tinggal_dibangunan":
              element["jumlah_kk_tinggal_dibangunan"],
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
          "jumlah_fasilitas_cuci_tangan":
              element["jumlah_fasilitas_cuci_tangan"],
          "nomor_kk": element["nomor_kk"],
        };
        dataPerumahan.add(warga);
      }
      setState(() {
        _isFilledKeteranganPerumahan = true;
      });
    }

    return dataPerumahan;
  }

  bool _statusAll = false;
  getStatus() async {
    if (_isFilledKeteranganPerumahan && _isFilledKuisioner && _isHaveAset) {
      setState(() {
        _statusAll = true;
      });
    } else {
      setState(() {
        _statusAll = false;
      });
    }
  }

  void initState() {
    _loadKeteranganSosial(widget.nik);
    _loadKeteranganKhususPendidikan(widget.nik);
    myFuture = _fetchData(widget.item);
    super.initState();
  }

  _loadData(nik_kk) async {
    var res = await Network().getData('keterangan_tempat/nik/${nik_kk}');
    var jsonData = jsonDecode(res.body);

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
    return Scaffold(
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
                    height: size.height * 0.17,
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
                            height: size.height * 0.12,
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
                                      width: 85,
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
                  Visibility(
                    visible: _statusAll ? true : false,
                    child: InkWell(
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
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: _statusAll ? false : true,
                    child: InkWell(
                      onTap: () {
                        Get.to(LengkapiDataMain(
                          data: data_kurang,
                          nik: widget.nik,
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
                                "Lengkapi data",
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
