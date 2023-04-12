import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:sokaweramobile/Network/api.dart';
import 'InputScreen/KeteranganSosialAnggotaKeluargaController.dart';
import 'InputScreen/KeteranganTempatController.dart';
import 'InputScreen/KeteranganRespondenController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  String name = "";
  String initial = "";
  var total_data;
  bool _isFilled1 = false;
  bool _isFilled2 = false;
  bool _isFilled3 = false;
  bool _isFilled = false;
  bool isLoading = false;
  void initState() {
    _getKeteranganTempatFromLocal();
    _getKeteranganRespondenFromLocal();
    _loadUserData();
    _loadKeteranganTotalData();
    _loadAllDatafromLocal();

    super.initState();
  }

  _getKeteranganTempatFromLocal() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var data = localStorage.getString('keterangan_tempat');

    if (data != null) {
      setState(() {
        _isFilled1 = true;
      });
    } else {
      return null;
    }
  }

  _postAllData() async {
    await _postKeteranganTempatData();
    await _postKeteranganRespondenData();
    await _postKeteranganSosialData();
    setState(() {
      isLoading = false;
    });
  }

  _loadKeteranganTotalData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getInt('total_keluarga_full');
    if (user != null) {
      setState(() {
        total_data = user;
      });
    } else {
      return null;
    }
  }

  _postKeteranganTempatData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var keterangan_tempat = localStorage.getString('keterangan_tempat');
    var parsing = jsonDecode(keterangan_tempat!);
    var data = {
      "provinsi": parsing["provinsi"],
      "kabupaten": parsing["kabupaten"],
      "kecamatan": parsing["kecamatan"],
      "desa": parsing["desa"],
      "dusun": parsing["dusun"],
      "nama_jalan": parsing["nama_jalan"],
      "rt": parsing["rt"],
      "rw": parsing["rw"],
      "nomor_kk": parsing["nomor_kk"],
      "nomor_urut_rumah": parsing["nomor_urut_rumah"],
      "nomor_urut_keluarga": parsing["nomor_urut_keluarga"],
    };
    var res = await Network().store(data, 'keterangan_tempat');
    var body = json.decode(res.body);
    if (body["status"] == 200) {
      print("sukses insert keterangan tempat");
    }
  }

  _postKeteranganRespondenData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var keterangan_responden = localStorage.getString("keterangan_responden");
    var parsing = jsonDecode(keterangan_responden!);
    var nik_kk = localStorage.getInt("nik_kk");
    var data = {
      "nama_kepala_keluarga": parsing["nama_kepala_keluarga"],
      "jumlah_anggota_keluarga_sesuai_kk":
          parsing["jumlah_anggota_keluarga_sesuai_kk"],
      "jumlah_anggota_keluarga_sesuai_kk_laki":
          parsing["jumlah_anggota_keluarga_sesuai_kk_laki"],
      "jumlah_anggota_keluarga_sesuai_kk_perempuan":
          parsing["jumlah_anggota_keluarga_sesuai_kk_perempuan"],
      "jumlah_anggota_keluarga_tinggal_dirumah":
          parsing["jumlah_anggota_keluarga_tinggal_dirumah"],
      "jumlah_anggota_keluarga_tinggal_dirumah_laki":
          parsing["jumlah_anggota_keluarga_tinggal_dirumah_laki"],
      "jumlah_anggota_keluarga_tinggal_dirumah_perempuan":
          parsing["jumlah_anggota_keluarga_tinggal_dirumah_perempuan"],
      "jumlah_anggota_keluarga_tidak_tinggal_dirumah":
          parsing["jumlah_anggota_keluarga_tidak_tinggal_dirumah"],
      "jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki":
          parsing["jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki"],
      "jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan":
          parsing["jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan"],
      "jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah":
          parsing["jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah"],
      "jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki":
          parsing["jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki"],
      "jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan":
          parsing["jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan"],
      "jumlah_orang_tinggal_dirumah": parsing["jumlah_orang_tinggal_dirumah"],
      "jumlah_orang_tinggal_dirumah_laki":
          parsing["jumlah_orang_tinggal_dirumah_laki"],
      "jumlah_orang_tinggal_dirumah_perempuan":
          parsing["jumlah_orang_tinggal_dirumah_perempuan"],
      "jumlah_anggota_keluarga_menyusui":
          parsing["jumlah_anggota_keluarga_menyusui"],
      "jumlah_anggota_keluarga_jaminan_kesehatan":
          parsing["jumlah_anggota_keluarga_jaminan_kesehatan"],
      "jumlah_anggota_keluarga_jaminan_kesehatan_laki":
          parsing["jumlah_anggota_keluarga_jaminan_kesehatan_laki"],
      "jumlah_anggota_keluarga_jaminan_kesehatan_perempuan":
          parsing["jumlah_anggota_keluarga_jaminan_kesehatan_perempuan"],
      "jumlah_anggota_keluarga_sedang_mencari_pekerjaan":
          parsing["jumlah_anggota_keluarga_sedang_mencari_pekerjaan"],
      "jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki":
          parsing["jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki"],
      "jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan":
          parsing["jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan"],
      "jumlah_anggota_keluarga_sedang_tki":
          parsing["jumlah_anggota_keluarga_sedang_tki"],
      "jumlah_anggota_keluarga_sedang_tki_laki":
          parsing["jumlah_anggota_keluarga_sedang_tki_laki"],
      "jumlah_anggota_keluarga_sedang_tki_perempuan":
          parsing["jumlah_anggota_keluarga_sedang_tki_perempuan"],
      "jumlah_anggota_keluarga_ikatan_dinas":
          parsing["jumlah_anggota_keluarga_ikatan_dinas"],
      "jumlah_anggota_keluarga_ikatan_dinas_pns":
          parsing["jumlah_anggota_keluarga_ikatan_dinas_pns"],
      "jumlah_anggota_keluarga_ikatan_dinas_tni_polri":
          parsing["jumlah_anggota_keluarga_ikatan_dinas_tni_polri"],
      "jumlah_anggota_keluarga_ikatan_dinas_pensiunan":
          parsing["jumlah_anggota_keluarga_ikatan_dinas_pensiunan"],
      "id_petugas": parsing["id_petugas"],
      "nik_kk": "${nik_kk}",
      "rt": parsing["rt"],
      "rw": parsing["rw"],
    };

    var res = await Network().store(data, 'keterangan_responden');
    var body = json.decode(res.body);
    // print(parsing["id_petugas"]);
    if (body["status"] == 200) {
      print("sukses insert keterangan responden");
    } else {
      print(body);
    }
  }

  _postKeteranganSosialData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var keterangan_sosial = localStorage.getStringList("nama_anggota") ?? [];
    if (keterangan_sosial != null) {
      for (var element in keterangan_sosial) {
        var parsing = jsonDecode(element);
        var data = {
          "nik_kk": parsing["nik_kk"],
          "rt": parsing["rt"],
          "rw": parsing["rw"],
          "nama": parsing["nama"],
          "nik": parsing["nik"],
          "hubungan": parsing["hubungan"],
          "tinggal": parsing["tinggal"],
          "jenis_kelamin": parsing["jenis_kelamin"],
          "umur": parsing["umur"],
          "status": parsing["status"],
          "status_kehamilan": parsing["status_kehamilan"],
          "partisipasi": parsing["partisipasi"],
          "ijazah_tertinggi": parsing["ijazah_tertinggi"],
          "bekerja": parsing["bekerja"],
          "lapangan_kerja": parsing["lapangan_kerja"],
          "status_kerja": parsing["status_kerja"],
          "id_petugas": parsing["id_petugas"],
        };
        var res = await Network().store(data, 'keterangan_sosial');
        var body = json.decode(res.body);
        if (body["status"] == 200) {
          print("sukses insert keterangan sosial");
        } else {
          print("error");
        }
      }
    }
  }

  _getKeteranganRespondenFromLocal() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var data = localStorage.getString('keterangan_responden');

    if (data != null) {
      setState(() {
        _isFilled2 = true;
      });
    } else {
      return null;
    }
  }

  _loadAllDatafromLocal() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getStringList("nama_anggota");
    if (user != null) {
      for (var element in user) {
        var parsing = jsonDecode(element);
        if (user.length == total_data) {
          setState(() {
            _isFilled3 = true;
          });
        } else {
          setState(() {
            _isFilled3 = false;
          });
        }
      }
    }
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('user');
    if (user != null) {
      var inisial = localStorage.getString('username');
      setState(() {
        name = user;
        initial = inisial!;
      });
    } else {
      setState(() {
        name = "null";
      });
    }
  }

  _getStatusIsFilled() async {
    if (_isFilled1 == true && _isFilled2 == true && _isFilled3 == true) {
      setState(() {
        _isFilled = true;
      });
    } else {
      setState(() {
        _isFilled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _getStatusIsFilled();
    return Scaffold(
      backgroundColor: Color(0xFF68b7d8),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: size.height * 0.3,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/image-input.png"),
                ),
                color: Color(0xFF68b7d8),
              ),
            ),
            Container(
              height: size.height * 1,
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
                                padding: EdgeInsets.only(left: 24, top: 40),
                                child: Container(
                                  child: Text(
                                    "Input data",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 24),
                                child: Container(
                                  child: Text(
                                    "All you need to do is follow these steps",
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
                      isLoading
                          ? CircularProgressIndicator()
                          : Column(
                              children: [
                                Wrap(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(KeteranganTempatController());
                                      },
                                      child: Container(
                                        height: size.height * 0.06,
                                        margin: EdgeInsets.only(
                                          left: 24,
                                          right: 24,
                                          top: 24,
                                        ),
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        alignment: Alignment.center,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 0.3,
                                              color: Colors.grey,
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Stack(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Step 1:",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "Keterangan Tempat",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  _isFilled1
                                                      ? Icons.check_box_outlined
                                                      : Icons
                                                          .check_box_outline_blank,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    AbsorbPointer(
                                      absorbing: _isFilled1 ? false : true,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  KeteranganRespondenController(
                                                name: name,
                                                inisial: initial,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: size.height * 0.06,
                                          margin: EdgeInsets.only(
                                            left: 24,
                                            right: 24,
                                            top: 24,
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          alignment: Alignment.center,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0.3,
                                                color: Colors.grey,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Stack(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Step 2:",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    "Keterangan Responden",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    _isFilled2
                                                        ? Icons
                                                            .check_box_outlined
                                                        : Icons
                                                            .check_box_outline_blank,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    AbsorbPointer(
                                      absorbing: _isFilled2 ? false : true,
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(
                                            const KeteranganSosial(),
                                          );
                                        },
                                        child: Container(
                                          height: size.height * 0.06,
                                          margin: EdgeInsets.only(
                                            left: 24,
                                            right: 24,
                                            top: 24,
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          alignment: Alignment.center,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0.3,
                                                color: Colors.grey,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Stack(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Step 3:",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    "Keterangan Sosial Anggota Keluarga",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    _isFilled3
                                                        ? Icons
                                                            .check_box_outlined
                                                        : Icons
                                                            .check_box_outline_blank,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.2,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.11,
                                      width: size.width,
                                      child: AbsorbPointer(
                                        absorbing: _isFilled ? false : true,
                                        child: InkWell(
                                          onTap: () async {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            _postAllData();
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(
                                                left: 24, right: 24, top: 40),
                                            padding: EdgeInsets.only(
                                                left: 24,
                                                right: 24,
                                                top: 14,
                                                bottom: 14),
                                            decoration: BoxDecoration(
                                              color: _isFilled
                                                  ? Color(0xFF68b7d8)
                                                  : Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              "Submit",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
