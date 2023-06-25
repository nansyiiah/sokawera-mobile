import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sokaweramobile/Network/api.dart';
import 'package:sokaweramobile/Pages/ListScreen.dart';
import 'package:sokaweramobile/Pages/components/BottomNavBar.dart';

class KeteranganAsetLengkapi extends StatefulWidget {
  final String nik;
  const KeteranganAsetLengkapi({super.key, required this.nik});

  @override
  State<KeteranganAsetLengkapi> createState() => _KeteranganAsetLengkapiState();
}

class _KeteranganAsetLengkapiState extends State<KeteranganAsetLengkapi> {
  var selectedValue1 = "Tidak punya";
  List<DropdownMenuItem<String>> get dropdownItems1 {
    List<DropdownMenuItem<String>> menuItems1 = [
      DropdownMenuItem(child: Text("Tidak punya"), value: "Tidak punya"),
      DropdownMenuItem(child: Text("1 unit"), value: "1 unit"),
      DropdownMenuItem(child: Text("2 unit"), value: "2 unit"),
      DropdownMenuItem(child: Text("3 unit"), value: "3 unit"),
      DropdownMenuItem(child: Text("4 unit"), value: "4 unit"),
      DropdownMenuItem(child: Text("> 4 unit"), value: "> 4 unit"),
    ];
    return menuItems1;
  }

  var selectedValue2 = "Tidak punya";
  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems2 = [
      DropdownMenuItem(child: Text("Tidak punya"), value: "Tidak punya"),
      DropdownMenuItem(child: Text("1 unit"), value: "1 unit"),
      DropdownMenuItem(child: Text("2 unit"), value: "2 unit"),
      DropdownMenuItem(child: Text("3 unit"), value: "3 unit"),
      DropdownMenuItem(child: Text("4 unit"), value: "4 unit"),
      DropdownMenuItem(child: Text("> 4 unit"), value: "> 4 unit"),
    ];
    return menuItems2;
  }

  var selectedValue3 = "Tidak punya";
  List<DropdownMenuItem<String>> get dropdownItems3 {
    List<DropdownMenuItem<String>> menuItems3 = [
      DropdownMenuItem(child: Text("Tidak punya"), value: "Tidak punya"),
      DropdownMenuItem(child: Text("1 unit"), value: "1 unit"),
      DropdownMenuItem(child: Text("2 unit"), value: "2 unit"),
      DropdownMenuItem(child: Text("3 unit"), value: "3 unit"),
      DropdownMenuItem(child: Text("4 unit"), value: "4 unit"),
      DropdownMenuItem(child: Text("> 4 unit"), value: "> 4 unit"),
    ];
    return menuItems3;
  }

  var selectedValue4 = "Tidak punya";
  List<DropdownMenuItem<String>> get dropdownItems4 {
    List<DropdownMenuItem<String>> menuItems4 = [
      DropdownMenuItem(child: Text("Tidak punya"), value: "Tidak punya"),
      DropdownMenuItem(child: Text("1 unit"), value: "1 unit"),
      DropdownMenuItem(child: Text("2 unit"), value: "2 unit"),
      DropdownMenuItem(child: Text("3 unit"), value: "3 unit"),
      DropdownMenuItem(child: Text("4 unit"), value: "4 unit"),
      DropdownMenuItem(child: Text("> 4 unit"), value: "> 4 unit"),
    ];
    return menuItems4;
  }

  var selectedValue5 = "Tidak punya";
  List<DropdownMenuItem<String>> get dropdownItems5 {
    List<DropdownMenuItem<String>> menuItems5 = [
      DropdownMenuItem(child: Text("Tidak punya"), value: "Tidak punya"),
      DropdownMenuItem(child: Text("1 unit"), value: "1 unit"),
      DropdownMenuItem(child: Text("2 unit"), value: "2 unit"),
      DropdownMenuItem(child: Text("3 unit"), value: "3 unit"),
      DropdownMenuItem(child: Text("4 unit"), value: "4 unit"),
      DropdownMenuItem(child: Text("> 4 unit"), value: "> 4 unit"),
    ];
    return menuItems5;
  }

  var selectedValue6 = "Tidak punya";
  List<DropdownMenuItem<String>> get dropdownItems6 {
    List<DropdownMenuItem<String>> menuItems6 = [
      DropdownMenuItem(child: Text("Tidak punya"), value: "Tidak punya"),
      DropdownMenuItem(child: Text("1 unit"), value: "1 unit"),
      DropdownMenuItem(child: Text("2 unit"), value: "2 unit"),
      DropdownMenuItem(child: Text("3 unit"), value: "3 unit"),
      DropdownMenuItem(child: Text("4 unit"), value: "4 unit"),
      DropdownMenuItem(child: Text("> 4 unit"), value: "> 4 unit"),
    ];
    return menuItems6;
  }

  var selectedValue7 = "Tidak punya";
  List<DropdownMenuItem<String>> get dropdownItems7 {
    List<DropdownMenuItem<String>> menuItems7 = [
      DropdownMenuItem(child: Text("Tidak punya"), value: "Tidak punya"),
      DropdownMenuItem(child: Text("1 unit"), value: "1 unit"),
      DropdownMenuItem(child: Text("2 unit"), value: "2 unit"),
      DropdownMenuItem(child: Text("3 unit"), value: "3 unit"),
      DropdownMenuItem(child: Text("4 unit"), value: "4 unit"),
      DropdownMenuItem(child: Text("> 4 unit"), value: "> 4 unit"),
    ];
    return menuItems7;
  }

  var selectedValue8 = "Tidak punya";
  List<DropdownMenuItem<String>> get dropdownItems8 {
    List<DropdownMenuItem<String>> menuItems8 = [
      DropdownMenuItem(child: Text("Tidak punya"), value: "Tidak punya"),
      DropdownMenuItem(child: Text("1 unit"), value: "1 unit"),
      DropdownMenuItem(child: Text("2 unit"), value: "2 unit"),
      DropdownMenuItem(child: Text("3 unit"), value: "3 unit"),
      DropdownMenuItem(child: Text("4 unit"), value: "4 unit"),
      DropdownMenuItem(child: Text("> 4 unit"), value: "> 4 unit"),
    ];
    return menuItems8;
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
      'ac': selectedValue1,
      'kulkas': selectedValue2,
      'mesin_cuci': selectedValue3,
      'televisi': selectedValue4,
      'komputer_laptop': selectedValue5,
      'mobil': selectedValue6,
      'motor': selectedValue7,
      'sepeda': selectedValue8,
      'nomor_kk': widget.nik,
    };
    // final userEncode = jsonEncode(data);
    var res = await Network().store(data, 'kepemilikan_aset');
    var body = jsonDecode(res.body);
    print(body);
    showAlertDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text("Kepemilikan Aset"),
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
                "Apakah memiliki AC (Air Conditioner) ? ",
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
                "Apakah memiliki Lemari es / Kulkas ? ",
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
                "Apakah memiliki Mesin Cuci ? ",
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
                "Apakah memiliki Televisi ? ",
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
                "Apakah memiliki Komputer / Laptop ? ",
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
                "Apakah memiliki Mobil ? ",
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
                "Apakah memiliki Sepeda Motor ? ",
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
                "Apakah memiliki Sepeda ? ",
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
