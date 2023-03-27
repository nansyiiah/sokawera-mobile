import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sokaweramobile/Network/api.dart';

class InputScreen3 extends StatefulWidget {
  final String name;
  final String inisial;
  const InputScreen3({super.key, required this.name, required this.inisial});

  @override
  State<InputScreen3> createState() => _InputScreen3State();
}

class _InputScreen3State extends State<InputScreen3> {
  String name = "";
  String inisial = "";
  var data;
  TextEditingController tanggalController = TextEditingController();
  TextEditingController namaPemeriksaController = TextEditingController();
  TextEditingController tanggalPeemeriksaController = TextEditingController();
  TextEditingController inisialPemeriksaController = TextEditingController();

  TextEditingController jumlah_laki_sesuai_kk = TextEditingController();
  TextEditingController jumlah_perempuan_sesuai_kk = TextEditingController();

  void initState() {
    _loadUserData();
    // _loadKeteranganData();
    super.initState();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('user');
    if (user != null) {
      return name;
    } else {
      setState(() {
        name = "null";
      });
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
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

  @override
  Widget build(BuildContext context) {
    TextEditingController namaController =
        TextEditingController(text: widget.name);
    name = widget.name;
    TextEditingController tandaTanganPencacahController =
        TextEditingController(text: widget.inisial);
    inisial = widget.inisial;
    var total_keluarga;

    _calculate() async {
      total_keluarga = int.parse(jumlah_laki_sesuai_kk.text) +
          int.parse(jumlah_perempuan_sesuai_kk.text);

      var data = {
        'nama_kepala_keluarga': namaController.text,
        'jumlah_anggota_keluarga_sesuai_kk': total_keluarga,
        'jumlah_anggota_keluarga_sesuai_kk_laki': jumlah_laki_sesuai_kk.text,
        'jumlah_anggota_keluarga_sesuai_kk_perempuan':
            jumlah_perempuan_sesuai_kk.text,
      };

      var res = await Network().store(data, 'keterangan_responden');
      var body = json.decode(res.body);
      if (body['status'] == 200) {
        print("success insert data");
      } else {
        print(body);
      }
    }

    _savedDataToLocal() async {
      List data_sebelum_append = [];
      var data = {
        'nama_pencacah': namaController.text,
        'tanggal_pencacah': tanggalController.text,
        'tanda_tangan_pencacah': tandaTanganPencacahController.text,
        'nama_pemeriksa': namaPemeriksaController.text,
        'tanggal_pemeriksaan': tanggalPeemeriksaController.text,
        'tanda_tangan_pemeriksa': inisialPemeriksaController.text,
      };
      data_sebelum_append.add(data);
      final userEncode = jsonEncode(data);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('nama_pencacah', namaController.text);
      localStorage.setString('tanggal_pencacah', tanggalController.text);
      localStorage.setString(
          'tanda_tangan_pencacah', tandaTanganPencacahController.text);
      localStorage.setString('nama_pemeriksa', namaPemeriksaController.text);
      localStorage.setString(
          'tanggal_pemeriksaan', tanggalPeemeriksaController.text);
      localStorage.setString(
          'tanda_tangan_pemeriksa', inisialPemeriksaController.text);
      localStorage.setString('keterangan_petugas', userEncode);
      print(localStorage.getString('keterangan_petugas'));
      if (localStorage.getString("keterangan_petugas") != null) {
        showAlertDialog(context);
      }
    }

    _loadKeteranganData() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var data = localStorage.getString('keterangan_petugas');
      if (data != null) {
        setState(() {
          var _id_petugas = localStorage.getInt('id_petugas');
          var nama_pencacah = localStorage.getString('nama_pencacah');
          var tanggal_pencacah = localStorage.getString('tanggal_pencacah');
          var tanda_tangan_pencacah =
              localStorage.getString('tanda_tangan_pencacah');
          var nama_pemeriksa = localStorage.getString('nama_pemeriksa');
          var tanggal_pemeriksaan =
              localStorage.getString('tanggal_pemeriksaan');
          var tanda_tangan_pemeriksa =
              localStorage.getString('tanda_tangan_pemeriksa');
          namaController.text = nama_pencacah ?? "";
          tanggalController.text = tanggal_pencacah ?? "";
          tandaTanganPencacahController.text = tanda_tangan_pencacah ?? "";
          namaPemeriksaController.text = nama_pemeriksa ?? "";
          tanggalPeemeriksaController.text = tanggal_pemeriksaan ?? "";
          inisialPemeriksaController.text = tanda_tangan_pemeriksa ?? "";
        });
      }
    }

    Size size = MediaQuery.of(context).size;
    _loadKeteranganData();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Keterangan Responden"),
        backgroundColor: Color(0xFF68b7d8),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: namaController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Nama Kepala Keluarga (KK)',
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
              height: 20,
            ),
            Container(
              child: Text(
                "Jumlah anggota keluarga :",
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
                      controller: jumlah_laki_sesuai_kk,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Laki Laki',
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
                      controller: jumlah_perempuan_sesuai_kk,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Perempuan',
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
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Jumlah anggota keluarga yang tinggal di rumah ini (sesuai KK):",
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
                      // controller: namaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Laki Laki',
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
                      // controller: namaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Perempuan',
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
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Jumlah anggota keluarga yang tidak tinggal di rumah ini (sesuai KK):",
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
                      // controller: namaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Laki Laki',
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
                      // controller: namaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Perempuan',
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
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Jumlah orang yang tidak dalam KK namun tinggal dirumah ini:",
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
                      // controller: namaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Laki Laki',
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
                      // controller: namaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Perempuan',
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
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Jumlah anggota keluarga yang sedang menyusui :",
                style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                // controller: namaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Jumlah anggota keluarga yang sedang menyusui',
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
            ), //
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Jumlah anggota keluarga memiliki jaminan kesehatan :",
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
                      // controller: namaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Laki Laki',
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
                      // controller: namaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Perempuan',
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
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Jumlah anggota keluarga sedang mencari pekerjaan / menyiapkan usaha :",
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
                      // controller: namaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Laki Laki',
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
                      // controller: namaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Perempuan',
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
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Jumlah anggota keluarga sedang menjadi TKI di luar negeri :",
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
                      // controller: namaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Laki Laki',
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
                      // controller: namaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Perempuan',
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
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Jumlah anggota keluarga menjadi PNS/TNI/POLRI/Pensiunan :",
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
                        const EdgeInsets.only(left: 10, right: 10, top: 24),
                    child: TextFormField(
                      // controller: namaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'PNS',
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
                        const EdgeInsets.only(left: 10, right: 10, top: 24),
                    child: TextFormField(
                      // controller: namaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'TNI/POLRI',
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
                        const EdgeInsets.only(left: 10, right: 10, top: 24),
                    child: TextFormField(
                      // controller: namaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Pensiunan',
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
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: size.height * 0.11,
              width: size.width,
              child: InkWell(
                onTap: () {
                  _calculate();
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
