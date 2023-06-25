import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sokaweramobile/Network/api.dart';
import 'package:sokaweramobile/Pages/components/BottomNavBar.dart';

class KeteranganPerumahanLengkapi extends StatefulWidget {
  final String nik;
  const KeteranganPerumahanLengkapi({super.key, required this.nik});

  @override
  State<KeteranganPerumahanLengkapi> createState() =>
      _KeteranganPerumahanLengkapiState();
}

class _KeteranganPerumahanLengkapiState
    extends State<KeteranganPerumahanLengkapi> {
  TextEditingController jumlahKeluargaTinggalController =
      TextEditingController();
  TextEditingController luasLantaiController = TextEditingController();
  TextEditingController jumlahRuanganController = TextEditingController();

  var selectedValue1 = "Milik Sendiri";
  List<DropdownMenuItem<String>> get dropdownItems1 {
    List<DropdownMenuItem<String>> menuItems1 = [
      DropdownMenuItem(child: Text("Milik Sendiri"), value: "Milik Sendiri"),
      DropdownMenuItem(child: Text("Kontrak / Sewa"), value: "Kontrak / Sewa"),
      DropdownMenuItem(child: Text("Bebas sewa"), value: "Bebas sewa"),
      DropdownMenuItem(child: Text("Dinas"), value: "Dinas"),
      DropdownMenuItem(child: Text("Lainnya"), value: "Lainnya"),
    ];
    return menuItems1;
  }

  var selectedValue2 = "Milik Sendiri";
  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems2 = [
      DropdownMenuItem(child: Text("Milik Sendiri"), value: "Milik Sendiri"),
      DropdownMenuItem(
          child: Text("Milik orang lain"), value: "Milik orang lain"),
      DropdownMenuItem(
          child: Text("Milik perusahaan"), value: "Milik perusahaan"),
      DropdownMenuItem(child: Text("Milik negara"), value: "Milik negara"),
      DropdownMenuItem(child: Text("Lainnya"), value: "Lainnya"),
    ];
    return menuItems2;
  }

  var selectedValue3 = "Marmer/granit";
  List<DropdownMenuItem<String>> get dropdownItems3 {
    List<DropdownMenuItem<String>> menuItems3 = [
      DropdownMenuItem(child: Text("Marmer/granit"), value: "Marmer/granit"),
      DropdownMenuItem(child: Text("Keramik"), value: "Keramik"),
      DropdownMenuItem(child: Text("Parket / vinil"), value: "Parket / vinil"),
      DropdownMenuItem(child: Text("Ubin / tegel"), value: "Ubin / tegel"),
      DropdownMenuItem(
          child: Text("Kayu kualitas tinggi"), value: "Kayu kualitas tinggi"),
      DropdownMenuItem(child: Text("Plesteran"), value: "Plesteran"),
      DropdownMenuItem(
          child: Text("Kayu kualitas rendah"), value: "Kayu kualitas rendah"),
      DropdownMenuItem(child: Text("Bambu"), value: "Bambu"),
      DropdownMenuItem(child: Text("Tanah"), value: "Tanah"),
      DropdownMenuItem(child: Text("Lainnya"), value: "Lainnya"),
    ];
    return menuItems3;
  }

  var selectedValue4 = "Tembok";
  List<DropdownMenuItem<String>> get dropdownItems4 {
    List<DropdownMenuItem<String>> menuItems4 = [
      DropdownMenuItem(child: Text("Tembok"), value: "Tembok"),
      DropdownMenuItem(
          child: Text("Bata belum diplester"), value: "Bata belum diplester"),
      DropdownMenuItem(child: Text("Kayu"), value: "Kayu"),
      DropdownMenuItem(child: Text("Anyaman bambu"), value: "Anyaman bambu"),
      DropdownMenuItem(child: Text("Bambu"), value: "Bambu"),
      DropdownMenuItem(child: Text("Lainnya"), value: "Lainnya"),
    ];
    return menuItems4;
  }

  var selectedValue5 = "Air kemasan merk";
  List<DropdownMenuItem<String>> get dropdownItems5 {
    List<DropdownMenuItem<String>> menuItems5 = [
      DropdownMenuItem(
          child: Text("Air kemasan merk"), value: "Air kemasan merk"),
      DropdownMenuItem(child: Text("Air isi ulang"), value: "Air isi ulang"),
      DropdownMenuItem(child: Text("Ledeng meteran"), value: "Ledeng meteran"),
      DropdownMenuItem(child: Text("Ledeng eceran"), value: "Ledeng eceran"),
      DropdownMenuItem(child: Text("Sumur pompa"), value: "Sumur pompa"),
      DropdownMenuItem(
          child: Text("Sumur terlindung"), value: "Sumur terlindung"),
      DropdownMenuItem(
          child: Text("Mata air terlindung"), value: "Mata air terlindung"),
      DropdownMenuItem(
          child: Text("Sumur tak terlindung"), value: "Sumur tak terlindung"),
      DropdownMenuItem(
          child: Text("Mata air tak terlindung"),
          value: "Mata air tak terlindung"),
      DropdownMenuItem(child: Text("Air sungai"), value: "Air sungai"),
      DropdownMenuItem(child: Text("Air hujan"), value: "Air hujan"),
      DropdownMenuItem(child: Text("Lainnya"), value: "Lainnya"),
    ];
    return menuItems5;
  }

  var selectedValue6 = "Listrik PLN";
  List<DropdownMenuItem<String>> get dropdownItems6 {
    List<DropdownMenuItem<String>> menuItems6 = [
      DropdownMenuItem(child: Text("Listrik PLN"), value: "Listrik PLN"),
      DropdownMenuItem(
          child: Text("Listrik PLN nyalur"), value: "Listrik PLN nyalur"),
      DropdownMenuItem(
          child: Text("Listrik non PLN"), value: "Listrik non PLN"),
      DropdownMenuItem(child: Text("Petromak"), value: "Petromak"),
      DropdownMenuItem(
          child: Text("Sentir / teplok"), value: "Sentir / teplok"),
      DropdownMenuItem(child: Text("Lainnya"), value: "Lainnya"),
    ];
    return menuItems6;
  }

  var selectedValue7 = "450 watt";
  List<DropdownMenuItem<String>> get dropdownItems7 {
    List<DropdownMenuItem<String>> menuItems7 = [
      DropdownMenuItem(child: Text("450 watt"), value: "450 watt"),
      DropdownMenuItem(child: Text("900 watt"), value: "900 watt"),
      DropdownMenuItem(child: Text("1300 watt"), value: "1300 watt"),
      DropdownMenuItem(child: Text("2200 watt"), value: "2200 watt"),
      DropdownMenuItem(child: Text(">2200 watt"), value: ">2200 watt"),
      DropdownMenuItem(child: Text("Tanpa meteran"), value: "Tanpa meteran"),
    ];
    return menuItems7;
  }

  var selectedValue8 = "Gas 3 kg";
  List<DropdownMenuItem<String>> get dropdownItems8 {
    List<DropdownMenuItem<String>> menuItems8 = [
      DropdownMenuItem(child: Text("Listrik PLN"), value: "Listrik PLN"),
      DropdownMenuItem(child: Text("Gas > 3 kg"), value: "Gas > 3 kg"),
      DropdownMenuItem(child: Text("Gas 3 kg"), value: "Gas 3 kg"),
      DropdownMenuItem(child: Text("Minyak tanah"), value: "Minyak tanah"),
      DropdownMenuItem(child: Text("Kayu bakar"), value: "Kayu bakar"),
      DropdownMenuItem(child: Text("Lainnya"), value: "Lainnya"),
    ];
    return menuItems8;
  }

  var selectedValue9 = "Milik sendiri";
  List<DropdownMenuItem<String>> get dropdownItems9 {
    List<DropdownMenuItem<String>> menuItems9 = [
      DropdownMenuItem(child: Text("Milik sendiri"), value: "Milik sendiri"),
      DropdownMenuItem(child: Text("Bersama"), value: "Bersama"),
      DropdownMenuItem(child: Text("Umum"), value: "Umum"),
      DropdownMenuItem(child: Text("Tidak ada"), value: "Tidak ada"),
    ];
    return menuItems9;
  }

  var selectedValue10 = "Leher angsa";
  List<DropdownMenuItem<String>> get dropdownItems10 {
    List<DropdownMenuItem<String>> menuItems10 = [
      DropdownMenuItem(child: Text("Leher angsa"), value: "Leher angsa"),
      DropdownMenuItem(child: Text("Plengsengan"), value: "Plengsengan"),
      DropdownMenuItem(
          child: Text("Cemplung / cubluk"), value: "Cemplung / cubluk"),
      DropdownMenuItem(child: Text("Tidak pakai"), value: "Tidak pakai"),
    ];
    return menuItems10;
  }

  var selectedValue11 = "Tanki septik";
  List<DropdownMenuItem<String>> get dropdownItems11 {
    List<DropdownMenuItem<String>> menuItems11 = [
      DropdownMenuItem(child: Text("Tanki septik"), value: "Tanki septik"),
      DropdownMenuItem(child: Text("Lubang tanah"), value: "Lubang tanah"),
      DropdownMenuItem(child: Text("Sungai / laut"), value: "Sungai / laut"),
      DropdownMenuItem(child: Text("Kolam"), value: "Kolam"),
      DropdownMenuItem(child: Text("Kebun"), value: "Kebun"),
      DropdownMenuItem(child: Text("Lainnya"), value: "Lainnya"),
    ];
    return menuItems11;
  }

  var selectedValue12 = "1 unit";
  List<DropdownMenuItem<String>> get dropdownItems12 {
    List<DropdownMenuItem<String>> menuItems12 = [
      DropdownMenuItem(child: Text("Tidak ada"), value: "Tidak ada"),
      DropdownMenuItem(child: Text("1 unit"), value: "1 unit"),
      DropdownMenuItem(child: Text("2 unit"), value: "2 unit"),
      DropdownMenuItem(child: Text("3 unit"), value: "3 unit"),
      DropdownMenuItem(child: Text("4 unit"), value: "4 unit"),
      DropdownMenuItem(child: Text("> 4 unit"), value: "> 4 unit"),
    ];
    return menuItems12;
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

  _savedDataToLocal() async {
    var data = {
      'status_penggunaan_bangunan_tempat_tinggal': selectedValue1,
      'status_lahan_bangunan_tempat_tinggal': selectedValue2,
      'jumlah_kk_tinggal_dibangunan': jumlahKeluargaTinggalController.text,
      'luas_lantai': luasLantaiController.text,
      'jenis_lantai_terluas': selectedValue3,
      'jenis_dinding_terluas': selectedValue4,
      'jumlah_ruangan_seluruhnya': jumlahRuanganController.text,
      'sumber_air_minum': selectedValue5,
      'sumber_penerangan_utama': selectedValue6,
      'daya_terpasang': selectedValue7,
      'bahan_bakar_utama_memasak': selectedValue8,
      'penggunaan_fasilitas_tempat_bab': selectedValue9,
      'jenis_kloset': selectedValue10,
      'tempat_pembuangan_akhir_tinja': selectedValue11,
      'jumlah_fasilitas_cuci_tangan': selectedValue12,
      'nomor_kk': widget.nik,
    };
    var res = await Network().store(data, 'keterangan_perumahan');
    var body = jsonDecode(res.body);
    showAlertDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text("Keterangan Perumahan"),
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
                "Status penggunaan bangunan tempat tinggal yang ditempati ? ",
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
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Status lahan bangunan tempat tinggal yang ditempati ? ",
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
                controller: jumlahKeluargaTinggalController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText:
                      'Jumlah keluarga (KK) yang tinggal di bangunan tempat tinggal ini',
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
                controller: luasLantaiController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Luas lantai (Meter Persegi)',
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
                "Jenis lantai terluas ? ",
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
                "Jenis dinding terluas ? ",
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
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: jumlahRuanganController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Jumlah ruangan seluruhnya dan kamar tidur',
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
                "Sumber air minum ? ",
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
                "Sumber penerangan utama ? ",
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
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Daya terpasang ? ",
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
                value: selectedValue7,
                items: dropdownItems7,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue7 = newValue!;
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
                "Bahan bakar utama untuk memasak ? ",
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
                value: selectedValue8,
                items: dropdownItems8,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue8 = newValue!;
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
                "Penggunaan fasilitas tempat BAB ? ",
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
                value: selectedValue9,
                items: dropdownItems9,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue9 = newValue!;
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
                "Jenis kloset fasilitas tempat BAB ? ",
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
                value: selectedValue10,
                items: dropdownItems10,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue10 = newValue!;
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
                "Tempat pembuangan akhir tinja ",
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
                value: selectedValue11,
                items: dropdownItems11,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue11 = newValue!;
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
                "Jumlah fasilitas cuci tangan pakai sabun",
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
                value: selectedValue12,
                items: dropdownItems12,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue12 = newValue!;
                  });
                },
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
