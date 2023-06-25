import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sokaweramobile/Pages/components/BottomNavBar.dart';

class DetailKeteranganUsaha extends StatefulWidget {
  final String nama, nik, nomor_kk;
  const DetailKeteranganUsaha(
      {super.key,
      required this.nama,
      required this.nik,
      required this.nomor_kk});

  @override
  State<DetailKeteranganUsaha> createState() => _DetailKeteranganUsahaState();
}

class _DetailKeteranganUsahaState extends State<DetailKeteranganUsaha> {
  var nama;
  var nik;
  var nomor_kk;
  List nama_anggota = [];

  var selectedValue2 = "Tidak";

  TextEditingController lokasiUsahaController = TextEditingController();
  TextEditingController tempatUsahaController = TextEditingController();
  TextEditingController jumlahKaryawanController = TextEditingController();
  TextEditingController pekerjaTetapController = TextEditingController();
  TextEditingController pekerjaKeluargaController = TextEditingController();
  TextEditingController komoditasController = TextEditingController();
  TextEditingController omsetPenjualanController = TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems2 = [
      DropdownMenuItem(child: Text("Ya"), value: "Ya"),
      DropdownMenuItem(child: Text("Tidak"), value: "Tidak"),
    ];
    return menuItems2;
  }

  _deleteLocalKeteranganKesehatanData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove("keterangan_usaha");
    localStorage.remove("detail_keterangan_usaha");
    Get.to(BottomNavBar());
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

  @override
  Widget build(BuildContext context) {
    setState(() {
      nama = widget.nama;
      nik = widget.nik;
      nomor_kk = widget.nomor_kk;
    });
    TextEditingController namaController = TextEditingController(text: nama);

    Size size = MediaQuery.of(context).size;

    _savedDataToLocal() async {
      List data_sebelum_append = [];
      var data = {
        'nama': "${namaController.text}",
        'nik': "${nik}",
        'nomor_kk': "${nomor_kk}",
        'lokasi_usaha': "${lokasiUsahaController.text}",
        'tempat_usaha': "${tempatUsahaController.text}",
        'jumlah_karyawan': "${jumlahKaryawanController.text}",
        'pekerja_tetap_dibayar': "${pekerjaTetapController.text}",
        'pekerja_keluarga_tdk_dibayar': "${pekerjaKeluargaController.text}",
        'komoditas': "${komoditasController.text}",
        'memiliki_IUMK': "${selectedValue2}",
        'omset_penjualan': "${omsetPenjualanController.text}",
      };
      data_sebelum_append.add(data);
      final userEncode = jsonEncode(data);
      nama_anggota.add(userEncode);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('keterangan_usaha', userEncode);
      if (localStorage.getString('keterangan_usaha') != null) {
        var currentList =
            localStorage.getStringList('detail_keterangan_usaha') ?? [];
        currentList.add(userEncode);
        await localStorage.setStringList(
            'detail_keterangan_usaha', currentList);
        showAlertDialog(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text("Keterangan ${widget.nama.split(" ")[0]}"),
        backgroundColor: Color(0xFF68b7d8),
        actions: [
          InkWell(
            onTap: () {
              // showDeleteDialog(context);
              _deleteLocalKeteranganKesehatanData();
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
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: namaController,
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Nama Anggota Keluarga',
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
                controller: lokasiUsahaController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.pin_drop_rounded),
                  labelText: 'Lokasi usaha',
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
                controller: tempatUsahaController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.pin_drop_rounded),
                  labelText: 'Tempat usaha',
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
                controller: jumlahKaryawanController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Jumlah Karyawan',
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
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Pekerja",
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
                      controller: pekerjaTetapController,
                      decoration: InputDecoration(
                        labelText: 'Pekerja tetap (Dibayar)',
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
                      controller: pekerjaKeluargaController,
                      // keyboardType: ,
                      decoration: InputDecoration(
                        labelText: 'Pekerja keluarga (Tidak Dibayar)',
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
                controller: komoditasController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Komoditas',
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
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Apakah Memiliki IUMK ? ",
                style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              width: size.width,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 24),
              child: DropdownButton(
                value: selectedValue2,
                items: dropdownItems2,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue2 = newValue!;
                  });
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: omsetPenjualanController,
                enabled: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Omset Penjualan',
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
