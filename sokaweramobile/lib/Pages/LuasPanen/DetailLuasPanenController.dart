import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sokaweramobile/Pages/DetailPages/DetailScreen.dart';
import 'package:sokaweramobile/Pages/components/BottomNavBar.dart';

class DetailLuasPanenController extends StatefulWidget {
  final String jenis_lahan;
  const DetailLuasPanenController({super.key, required this.jenis_lahan});

  @override
  State<DetailLuasPanenController> createState() =>
      _DetailLuasPanenControllerState();
}

class _DetailLuasPanenControllerState extends State<DetailLuasPanenController> {
  var jenis_lahan_this_file, nomor_kk;

  _getNomorKK() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('keterangan_tempat');
    var parsing = jsonDecode(user!);
    if (user != null) {
      setState(() {
        nomor_kk = parsing['nomor_kk'];
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

  var lahan = [];

  TextEditingController frekuensiPanenController = TextEditingController();
  TextEditingController luasPanenController = TextEditingController();
  TextEditingController produksiController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _getNomorKK();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      jenis_lahan_this_file = widget.jenis_lahan;
    });
    Size size = MediaQuery.of(context).size;
    TextEditingController jenisLahanController =
        TextEditingController(text: jenis_lahan_this_file);

    _savedDataToLocal() async {
      List data_sebelum_append = [];
      var data = {
        'jenis_tanaman': "${jenisLahanController.text}",
        'frekuensi_panen': "${frekuensiPanenController.text}",
        'luas_panen': "${luasPanenController.text}",
        'produksi': "${produksiController.text}",
        'nomor_kk': "${nomor_kk}",
      };
      data_sebelum_append.add(data);
      final userEncode = jsonEncode(data);
      lahan.add(userEncode);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString("luas_panen", userEncode);
      if (localStorage.getString("luas_panen") != null) {
        var currentList = localStorage.getStringList("detail_luas_panen") ?? [];
        currentList.add(userEncode);
        await localStorage.setStringList("detail_luas_panen", currentList);
        showAlertDialog(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text("${widget.jenis_lahan}"),
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
                controller: jenisLahanController,
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Jenis Lahan',
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
                controller: frekuensiPanenController,
                enabled: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Frekuensi Panen',
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
                controller: luasPanenController,
                enabled: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Luas Panen (Meter Persegi)',
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
                controller: produksiController,
                enabled: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Produksi (Kg)',
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
