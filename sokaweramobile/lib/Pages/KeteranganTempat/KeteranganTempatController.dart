import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sokaweramobile/Pages/components/BottomNavBar.dart';

class KeteranganTempatController extends StatefulWidget {
  const KeteranganTempatController({super.key});

  @override
  State<KeteranganTempatController> createState() =>
      _KeteranganTempatControllerState();
}

class _KeteranganTempatControllerState
    extends State<KeteranganTempatController> {
  String name = "";
  var data;
  TextEditingController provinsiController =
      TextEditingController(text: "JAWA TENGAH");
  TextEditingController kabupatenController =
      TextEditingController(text: "BANYUMAS");
  TextEditingController kecamatanController =
      TextEditingController(text: "PATIKRAJA");
  TextEditingController desaController =
      TextEditingController(text: "SOKAWERA");
  TextEditingController dusunController = TextEditingController();
  TextEditingController namaJalanController = TextEditingController();
  TextEditingController rtController = TextEditingController();
  TextEditingController rwController = TextEditingController();
  TextEditingController nomorKKController = TextEditingController();
  TextEditingController nomorUrutRumah = TextEditingController();
  TextEditingController nomorUrutKeluarga = TextEditingController();

  void initState() {
    _loadUserData();
    _loadKeteranganData();
    super.initState();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('user');
    if (user != null) {
      setState(() {
        name = user;
      });
    } else {
      setState(() {
        name = "null";
      });
    }
  }

  void rebuildPage() {
    setState(() {});
  }

  _deleteLocalKeteranganTempatData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('dusun');
    localStorage.remove('provinsi');
    localStorage.remove('kabupaten');
    localStorage.remove('kecamatan');
    localStorage.remove('desa');
    localStorage.remove('nama_jalan');
    localStorage.remove('rt');
    localStorage.remove('rw');
    localStorage.remove('nomor_kk');
    localStorage.remove('keterangan_tempat');
    localStorage.remove('nomor_urut_keluarga');
    localStorage.remove('nomor_urut_rumah');

    Navigator.of(context, rootNavigator: true).pop();
    Get.to(BottomNavBar());
  }

  _loadKeteranganData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var data = localStorage.getString('keterangan_tempat');
    if (data != null) {
      setState(() {
        var dusun = localStorage.getString('dusun');
        var provinsi = localStorage.getString('provinsi');
        var kabupaten = localStorage.getString('kabupaten');
        var kecamatan = localStorage.getString('kecamatan');
        var desa = localStorage.getString('desa');
        var nama_jalan = localStorage.getString('nama_jalan');
        var nomor_urut_kel = localStorage.getInt('nomor_urut_keluarga');
        var nomor_urut_rumah = localStorage.getInt('nomor_urut_rumah');
        var rt = localStorage.getInt('rt');
        var rw = localStorage.getInt('rw');
        var nomor_kk = localStorage.getInt('nomor_kk');
        dusunController.text = dusun ?? "";
        namaJalanController.text = nama_jalan ?? "";
        rtController.text = "${rt}";
        rwController.text = "${rw}";
        nomorKKController.text = "${nomor_kk}";
        nomorUrutKeluarga.text = "${nomor_urut_kel}";
        nomorUrutRumah.text = "${nomor_urut_rumah}";
      });
    }
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
      title: Text("Success Saved Data !"),
      content: Text(
        "Sukses menyimpan data !",
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

  showDeleteDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop(false);
      },
    );

    Widget okButton = TextButton(
      onPressed: () {
        _deleteLocalKeteranganTempatData();
      },
      child: Text("OK"),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text(
        "Are you sure want to delete ?",
        style: GoogleFonts.poppins(),
      ),
      actions: [
        cancelButton,
        okButton,
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

  _savedDataToLocal() async {
    List data_sebelum_append = [];
    var data = {
      'nomor_urut_rumah': nomorUrutRumah.text,
      'nomor_urut_keluarga': nomorUrutKeluarga.text,
      'provinsi': provinsiController.text,
      'kabupaten': kabupatenController.text,
      'kecamatan': kecamatanController.text,
      'desa': desaController.text,
      'dusun': dusunController.text,
      'nama_jalan': namaJalanController.text,
      'rt': rtController.text,
      'rw': rwController.text,
      'nomor_kk': nomorKKController.text,
    };
    data_sebelum_append.add(data);
    final userEncode = jsonEncode(data);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('dusun', dusunController.text);
    localStorage.setString('nama_jalan', namaJalanController.text);
    localStorage.setInt('rt', int.parse(rtController.text));
    localStorage.setInt('rw', int.parse(rwController.text));
    localStorage.setInt('nomor_kk', int.parse(nomorKKController.text));
    localStorage.setInt('nomor_urut_rumah', int.parse(nomorUrutRumah.text));
    localStorage.setInt(
        'nomor_urut_keluarga', int.parse(nomorUrutKeluarga.text));
    localStorage.setString('keterangan_tempat', userEncode);
    print(localStorage.getString('keterangan_tempat'));
    if (localStorage.getString("keterangan_tempat") != null) {
      showAlertDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text("Keterangan Tempat"),
        backgroundColor: Color(0xFF68b7d8),
        actions: [
          InkWell(
            onTap: () {
              showDeleteDialog(context);
            },
            child: Container(
              child: Icon(Icons.delete),
              padding: EdgeInsets.only(right: 15),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                "Nomor urut rumah dan keluarga : ",
                style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, top: 24),
                    child: TextFormField(
                      controller: nomorUrutRumah,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Nomor urut rumah',
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ), // <-- Wrapped in Expanded.
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, top: 24),
                    child: TextFormField(
                      controller: nomorUrutKeluarga,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Nomor urut keluarga',
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ), // <-- Wrapped in Expanded.
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: provinsiController,
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Provinsi',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: kabupatenController,
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Kabupaten',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: kecamatanController,
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Kecamatan',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: desaController,
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Desa',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: dusunController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Dusun',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: namaJalanController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Nama Jalan / Gang',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, top: 24),
                    child: TextFormField(
                      controller: rtController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'RT',
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ), // <-- Wrapped in Expanded.
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, top: 24),
                    child: TextFormField(
                      controller: rwController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'RW',
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ), // <-- Wrapped in Expanded.
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 24, bottom: 24),
              child: TextFormField(
                controller: nomorKKController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Nomor KK (maksimal 16 digit)',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.11,
              width: size.width,
              child: InkWell(
                onTap: () {
                  _savedDataToLocal();
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  padding:
                      EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
                  decoration: BoxDecoration(
                    color: Color(0xFF68b7d8),
                    borderRadius: BorderRadius.circular(5),
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
          ],
        ),
      ),
    );
  }
}
