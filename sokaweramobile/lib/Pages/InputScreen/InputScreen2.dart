import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputScreen2 extends StatefulWidget {
  final String name;
  final String inisial;
  const InputScreen2({super.key, required this.name, required this.inisial});

  @override
  State<InputScreen2> createState() => _InputScreen2State();
}

class _InputScreen2State extends State<InputScreen2> {
  String name = "";
  String inisial = "";
  var data;
  TextEditingController tanggalController = TextEditingController();
  TextEditingController namaPemeriksaController = TextEditingController();
  TextEditingController tanggalPeemeriksaController = TextEditingController();
  TextEditingController inisialPemeriksaController = TextEditingController();

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
        title: Text("Keterangan Petugas"),
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
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Nama Pencacah',
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
                controller: tanggalController,
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      tanggalController.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                // enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Tanggal Pencacahan',
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
                controller: tandaTanganPencacahController,
                readOnly: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Tanda Tangan Pencacah',
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
                controller: namaPemeriksaController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Nama Pemeriksa / Editor',
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
                controller: tanggalPeemeriksaController,
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      tanggalPeemeriksaController.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Tanggal Pemeriksaan',
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
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 24, bottom: 24),
              child: TextFormField(
                controller: inisialPemeriksaController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Inisial pemeriksa / Editor',
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
