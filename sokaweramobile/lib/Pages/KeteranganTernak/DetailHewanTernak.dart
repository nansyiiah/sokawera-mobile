import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sokaweramobile/Pages/components/BottomNavBar.dart';

class DetailHewanTernak extends StatefulWidget {
  final String nama;
  const DetailHewanTernak({super.key, required this.nama});

  @override
  State<DetailHewanTernak> createState() => _DetailHewanTernakState();
}

class _DetailHewanTernakState extends State<DetailHewanTernak> {
  var nama_hewan,
      jmlTernakDimiliki,
      jmlTernakPihakLain,
      jmlTernakBerada,
      jmlTotalTernak;
  var nik_kk;

  List hewan_ternak = [];

  TextEditingController hewanJantanDimilikiController = TextEditingController();
  TextEditingController hewanBetinaDimilikiController = TextEditingController();
  TextEditingController hewanJantanBerasalController = TextEditingController();
  TextEditingController hewanBetinaBerasalController = TextEditingController();
  TextEditingController hewanJantanBeradaController = TextEditingController();
  TextEditingController hewanBetinaBeradaController = TextEditingController();
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

  _calculate() async {
    jmlTernakDimiliki = int.parse(hewanJantanDimilikiController.text) +
        int.parse(hewanBetinaDimilikiController.text);
    jmlTernakPihakLain = int.parse(hewanJantanBerasalController.text) +
        int.parse(hewanBetinaBerasalController.text);
    jmlTernakBerada = int.parse(hewanJantanBeradaController.text) +
        int.parse(hewanBetinaBeradaController.text);
    jmlTotalTernak = jmlTernakDimiliki + jmlTernakPihakLain - jmlTernakBerada;
    if (jmlTotalTernak < 0 || jmlTotalTernak == null) {
      jmlTotalTernak = 0;
    }
  }

  _savedDataToLocal() async {
    List data_sebelum_append = [];
    _calculate();
    var data = {
      'jenis_ternak': nama_hewan,
      'jumlah_ternak_dimiliki': jmlTernakDimiliki,
      'jumlah_ternak_dimiliki_jantan': hewanJantanDimilikiController.text,
      'jumlah_ternak_dimiliki_betina': hewanBetinaDimilikiController.text,
      'jumlah_ternak_pihak_lain': jmlTernakPihakLain,
      'jumlah_ternak_pihak_lain_jantan': hewanJantanBerasalController.text,
      'jumlah_ternak_pihak_lain_betina': hewanBetinaBerasalController.text,
      'jumlah_ternak_berada_dipihak_lain': jmlTernakBerada,
      'jumlah_ternak_berada_dipihak_lain_jantan':
          hewanJantanBeradaController.text,
      'jumlah_ternak_berada_dipihak_lain_betina':
          hewanJantanBeradaController.text,
      'jumlah_ternak_dikuasai': jmlTotalTernak,
      'nomor_kk': nik_kk,
    };
    data_sebelum_append.add(data);
    final userEncode = jsonEncode(data);
    hewan_ternak.add(userEncode);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('penguasaan_hewan_ternak', userEncode);
    if (localStorage.getString('penguasaan_hewan_ternak') != null) {
      var currentList = localStorage.getStringList('detail_hewan_ternak') ?? [];
      currentList.add(userEncode);
      await localStorage.setStringList('detail_hewan_ternak', currentList);
      showAlertDialog(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _getNomorKKLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      nama_hewan = widget.nama;
    });

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text("Ternak ${widget.nama}"),
        backgroundColor: Color(0xFF68b7d8),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                "Penguasaan Hewan Ternak (${widget.nama}) ",
                style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              child: Text(
                "Jumlah ternak yang dimiliki ",
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
                      controller: hewanJantanDimilikiController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Jantan',
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
                      controller: hewanBetinaDimilikiController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Betina',
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
              child: Text(
                "Jumlah ternak berasal dari pihak lain",
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
                      controller: hewanJantanBerasalController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Jantan',
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
                      controller: hewanBetinaBerasalController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Betina',
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
              child: Text(
                "Jumlah ternak berada di pihak lain",
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
                      controller: hewanJantanBeradaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Jantan',
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
                      controller: hewanBetinaBeradaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Betina',
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
