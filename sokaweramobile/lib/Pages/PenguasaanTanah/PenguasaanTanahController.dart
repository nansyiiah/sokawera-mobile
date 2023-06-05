import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sokaweramobile/Pages/components/BottomNavBar.dart';

class PenguasaanTanahController extends StatefulWidget {
  final String jenisPenguasaanTanah;
  const PenguasaanTanahController(
      {super.key, required this.jenisPenguasaanTanah});

  @override
  State<PenguasaanTanahController> createState() =>
      _PenguasaanTanahControllerState();
}

class _PenguasaanTanahControllerState extends State<PenguasaanTanahController> {
  var lahanDimiliki, lahanDariPihakLain, lahanBeradaPihakLain;
  var total_lahan, nik_kk;
  List datas = [];

  _getTotalData() async {
    if (total_lahan == null) {
      total_lahan = 0;
    } else {
      setState(() {
        total_lahan = int.parse(lahanDimilikiController.text) +
            int.parse(lahanPihakLainController.text) -
            int.parse(lahanBeradaPihakLainController.text);
      });
    }
  }

  _getNomorKKLocal() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('keterangan_tempat');
    var parsing = jsonDecode(user!);
    if (user != null) {
      setState(() {
        nik_kk = parsing['nomor_kk'];
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

  @override
  TextEditingController nomorUrutBidangController = TextEditingController();
  TextEditingController lokasiLahanController = TextEditingController();
  TextEditingController nomorBlokTanahController = TextEditingController();
  TextEditingController lahanDimilikiController = TextEditingController();
  TextEditingController lahanPihakLainController = TextEditingController();
  TextEditingController lahanBeradaPihakLainController =
      TextEditingController();

  String selectedValue1 = "";

  List<DropdownMenuItem<String>> get dropdownItems1 {
    List<DropdownMenuItem<String>> menuItems1 = [
      DropdownMenuItem(
          child: Text("Lahan tempat tinggal"), value: "Lahan tempat tinggal"),
      DropdownMenuItem(child: Text("Lahan sawah"), value: "Lahan sawah"),
      DropdownMenuItem(
          child: Text("Lahan pertanian bukan sawah"),
          value: "Lahan pertanian bukan sawah"),
      DropdownMenuItem(child: Text("Lahan Lainnya"), value: "Lahan Lainnya"),
    ];
    return menuItems1;
  }

  String selectedValue2 = "Ya";

  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems2 = [
      DropdownMenuItem(child: Text("Ya"), value: "Ya"),
      DropdownMenuItem(child: Text("Belum"), value: "Belum"),
      DropdownMenuItem(child: Text("Tidak tahu"), value: "Tidak tahu"),
    ];
    return menuItems2;
  }

  String selectedValue3 = "Ya";

  List<DropdownMenuItem<String>> get dropdownItems3 {
    List<DropdownMenuItem<String>> menuItems3 = [
      DropdownMenuItem(child: Text("Ya"), value: "Ya"),
      DropdownMenuItem(child: Text("Belum"), value: "Belum"),
      DropdownMenuItem(child: Text("Tidak tahu"), value: "Tidak tahu"),
    ];
    return menuItems3;
  }

  @override
  void initState() {
    // TODO: implement initState
    _getNomorKKLocal();
    selectedValue1 = widget.jenisPenguasaanTanah.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _getTotalData();
    TextEditingController lahanDikuasaiController =
        TextEditingController(text: total_lahan.toString());

    _savedDataToLocal() async {
      List data_sebelum_append = [];
      var data = {
        'jenis_lahan': selectedValue1,
        'nomor_urut_bidang': nomorUrutBidangController.text,
        'lokasi_lahan': lokasiLahanController.text,
        'nomor_blok_tanah': nomorBlokTanahController.text,
        'tanah_bersertifikat': selectedValue2,
        'nama_sppt_sesuai': selectedValue3,
        'lahan_dimiliki': lahanDimilikiController.text,
        'lahan_pihak_lain': lahanPihakLainController.text,
        'lahan_berada_pihak_lain': lahanBeradaPihakLainController.text,
        'lahan_dikuasai': lahanDikuasaiController.text,
        'nomor_kk': "${nik_kk}",
      };
      data_sebelum_append.add(data);
      final userEncode = jsonEncode(data);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('penguasaan_tanah', userEncode);
      showAlertDialog(context);
    }

    print(widget.jenisPenguasaanTanah);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text("Penguasaan Tanah"),
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
              child: Text(
                textAlign: TextAlign.center,
                "Jenis Lahan yang dimiliki ? ",
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
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: nomorUrutBidangController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Nomor urut bidang',
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
                controller: lokasiLahanController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Lokasi Lahan',
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
                controller: nomorBlokTanahController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Nomor Blok Tanah',
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
                "Apakah Tanah Bersertifikat ? ",
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
                "Apakah nama di SPPT Tanah sudah sesuai nama pemilik ? ",
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
              child: Text(
                textAlign: TextAlign.center,
                "Luas lahan (meter persegi)",
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
                      controller: lahanDimilikiController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Dimiliki',
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
                      controller: lahanPihakLainController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'berasal dari pihak lain',
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
                      controller: lahanBeradaPihakLainController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'berada di pihak lain',
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
                controller: lahanDikuasaiController,
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Lahan dikuasai',
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
