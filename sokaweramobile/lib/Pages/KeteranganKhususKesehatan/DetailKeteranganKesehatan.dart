import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sokaweramobile/Pages/components/BottomNavBar.dart';

class DetailKeteranganKesehatan extends StatefulWidget {
  final String nama;
  final String nik;
  const DetailKeteranganKesehatan(
      {super.key, required this.nama, required this.nik});

  @override
  State<DetailKeteranganKesehatan> createState() =>
      _DetailKeteranganKesehatanState();
}

class _DetailKeteranganKesehatanState extends State<DetailKeteranganKesehatan> {
  var total_data;
  var nama;
  var nik_local;
  var list_nama = [];
  bool _isFilled = false;

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

  _loadListKeteranganSosial() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getStringList("nama_anggota") ?? [];
    if (user != null) {
      for (var element in user) {
        var parsing = jsonDecode(element);
        if (user.length <= total_data) {
          list_nama.add(parsing["nama"]);
        }
      }
      var kekurangan = total_data - user.length;
      for (var i = 0; i < kekurangan; i++) {
        list_nama.add("Belum diisi");
      }
      if (user.length == total_data) {
        _isFilled = true;
      }
    }
  }

  String selectedValue1 = "Tidak";
  String selectedValue2 = "Tidak";
  String selectedValue3 = "Tidak";
  String selectedValue4 = "Tidak";
  bool isHave = false;
  bool isHave2 = false;
  bool isHave3 = false;
  bool isHave4 = false;

  List<DropdownMenuItem<String>> get dropdownItems1 {
    List<DropdownMenuItem<String>> menuItems1 = [
      DropdownMenuItem(child: Text("Ya"), value: "Ya"),
      DropdownMenuItem(child: Text("Tidak"), value: "Tidak"),
    ];
    return menuItems1;
  }

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
    switch (selectedValue1) {
      case "Tidak":
        setState(() {
          isHave = false;
        });

        break;
      case "Ya":
        setState(() {
          isHave = true;
        });
        break;
      default:
    }
  }

  _getStatus2() async {
    switch (selectedValue2) {
      case "Tidak":
        setState(() {
          isHave2 = false;
        });

        break;
      case "Ya":
        setState(() {
          isHave2 = true;
        });
        break;
      default:
    }
  }

  _getStatus3() async {
    switch (selectedValue3) {
      case "Tidak":
        setState(() {
          isHave3 = false;
        });

        break;
      case "Ya":
        setState(() {
          isHave3 = true;
        });
        break;
      default:
    }
  }

  _getStatus4() async {
    switch (selectedValue4) {
      case "Tidak":
        setState(() {
          isHave4 = false;
        });

        break;
      case "Ya":
        setState(() {
          isHave4 = true;
        });
        break;
      default:
    }
  }

  var cacat;
  var penyakit;
  var opname;
  var keluhan;
  var covid;
  var keluhanCovid;
  var tempat;

  _statusSelected() async {
    switch (selectedValue1) {
      case "Ya":
        setState(() {
          penyakit = penyakitController.text;
        });
        break;
      case "Tidak":
        setState(() {
          penyakit = "Tidak Ada";
        });
        break;
      default:
    }
    switch (selectedValue2) {
      case "Ya":
        setState(() {
          cacat = cacatController.text;
        });
        break;
      case "Tidak":
        setState(() {
          cacat = "Tidak Ada";
        });
        break;
      default:
    }
    switch (selectedValue3) {
      case "Ya":
        setState(() {
          opname = frekOpnameController.text;
          keluhan = keluhanOpnameController.text;
        });
        break;
      case "Tidak":
        setState(() {
          opname = "Tidak Pernah";
          keluhan = "Tidak Pernah Opname";
        });
        break;
      default:
    }
    switch (selectedValue4) {
      case "Ya":
        covid = "Pernah";
        tempat = tempatKarantinaController.text;
        keluhanCovid = keluhanCovidController.text;
        break;
      case "Tidak":
        covid = "Tidak Pernah";
        tempat = "Tidak Pernah terpapar covid";
        keluhanCovid = "Tidak ada";
        break;
      default:
    }
  }

  var nik_kk;
  var nik;

  _loadNikFromLocal() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString("keterangan_sosial");
    var parsing = jsonDecode(user!);
    if (user != null) {
      setState(() {
        nik_kk = parsing['nik_kk'];
      });
    }
  }

  List nama_anggota = [];

  TextEditingController penyakitController = TextEditingController();
  TextEditingController cacatController = TextEditingController();
  TextEditingController frekOpnameController = TextEditingController();
  TextEditingController tempatKarantinaController = TextEditingController();
  TextEditingController keluhanOpnameController = TextEditingController();
  TextEditingController keluhanCovidController = TextEditingController();
  TextEditingController pernahVaksinController = TextEditingController();
  TextEditingController biayaKesehatanController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _loadKeteranganTotalData();
    _loadListKeteranganSosial();
    _statusSelected();
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
    _getStatus2();
    _getStatus3();
    _getStatus4();
    _statusSelected();

    _savedDataToLocal() async {
      List data_sebelum_append = [];

      var data = {
        'nama': "${namaController.text}",
        'penyakit': penyakit,
        'jenis_cacat': cacat,
        'jumlah_hari_opname': opname,
        'keluhan_kesehatan': keluhan,
        'pernah_terpapar_covid': covid,
        'tempat_karantina_covid': tempat,
        'jenis_keluhan_covid': keluhanCovid,
        'sudah_vaksin_covid': pernahVaksinController.text,
        'biaya_kesehatan': biayaKesehatanController.text,
        'nik': widget.nik,
        'nomor_kk': nik_kk,
      };

      data_sebelum_append.add(data);
      print(data);
      final userEncode = jsonEncode(data);
      nama_anggota.add(userEncode);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('keterangan_khusus_kesehatan', userEncode);

      if (localStorage.getString('keterangan_khusus_kesehatan') != null) {
        var currentList =
            localStorage.getStringList('detail_keterangan_khusus_kesehatan') ??
                [];
        currentList.add(userEncode);
        await localStorage.setStringList(
            'detail_keterangan_khusus_kesehatan', currentList);
        showAlertDialog(context);
      }
    }

    _loadNikFromLocal();
    nik_local = widget.nik;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text("Keterangan ${widget.nama}"),
        backgroundColor: Color(0xFF68b7d8),
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
              child: Text(
                textAlign: TextAlign.center,
                "Apakah Mempunyai Penyakit Kronis Menahun ?",
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
                value: selectedValue1,
                items: dropdownItems1,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue1 = newValue!;
                  });
                },
              ),
            ),
            Visibility(
              visible: isHave ? true : false,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
                child: TextFormField(
                  controller: penyakitController,
                  enabled: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Nama Penyakit yang diderita',
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
              child: Text(
                textAlign: TextAlign.center,
                "Apakah Mempunyai Cacat ?",
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
            Visibility(
              visible: isHave2 ? true : false,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
                child: TextFormField(
                  controller: cacatController,
                  enabled: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Jenis cacat',
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
              child: Text(
                textAlign: TextAlign.center,
                "Apakah Pernah Opname dalam setahun terakhir ?",
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
            Visibility(
              visible: isHave3 ? true : false,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
                child: TextFormField(
                  controller: frekOpnameController,
                  enabled: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Jumlah hari opname',
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
            Visibility(
              visible: isHave3 ? true : false,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
                child: TextFormField(
                  controller: keluhanOpnameController,
                  enabled: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Keluhan Kesehatan Sewaktu Opname',
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
              child: Text(
                textAlign: TextAlign.center,
                "Apakah Pernah Terpapar Covid Selama 2020 ?",
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
              visible: isHave4 ? true : false,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
                child: TextFormField(
                  controller: tempatKarantinaController,
                  enabled: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Tempat Karantina',
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
            Visibility(
              visible: isHave4 ? true : false,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
                child: TextFormField(
                  controller: keluhanCovidController,
                  enabled: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Keluhan waktu covid',
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
                controller: pernahVaksinController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Apakah Sudah Pernah Vaksin ?',
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
                controller: biayaKesehatanController,
                keyboardType: TextInputType.number,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Biaya Kesehatan selama setahun',
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
