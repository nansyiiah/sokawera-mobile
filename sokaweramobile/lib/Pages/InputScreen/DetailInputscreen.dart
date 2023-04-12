import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sokaweramobile/Pages/components/BottomNavBar.dart';

class DetailInputscreen extends StatefulWidget {
  final int item;
  const DetailInputscreen({super.key, required this.item});

  @override
  State<DetailInputscreen> createState() => _DetailInputscreenState();
}

class _DetailInputscreenState extends State<DetailInputscreen> {
  List list_hubungan_keluarga = [
    "Kepala Keluarga",
    "Istri / Suami",
    "Anak",
    "Menantu",
    "Cucu",
    "Orang Tua / Mertua",
    "Famili Lain",
    "Pembantu Rumah Tangga",
    "Lainnya",
  ];
  String selectedValue = "Kepala Keluarga";
  String selectedValue2 = "Ya";
  String selectedValue3 = "Laki Laki";
  String selectedValue4 = "Belum Kawin";
  String selectedValue5 = "Tidak Sedang Hamil";
  String selectedValue6 = "Masih Sekolah";

  TextEditingController namaAnggotaController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController umurController = TextEditingController();
  TextEditingController ijazahTertinggiController = TextEditingController();
  TextEditingController bekerjaController = TextEditingController();
  TextEditingController lapanganKerjaController = TextEditingController();
  TextEditingController statusKerjaController = TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text("Kepala Keluarga"), value: "Kepala Keluarga"),
      DropdownMenuItem(child: Text("Istri / Suami"), value: "Istri / Suami"),
      DropdownMenuItem(child: Text("Anak"), value: "Anak"),
      DropdownMenuItem(child: Text("Menantu"), value: "Menantu"),
      DropdownMenuItem(child: Text("Cucu"), value: "Cucu"),
      DropdownMenuItem(
          child: Text("Orang Tua / Mertua"), value: "Orang Tua / Mertua"),
      DropdownMenuItem(child: Text("Famili Lain"), value: "Famili Lain"),
      DropdownMenuItem(
          child: Text("Pembantu Rumah Tangga"), value: "Pembantu Rumah Tangga"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems2 = [
      DropdownMenuItem(child: Text("Ya"), value: "Ya"),
      DropdownMenuItem(child: Text("Tidak"), value: "Tidak"),
      DropdownMenuItem(
          child: Text("Ya (Bukan Anggota Keluarga)"),
          value: "Ya Bukan Anggota Keluarga"),
    ];
    return menuItems2;
  }

  List<DropdownMenuItem<String>> get dropdownItems3 {
    List<DropdownMenuItem<String>> menuItems3 = [
      DropdownMenuItem(child: Text("Laki Laki"), value: "Laki Laki"),
      DropdownMenuItem(child: Text("Perempuan"), value: "Perempuan"),
    ];
    return menuItems3;
  }

  List<DropdownMenuItem<String>> get dropdownItems4 {
    List<DropdownMenuItem<String>> menuItems4 = [
      DropdownMenuItem(child: Text("Belum Kawin"), value: "Belum Kawin"),
      DropdownMenuItem(child: Text("Kawin / Nikah"), value: "Kawin / Nikah"),
      DropdownMenuItem(child: Text("Cerai Hidup"), value: "Cerai Hidup"),
      DropdownMenuItem(child: Text("Cerai Mati"), value: "Cerai Mati"),
    ];
    return menuItems4;
  }

  List<DropdownMenuItem<String>> get dropdownItems5 {
    List<DropdownMenuItem<String>> menuItems5 = [
      DropdownMenuItem(child: Text("Sedang Hamil"), value: "Sedang Hamil"),
      DropdownMenuItem(
          child: Text("Tidak Sedang Hamil"), value: "Tidak Sedang Hamil"),
    ];
    return menuItems5;
  }

  List<DropdownMenuItem<String>> get dropdownItems6 {
    List<DropdownMenuItem<String>> menuItems6 = [
      DropdownMenuItem(
          child: Text("Tidak / belum sekolah"), value: "Tidak / belum sekolah"),
      DropdownMenuItem(child: Text("Masih Sekolah"), value: "Masih Sekolah"),
      DropdownMenuItem(
          child: Text("Tidak bersekolah lagi"), value: "Tidak bersekolah lagi"),
    ];
    return menuItems6;
  }

  int nik_kk_local = 0;
  int id_petugas = 0;
  int rt = 0;
  int rw = 0;
  _getKKfromLocal() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getInt("nik_kk");
    setState(() {
      nik_kk_local = user!;
    });
  }

  _getIdPetugasFromLocal() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getInt('id_petugas');
    var rt_lokal = localStorage.getInt('rt');
    var rw_lokal = localStorage.getInt('rw');
    setState(() {
      id_petugas = user!;
      rt = rt_lokal!;
      rw = rw_lokal!;
    });
  }

  List<String> nama_anggota = [];

  _savedDataToLocal() async {
    List data_sebelum_append = [];
    var data = {
      'nik_kk': "${nik_kk_local}",
      'rt': rt,
      'rw': rw,
      'nama': namaAnggotaController.text,
      'nik': nikController.text,
      'hubungan': selectedValue,
      'tinggal': selectedValue2,
      'jenis_kelamin': selectedValue3,
      'umur': int.parse(umurController.text),
      'status': selectedValue4,
      'status_kehamilan': selectedValue5,
      'partisipasi': selectedValue6,
      'ijazah_tertinggi': ijazahTertinggiController.text,
      'bekerja': bekerjaController.text,
      'lapangan_kerja': lapanganKerjaController.text,
      'status_kerja': statusKerjaController.text,
      'id_petugas': id_petugas,
    };
    data_sebelum_append.add(data);
    final userEncode = jsonEncode(data);
    nama_anggota.add(userEncode);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('keterangan_sosial', userEncode);
    // localStorage.setStringList("nama_anggota", nama_anggota);
    // localStorage.setString('nama_anak)
    // print(localStorage.getString('keterangan_sosial'));
    if (localStorage.getString("keterangan_sosial") != null) {
      var currentList = localStorage.getStringList("nama_anggota") ?? [];
      currentList.add(userEncode);
      await localStorage.setStringList("nama_anggota", currentList);
      await localStorage.setString('partisipasi', selectedValue6);
      showAlertDialog(context);
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

  _getList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getStringList("nama_anggota");
    print(user);
  }

  int umur = 0;
  bool isValid = false;
  @override
  void initState() {
    _getKKfromLocal();
    _getIdPetugasFromLocal();
    _getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text("${widget.item}"),
        backgroundColor: Color(0xFF68b7d8),
        actions: [
          InkWell(
            onTap: () {
              // showDeleteDialog(context);
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
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: TextFormField(
                controller: namaAnggotaController,
                // enabled: false,
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
                controller: nikController,
                // enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'NIK',
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
                "Hubungan dengan kepala keluarga: ",
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
                value: selectedValue,
                items: dropdownItems,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Tinggal di rumah ini ? ",
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
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Jenis Kelamin ? ",
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
                value: selectedValue3,
                items: dropdownItems3,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue3 = newValue!;
                  });
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: umurController,
                onChanged: (value) {
                  umur = int.parse(value);
                  if (umur >= 15 &&
                      umur <= 49 &&
                      selectedValue3 == "Perempuan") {
                    setState(() {
                      isValid = true;
                    });
                  } else {
                    setState(() {
                      isValid = false;
                    });
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Umur (Tahun)',
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
                "Status Perkawinan ? ",
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
                value: selectedValue4,
                items: dropdownItems4,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue4 = newValue!;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Status Kehamilan ? ",
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
                value: selectedValue5,
                items: dropdownItems5,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue5 = newValue!;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Partisipasi Sekolah ? ",
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
                value: selectedValue6,
                items: dropdownItems6,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue6 = newValue!;
                  });
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: ijazahTertinggiController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.school),
                  labelText: 'Ijazah Tertinggi yang dimiliki',
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
                controller: bekerjaController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.work),
                  labelText:
                      'Bekerja / membantu bekerja selama seminggu yang lalu',
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
                controller: lapanganKerjaController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.work),
                  labelText: 'Lapangan Bekerja',
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
                controller: statusKerjaController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.work),
                  labelText: 'Status Kedudukan Bekerja',
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
