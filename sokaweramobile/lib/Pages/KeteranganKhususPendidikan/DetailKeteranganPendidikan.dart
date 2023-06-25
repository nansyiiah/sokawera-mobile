import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sokaweramobile/Pages/components/BottomNavBar.dart';

class DetailKeteranganPendidikan extends StatefulWidget {
  final String nama;
  const DetailKeteranganPendidikan({super.key, required this.nama});

  @override
  State<DetailKeteranganPendidikan> createState() =>
      _DetailKeteranganPendidikanState();
}

class _DetailKeteranganPendidikanState
    extends State<DetailKeteranganPendidikan> {
  var nama;
  var nik;
  List<String> nama_anggota = [];

  _loadNikFromLocal() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('keterangan_tempat');
    var parsing = jsonDecode(user!);
    if (user != null) {
      setState(() {
        nik = parsing['nomor_kk'];
      });
    }
  }

  TextEditingController jenjangController = TextEditingController();
  TextEditingController namaSekolahController = TextEditingController();
  TextEditingController kelasController = TextEditingController();
  TextEditingController namaSekolahTujuanController = TextEditingController();
  TextEditingController jumlahBiayaSekolahController = TextEditingController();
  String selectedValue2 = "Tidak";
  String selectedValue3 = "Tidak";
  String selectedValue4 = "Ya";
  bool isLanjut = true;

  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems2 = [
      DropdownMenuItem(child: Text("Ya"), value: "Ya"),
      DropdownMenuItem(child: Text("Tidak"), value: "Tidak"),
    ];
    return menuItems2;
  }

  List<DropdownMenuItem<String>> get dropdownItems3 {
    List<DropdownMenuItem<String>> menuItems3 = [
      DropdownMenuItem(child: Text("Ya"), value: "Ya"),
      DropdownMenuItem(child: Text("Tidak"), value: "Tidak"),
    ];
    return menuItems3;
  }

  List<DropdownMenuItem<String>> get dropdownItems4 {
    List<DropdownMenuItem<String>> menuItems4 = [
      DropdownMenuItem(child: Text("Ya"), value: "Ya"),
      DropdownMenuItem(child: Text("Tidak"), value: "Tidak"),
    ];
    return menuItems4;
  }

  _getStatus() async {
    if (selectedValue4 == "Tidak") {
      setState(() {
        isLanjut = false;
      });
    } else {
      setState(() {
        isLanjut = true;
      });
    }
  }

  _deleteLocalKeteranganPendidikan() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('detail_keterangan_pendidikan');
    Navigator.of(context, rootNavigator: true).pop();
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
        _deleteLocalKeteranganPendidikan();
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

  @override
  void initState() {
    // TODO: implement initState
    _loadNikFromLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      nama = widget.nama;
    });
    TextEditingController namaController = TextEditingController(text: nama);

    Size size = MediaQuery.of(context).size;
    _getStatus();
    _savedDataToLocal() async {
      List data_sebelum_append = [];
      var data = {
        'nama': "${namaController.text}",
        'jenjang_pendidikan_ditempuh': "${jenjangController.text}",
        'nama_sekolah': "${namaSekolahController.text}",
        'kelas': "${kelasController.text}",
        'kost_tidak': selectedValue2,
        'beasiswa_tidak': selectedValue3,
        'melanjutkan_sekolah_tidak': selectedValue4,
        'nama_sekolah_tujuan': "${namaSekolahTujuanController.text}",
        'jumlah_biaya_sekolah': "${jumlahBiayaSekolahController.text}",
        'nik_kk': nik,
      };
      data_sebelum_append.add(data);
      final userEncode = jsonEncode(data);
      nama_anggota.add(userEncode);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('keterangan_khusus_pendidikan', userEncode);
      if (localStorage.getString('keterangan_khusus_pendidikan') != null) {
        var currentList =
            localStorage.getStringList('detail_keterangan_pendidikan') ?? [];
        currentList.add(userEncode);
        await localStorage.setStringList(
            'detail_keterangan_pendidikan', currentList);
        showAlertDialog(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text("Keterangan ${widget.nama}"),
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
                controller: jenjangController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Jenjang Pendidikan yang sedang ditempuh',
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
                controller: namaSekolahController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Nama Sekolah',
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
                controller: kelasController,
                keyboardType: TextInputType.number,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Kelas',
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
                "Apakah Ngekost ? ",
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
                "Apakah Pernah Mendapatkan Beasiswa ? (dalam setahun)",
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
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Apakah akan melanjutkan sekolah ?",
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
            Visibility(
              visible: isLanjut ? true : false,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
                child: TextFormField(
                  controller: namaSekolahTujuanController,
                  enabled: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Nama Sekolah Tujuan',
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
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: jumlahBiayaSekolahController,
                keyboardType: TextInputType.number,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Jumlah biaya pendidikan selama setahun',
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
