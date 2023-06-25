import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sokaweramobile/Network/api.dart';
import 'package:sokaweramobile/Pages/components/BottomNavBar.dart';

class DetailPerumahanData extends StatefulWidget {
  final List jsonData;
  const DetailPerumahanData({super.key, required this.jsonData});

  @override
  State<DetailPerumahanData> createState() => _DetailPerumahanDataState();
}

class _DetailPerumahanDataState extends State<DetailPerumahanData> {
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
      title: Text("Success Edit Data !"),
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

  showErrorDialog(BuildContext context) {
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
      title: Text("Error"),
      content: Text(
        "Gagal update data !",
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

  var nomorkk;
  TextEditingController status_penggunaan_bangunan_tempat_tinggal =
      TextEditingController();
  TextEditingController status_lahan_bangunan_tempat_tinggal =
      TextEditingController();
  TextEditingController jumlah_kk_tinggal_dibangunan = TextEditingController();
  TextEditingController luas_lantai = TextEditingController();
  TextEditingController jenis_lantai_terluas = TextEditingController();
  TextEditingController jenis_dinding_terluas = TextEditingController();
  TextEditingController jumlah_ruangan_seluruhnya = TextEditingController();
  TextEditingController sumber_air_minum = TextEditingController();
  TextEditingController sumber_penerangan_utama = TextEditingController();
  TextEditingController daya_terpasang = TextEditingController();
  TextEditingController bahan_bakar_utama_memasak = TextEditingController();
  TextEditingController penggunaan_fasilitas_tempat_bab =
      TextEditingController();
  TextEditingController jenis_kloset = TextEditingController();
  TextEditingController tempat_pembuangan_akhir_tinja = TextEditingController();
  TextEditingController jumlah_fasilitas_cuci_tangan = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    status_penggunaan_bangunan_tempat_tinggal.text =
        widget.jsonData[0]['status_penggunaan_bangunan_tempat_tinggal'];
    status_lahan_bangunan_tempat_tinggal.text =
        widget.jsonData[0]['status_lahan_bangunan_tempat_tinggal'];
    jumlah_kk_tinggal_dibangunan.text =
        widget.jsonData[0]['jumlah_kk_tinggal_dibangunan'];
    luas_lantai.text = widget.jsonData[0]['luas_lantai'];
    jenis_lantai_terluas.text = widget.jsonData[0]['jenis_lantai_terluas'];
    jenis_dinding_terluas.text = widget.jsonData[0]['jenis_dinding_terluas'];
    jumlah_ruangan_seluruhnya.text =
        widget.jsonData[0]['jumlah_ruangan_seluruhnya'];
    sumber_air_minum.text = widget.jsonData[0]['sumber_air_minum'];
    sumber_penerangan_utama.text =
        widget.jsonData[0]['sumber_penerangan_utama'];
    daya_terpasang.text = widget.jsonData[0]['daya_terpasang'];
    bahan_bakar_utama_memasak.text =
        widget.jsonData[0]['bahan_bakar_utama_memasak'];
    penggunaan_fasilitas_tempat_bab.text =
        widget.jsonData[0]['penggunaan_fasilitas_tempat_bab'];
    jenis_kloset.text = widget.jsonData[0]['jenis_kloset'];
    tempat_pembuangan_akhir_tinja.text =
        widget.jsonData[0]['tempat_pembuangan_akhir_tinja'];
    jumlah_fasilitas_cuci_tangan.text =
        widget.jsonData[0]['jumlah_fasilitas_cuci_tangan'];
    nomorkk = widget.jsonData[0]['nomor_kk'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _savedData(nik) async {
      var data = {
        "status_penggunaan_bangunan_tempat_tinggal":
            status_penggunaan_bangunan_tempat_tinggal.text,
        "status_lahan_bangunan_tempat_tinggal":
            status_lahan_bangunan_tempat_tinggal.text,
        "jumlah_kk_tinggal_dibangunan": jumlah_kk_tinggal_dibangunan.text,
        "luas_lantai": luas_lantai.text,
        "jenis_lantai_terluas": jenis_lantai_terluas.text,
        "jenis_dinding_terluas": jenis_dinding_terluas.text,
        "jumlah_ruangan_seluruhnya": jumlah_ruangan_seluruhnya.text,
        "sumber_air_minum": sumber_air_minum.text,
        "sumber_penerangan_utama": sumber_penerangan_utama.text,
        "daya_terpasang": daya_terpasang.text,
        "bahan_bakar_utama_memasak": bahan_bakar_utama_memasak.text,
        "penggunaan_fasilitas_tempat_bab": penggunaan_fasilitas_tempat_bab.text,
        "jenis_kloset": jenis_kloset.text,
        "tempat_pembuangan_akhir_tinja": tempat_pembuangan_akhir_tinja.text,
        "jumlah_fasilitas_cuci_tangan": jumlah_fasilitas_cuci_tangan.text,
        "nomor_kk": nomorkk,
      };
      var res = await Network().store(data, 'keterangan_perumahan/edit/${nik}');
      var body = jsonDecode(res.body);
      if (body["code"] == 200) {
        showAlertDialog(context);
      } else {
        showErrorDialog(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Detail",
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: status_penggunaan_bangunan_tempat_tinggal,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Status Penggunaan Bangunan Tempat Tinggal',
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
                controller: status_lahan_bangunan_tempat_tinggal,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Status Lahan Bangunan Tempat Tinggal',
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
                controller: jumlah_kk_tinggal_dibangunan,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Jumlah Keluarga Tinggal dibangunan ini',
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
                controller: luas_lantai,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Luas Lantai',
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
                controller: jenis_lantai_terluas,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Jenis Lantai Terluas',
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
                controller: jenis_dinding_terluas,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Jenis Dinding Terluas',
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
                controller: jumlah_ruangan_seluruhnya,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Jumlah Ruangan Seluruhnya',
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
                controller: sumber_air_minum,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Sumber Air Minum',
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
                controller: sumber_penerangan_utama,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Sumber Penerangan Utama',
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
                controller: daya_terpasang,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Daya Terpasang',
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
                controller: bahan_bakar_utama_memasak,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Bahan Bakar Memasak',
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
                controller: penggunaan_fasilitas_tempat_bab,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Penggunaan Fasilitas Tempat BAB',
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
                controller: jenis_kloset,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Jenis Kloset',
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
                controller: tempat_pembuangan_akhir_tinja,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Tempat Pembuangan Akhir Tinja',
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
                controller: jumlah_fasilitas_cuci_tangan,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Jumlah Fasilitas Cuci Tangan',
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
                onTap: () async {
                  // await _postAllData();
                  await _savedData(widget.jsonData[0]['nomor_kk']);
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 24, right: 24, top: 40),
                  padding:
                      EdgeInsets.only(left: 24, right: 24, top: 14, bottom: 14),
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
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

enum MenuItem {
  item1,
  item2,
  item3,
  item4,
}
