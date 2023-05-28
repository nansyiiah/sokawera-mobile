import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sokaweramobile/Network/api.dart';
import 'package:sokaweramobile/Pages/components/BottomNavBar.dart';

class KeteranganRespondenController extends StatefulWidget {
  final String name;
  final String inisial;
  const KeteranganRespondenController(
      {super.key, required this.name, required this.inisial});

  @override
  State<KeteranganRespondenController> createState() =>
      _KeteranganRespondenControllerState();
}

class _KeteranganRespondenControllerState
    extends State<KeteranganRespondenController> {
  String name = "";
  String inisial = "";
  var id_petugas;
  var rt, rw;
  var nomor_kk;
  var data;
  TextEditingController tanggalController = TextEditingController();
  TextEditingController namaPemeriksaController = TextEditingController();
  TextEditingController tanggalPeemeriksaController = TextEditingController();
  TextEditingController inisialPemeriksaController = TextEditingController();
  TextEditingController nik_kk_controller = TextEditingController();
  TextEditingController nama_kepala_keluarga_Controller =
      TextEditingController();
  TextEditingController jumlah_anggota_keluarga_sesuai_kk_Controller =
      TextEditingController();
  TextEditingController jumlah_anggota_keluarga_sesuai_kk_laki_Controller =
      TextEditingController();
  TextEditingController jumlah_anggota_keluarga_sesuai_kk_perempuan_Controller =
      TextEditingController();
  TextEditingController jumlah_anggota_keluarga_tinggal_dirumah_Controller =
      TextEditingController();
  TextEditingController
      jumlah_anggota_keluarga_tinggal_dirumah_laki_Controller =
      TextEditingController();
  TextEditingController
      jumlah_anggota_keluarga_tinggal_dirumah_perempuan_Controller =
      TextEditingController();
  TextEditingController
      jumlah_anggota_keluarga_tidak_tinggal_dirumah_Controller =
      TextEditingController();
  TextEditingController
      jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki_Controller =
      TextEditingController();
  TextEditingController
      jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan_Controller =
      TextEditingController();
  TextEditingController
      jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_Controller =
      TextEditingController();
  TextEditingController
      jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki_Controller =
      TextEditingController();
  TextEditingController
      jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan_Controller =
      TextEditingController();
  TextEditingController jumlah_orang_tinggal_dirumah_Controller =
      TextEditingController();
  TextEditingController jumlah_orang_tinggal_dirumah_laki_Controller =
      TextEditingController();
  TextEditingController jumlah_orang_tinggal_dirumah_perempuan_Controller =
      TextEditingController();
  TextEditingController jumlah_anggota_keluarga_menyusui_Controller =
      TextEditingController();
  TextEditingController jumlah_anggota_keluarga_jaminan_kesehatan_Controller =
      TextEditingController();
  TextEditingController
      jumlah_anggota_keluarga_jaminan_kesehatan_laki_Controller =
      TextEditingController();
  TextEditingController
      jumlah_anggota_keluarga_jaminan_kesehatan_perempuan_Controller =
      TextEditingController();
  TextEditingController
      jumlah_anggota_keluarga_sedang_mencari_pekerjaan_Controller =
      TextEditingController();
  TextEditingController
      jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki_Controller =
      TextEditingController();
  TextEditingController
      jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan_Controller =
      TextEditingController();
  TextEditingController jumlah_anggota_keluarga_sedang_tki_Controller =
      TextEditingController();
  TextEditingController jumlah_anggota_keluarga_sedang_tki_laki_Controller =
      TextEditingController();
  TextEditingController
      jumlah_anggota_keluarga_sedang_tki_perempuan_Controller =
      TextEditingController();
  TextEditingController jumlah_anggota_keluarga_ikatan_dinas_Controller =
      TextEditingController();
  TextEditingController jumlah_anggota_keluarga_ikatan_dinas_pns_Controller =
      TextEditingController();
  TextEditingController
      jumlah_anggota_keluarga_ikatan_dinas_tni_polri_Controller =
      TextEditingController();
  TextEditingController
      jumlah_anggota_keluarga_ikatan_dinas_pensiunan_Controller =
      TextEditingController();

  void initState() {
    _loadUserData();
    _loadKeteranganTempatData();
    _loadKeteranganRespondenData();
    super.initState();
  }

  _deleteLocalKeteranganRespondenData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('nama_kepala_keluarga');
    localStorage.remove('jumlah_anggota_keluarga_sesuai_kk');
    localStorage.remove('jumlah_anggota_keluarga_sesuai_kk_laki');
    localStorage.remove('jumlah_anggota_keluarga_sesuai_kk_perempuan');
    localStorage.remove('jumlah_anggota_keluarga_tinggal_dirumah');
    localStorage.remove('jumlah_anggota_keluarga_tinggal_dirumah_laki');
    localStorage.remove('jumlah_anggota_keluarga_tinggal_dirumah_perempuan');
    localStorage.remove('jumlah_anggota_keluarga_tidak_tinggal_dirumah');
    localStorage.remove('jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki');
    localStorage
        .remove('jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan');
    localStorage.remove('jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah');
    localStorage
        .remove('jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki');
    localStorage
        .remove('jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan');
    localStorage.remove('jumlah_orang_tinggal_dirumah');
    localStorage.remove('jumlah_orang_tinggal_dirumah_laki');
    localStorage.remove('jumlah_orang_tinggal_dirumah_perempuan');
    localStorage.remove('jumlah_anggota_keluarga_menyusui');
    localStorage.remove('jumlah_anggota_keluarga_jaminan_kesehatan');
    localStorage.remove('jumlah_anggota_keluarga_jaminan_kesehatan_laki');
    localStorage.remove('jumlah_anggota_keluarga_jaminan_kesehatan_perempuan');
    localStorage.remove('jumlah_anggota_keluarga_sedang_mencari_pekerjaan');
    localStorage
        .remove('jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki');
    localStorage
        .remove('jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan');
    localStorage.remove('jumlah_anggota_keluarga_sedang_tki');
    localStorage.remove('jumlah_anggota_keluarga_sedang_tki_laki');
    localStorage.remove('jumlah_anggota_keluarga_sedang_tki_perempuan');
    localStorage.remove('jumlah_anggota_keluarga_ikatan_dinas');
    localStorage.remove('jumlah_anggota_keluarga_ikatan_dinas_pns');
    localStorage.remove('jumlah_anggota_keluarga_ikatan_dinas_tni_polri');
    localStorage.remove('jumlah_anggota_keluarga_ikatan_dinas_pensiunan');
    localStorage.remove('keterangan_responden');
    Navigator.of(context, rootNavigator: true).pop();
    Get.to(BottomNavBar());
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('user');
    var petugas = localStorage.getInt('id_petugas');
    if (user != null) {
      setState(() {
        id_petugas = petugas;
      });
    } else {
      setState(() {
        name = "null";
      });
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
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

  _loadKeteranganTempatData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var data = localStorage.getString('keterangan_tempat');
    if (data != null) {
      setState(() {
        nomor_kk = localStorage.getInt('nomor_kk');
        rt = localStorage.getInt('rt');
        rw = localStorage.getInt('rw');
      });
    }
  }

  _loadKeteranganRespondenData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var data = localStorage.getString('keterangan_responden');
    if (data != null) {
      setState(() {
        var id_petugas = localStorage.getInt('id_petugas');
        var rt = localStorage.getInt('rt');
        var rw = localStorage.getInt('rw');
        var nik_kk = localStorage.getInt('nik_kk');
        var nama_kepala_keluarga =
            localStorage.getString('nama_kepala_keluarga');
        var jumlah_anggota_keluarga_sesuai_kk =
            localStorage.getInt('jumlah_anggota_keluarga_sesuai_kk');
        var jumlah_anggota_keluarga_sesuai_kk_laki =
            localStorage.getInt('jumlah_anggota_keluarga_sesuai_kk_laki');
        var jumlah_anggota_keluarga_sesuai_kk_perempuan =
            localStorage.getInt('jumlah_anggota_keluarga_sesuai_kk_perempuan');
        var jumlah_anggota_keluarga_tinggal_dirumah =
            localStorage.getInt('jumlah_anggota_keluarga_tinggal_dirumah');
        var jumlah_anggota_keluarga_tinggal_dirumah_laki =
            localStorage.getInt('jumlah_anggota_keluarga_tinggal_dirumah_laki');
        var jumlah_anggota_keluarga_tinggal_dirumah_perempuan = localStorage
            .getInt('jumlah_anggota_keluarga_tinggal_dirumah_perempuan');
        var jumlah_anggota_keluarga_tidak_tinggal_dirumah = localStorage
            .getInt('jumlah_anggota_keluarga_tidak_tinggal_dirumah');
        var jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki = localStorage
            .getInt('jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki');
        var jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan =
            localStorage.getInt(
                'jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan');
        var jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah = localStorage
            .getInt('jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah');
        var jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki = localStorage
            .getInt('jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki');
        var jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan =
            localStorage.getInt(
                'jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan');
        var jumlah_orang_tinggal_dirumah =
            localStorage.getInt('jumlah_orang_tinggal_dirumah');
        var jumlah_orang_tinggal_dirumah_laki =
            localStorage.getInt('jumlah_orang_tinggal_dirumah_laki');
        var jumlah_orang_tinggal_dirumah_perempuan =
            localStorage.getInt('jumlah_orang_tinggal_dirumah_perempuan');
        var jumlah_anggota_keluarga_menyusui =
            localStorage.getInt('jumlah_anggota_keluarga_menyusui');
        var jumlah_anggota_keluarga_jaminan_kesehatan =
            localStorage.getInt('jumlah_anggota_keluarga_jaminan_kesehatan');
        var jumlah_anggota_keluarga_jaminan_kesehatan_laki = localStorage
            .getInt('jumlah_anggota_keluarga_jaminan_kesehatan_laki');
        var jumlah_anggota_keluarga_jaminan_kesehatan_perempuan = localStorage
            .getInt('jumlah_anggota_keluarga_jaminan_kesehatan_perempuan');
        var jumlah_anggota_keluarga_sedang_mencari_pekerjaan = localStorage
            .getInt('jumlah_anggota_keluarga_sedang_mencari_pekerjaan');
        var jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki = localStorage
            .getInt('jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki');
        var jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan =
            localStorage.getInt(
                'jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan');
        var jumlah_anggota_keluarga_sedang_tki =
            localStorage.getInt('jumlah_anggota_keluarga_sedang_tki');
        var jumlah_anggota_keluarga_sedang_tki_laki =
            localStorage.getInt('jumlah_anggota_keluarga_sedang_tki_laki');
        var jumlah_anggota_keluarga_sedang_tki_perempuan =
            localStorage.getInt('jumlah_anggota_keluarga_sedang_tki_perempuan');
        var jumlah_anggota_keluarga_ikatan_dinas =
            localStorage.getInt('jumlah_anggota_keluarga_ikatan_dinas');
        var jumlah_anggota_keluarga_ikatan_dinas_pns =
            localStorage.getInt('jumlah_anggota_keluarga_ikatan_dinas_pns');
        var jumlah_anggota_keluarga_ikatan_dinas_tni_polri = localStorage
            .getInt('jumlah_anggota_keluarga_ikatan_dinas_tni_polri');
        var jumlah_anggota_keluarga_ikatan_dinas_pensiunan = localStorage
            .getInt('jumlah_anggota_keluarga_ikatan_dinas_pensiunan');
        nama_kepala_keluarga_Controller.text = "${nama_kepala_keluarga}";
        jumlah_anggota_keluarga_sesuai_kk_Controller.text =
            "${jumlah_anggota_keluarga_sesuai_kk}";
        jumlah_anggota_keluarga_sesuai_kk_laki_Controller.text =
            jumlah_anggota_keluarga_sesuai_kk_laki.toString();
        jumlah_anggota_keluarga_sesuai_kk_perempuan_Controller.text =
            "${jumlah_anggota_keluarga_sesuai_kk_perempuan}";
        jumlah_anggota_keluarga_tinggal_dirumah_Controller.text =
            "${jumlah_anggota_keluarga_tinggal_dirumah}";
        jumlah_anggota_keluarga_tinggal_dirumah_laki_Controller.text =
            "${jumlah_anggota_keluarga_tinggal_dirumah_laki}";
        jumlah_anggota_keluarga_tinggal_dirumah_perempuan_Controller.text =
            "${jumlah_anggota_keluarga_tinggal_dirumah_perempuan}";
        jumlah_anggota_keluarga_tidak_tinggal_dirumah_Controller.text =
            "${jumlah_anggota_keluarga_tidak_tinggal_dirumah}";
        jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki_Controller.text =
            "${jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki}";
        jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan_Controller
                .text =
            "${jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan}";
        jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_Controller.text =
            "${jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah}";
        jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki_Controller.text =
            "${jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki}";
        jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan_Controller
                .text =
            "${jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan}";
        jumlah_orang_tinggal_dirumah_Controller.text =
            "${jumlah_orang_tinggal_dirumah}";
        jumlah_orang_tinggal_dirumah_laki_Controller.text =
            "${jumlah_orang_tinggal_dirumah_laki}";
        jumlah_orang_tinggal_dirumah_perempuan_Controller.text =
            "${jumlah_orang_tinggal_dirumah_perempuan}";
        jumlah_anggota_keluarga_menyusui_Controller.text =
            "${jumlah_anggota_keluarga_menyusui}";
        jumlah_anggota_keluarga_jaminan_kesehatan_Controller.text =
            "${jumlah_anggota_keluarga_jaminan_kesehatan}";
        jumlah_anggota_keluarga_jaminan_kesehatan_laki_Controller.text =
            "${jumlah_anggota_keluarga_jaminan_kesehatan_laki}";
        jumlah_anggota_keluarga_jaminan_kesehatan_perempuan_Controller.text =
            "${jumlah_anggota_keluarga_jaminan_kesehatan_perempuan}";
        jumlah_anggota_keluarga_sedang_mencari_pekerjaan_Controller.text =
            "${jumlah_anggota_keluarga_sedang_mencari_pekerjaan}";
        jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki_Controller.text =
            "${jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki}";
        jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan_Controller
                .text =
            "${jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan}";
        jumlah_anggota_keluarga_sedang_tki_Controller.text =
            "${jumlah_anggota_keluarga_sedang_tki}";
        jumlah_anggota_keluarga_sedang_tki_laki_Controller.text =
            "${jumlah_anggota_keluarga_sedang_tki_laki}";
        jumlah_anggota_keluarga_sedang_tki_perempuan_Controller.text =
            "${jumlah_anggota_keluarga_sedang_tki_perempuan}";
        jumlah_anggota_keluarga_ikatan_dinas_Controller.text =
            "${jumlah_anggota_keluarga_ikatan_dinas}";
        jumlah_anggota_keluarga_ikatan_dinas_pns_Controller.text =
            "${jumlah_anggota_keluarga_ikatan_dinas_pns}";
        jumlah_anggota_keluarga_ikatan_dinas_tni_polri_Controller.text =
            "${jumlah_anggota_keluarga_ikatan_dinas_tni_polri}";
        jumlah_anggota_keluarga_ikatan_dinas_pensiunan_Controller.text =
            "${jumlah_anggota_keluarga_ikatan_dinas_pensiunan}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController namaController =
        TextEditingController(text: widget.name);
    name = widget.name;
    TextEditingController tandaTanganPencacahController =
        TextEditingController(text: widget.inisial);
    inisial = widget.inisial;
    _calculate() async {
      var total_keluarga_sesuai_kk =
          int.parse(jumlah_anggota_keluarga_sesuai_kk_laki_Controller.text) +
              int.parse(
                  jumlah_anggota_keluarga_sesuai_kk_perempuan_Controller.text);
      var total_keluarga_tinggal_dirumah = int.parse(
              jumlah_anggota_keluarga_tinggal_dirumah_laki_Controller.text) +
          int.parse(jumlah_anggota_keluarga_tinggal_dirumah_perempuan_Controller
              .text);
      var total_keluarga_tidak_tinggal_dirumah = int.parse(
              jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki_Controller
                  .text) +
          int.parse(
              jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan_Controller
                  .text);
      var total_orang_bukan_keluarga_tapi_tinggal_dirumah = int.parse(
              jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki_Controller
                  .text) +
          int.parse(
              jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan_Controller
                  .text);
      var total_orang_tinggal_dirumah = total_keluarga_tinggal_dirumah +
          total_orang_bukan_keluarga_tapi_tinggal_dirumah;

      // print(total_orang_tinggal_dirumah + int.parse(jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah.text));
      var total_laki_tinggal_dirumah = int.parse(
              jumlah_anggota_keluarga_tinggal_dirumah_laki_Controller.text) +
          int.parse(
              jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki_Controller
                  .text);
      var total_perempuan_tinggal_dirumah = int.parse(
              jumlah_anggota_keluarga_tinggal_dirumah_perempuan_Controller
                  .text) +
          int.parse(
              jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan_Controller
                  .text);
      var total_anggota_keluarga_memiliki_jamkes = int.parse(
              jumlah_anggota_keluarga_jaminan_kesehatan_laki_Controller.text) +
          int.parse(
              jumlah_anggota_keluarga_jaminan_kesehatan_perempuan_Controller
                  .text);
      var total_anggota_keluarga_mencari_kerja = int.parse(
              jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki_Controller
                  .text) +
          int.parse(
              jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan_Controller
                  .text);
      var total_anggota_keluarga_tki =
          int.parse(jumlah_anggota_keluarga_sedang_tki_laki_Controller.text) +
              int.parse(
                  jumlah_anggota_keluarga_sedang_tki_perempuan_Controller.text);
      var total_anggota_keluarga_pns_polri = int.parse(
              jumlah_anggota_keluarga_ikatan_dinas_pensiunan_Controller.text) +
          int.parse(
              jumlah_anggota_keluarga_ikatan_dinas_tni_polri_Controller.text) +
          int.parse(
              jumlah_anggota_keluarga_ikatan_dinas_pensiunan_Controller.text);
      var data = {
        'id_petugas': id_petugas,
        'rt': rt,
        'rw': rw,
        'nik_kk': nomor_kk,
        'nama_kepala_keluarga': nama_kepala_keluarga_Controller.text,
        'jumlah_anggota_keluarga_sesuai_kk': total_keluarga_sesuai_kk,
        'jumlah_anggota_keluarga_sesuai_kk_laki':
            jumlah_anggota_keluarga_sesuai_kk_laki_Controller.text,
        'jumlah_anggota_keluarga_sesuai_kk_perempuan':
            jumlah_anggota_keluarga_sesuai_kk_perempuan_Controller.text,
        'jumlah_anggota_keluarga_tinggal_dirumah':
            total_keluarga_tinggal_dirumah,
        'jumlah_anggota_keluarga_tinggal_dirumah_laki':
            jumlah_anggota_keluarga_tinggal_dirumah_laki_Controller.text,
        'jumlah_anggota_keluarga_tinggal_dirumah_perempuan':
            jumlah_anggota_keluarga_tinggal_dirumah_perempuan_Controller.text,
        'jumlah_anggota_keluarga_tidak_tinggal_dirumah':
            total_keluarga_tidak_tinggal_dirumah,
        'jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki':
            jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki_Controller.text,
        'jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan':
            jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan_Controller
                .text,
        'jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah':
            total_orang_bukan_keluarga_tapi_tinggal_dirumah,
        'jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki':
            jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki_Controller
                .text,
        'jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan':
            jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan_Controller
                .text,
        'jumlah_orang_tinggal_dirumah': total_orang_tinggal_dirumah,
        'jumlah_orang_tinggal_dirumah_laki': total_laki_tinggal_dirumah,
        'jumlah_orang_tinggal_dirumah_perempuan':
            total_perempuan_tinggal_dirumah,
        'jumlah_anggota_keluarga_menyusui':
            jumlah_anggota_keluarga_menyusui_Controller.text,
        'jumlah_anggota_keluarga_jaminan_kesehatan':
            total_anggota_keluarga_memiliki_jamkes,
        'jumlah_anggota_keluarga_jaminan_kesehatan_laki':
            jumlah_anggota_keluarga_jaminan_kesehatan_laki_Controller.text,
        'jumlah_anggota_keluarga_jaminan_kesehatan_perempuan':
            jumlah_anggota_keluarga_jaminan_kesehatan_perempuan_Controller.text,
        'jumlah_anggota_keluarga_sedang_mencari_pekerjaan':
            total_anggota_keluarga_mencari_kerja,
        'jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki':
            jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki_Controller
                .text,
        'jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan':
            jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan_Controller
                .text,
        'jumlah_anggota_keluarga_sedang_tki': total_anggota_keluarga_tki,
        'jumlah_anggota_keluarga_sedang_tki_laki':
            jumlah_anggota_keluarga_sedang_tki_laki_Controller.text,
        'jumlah_anggota_keluarga_sedang_tki_perempuan':
            jumlah_anggota_keluarga_sedang_tki_perempuan_Controller.text,
        'jumlah_anggota_keluarga_ikatan_dinas':
            total_anggota_keluarga_pns_polri,
        'jumlah_anggota_keluarga_ikatan_dinas_pns':
            jumlah_anggota_keluarga_ikatan_dinas_pns_Controller.text,
        'jumlah_anggota_keluarga_ikatan_dinas_tni_polri':
            jumlah_anggota_keluarga_ikatan_dinas_tni_polri_Controller.text,
        'jumlah_anggota_keluarga_ikatan_dinas_pensiunan':
            jumlah_anggota_keluarga_ikatan_dinas_pensiunan_Controller.text,
      };

      var res = await Network().store(data, 'keterangan_responden');
      var body = json.decode(res.body);
      if (body['status'] == 200) {
        print("success insert data");
      } else {
        print(body);
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
          _deleteLocalKeteranganRespondenData();
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

    _savedDataToLocal() async {
      var total_keluarga_sesuai_kk =
          int.parse(jumlah_anggota_keluarga_sesuai_kk_laki_Controller.text) +
              int.parse(
                  jumlah_anggota_keluarga_sesuai_kk_perempuan_Controller.text);
      var total_keluarga_tinggal_dirumah = int.parse(
              jumlah_anggota_keluarga_tinggal_dirumah_laki_Controller.text) +
          int.parse(jumlah_anggota_keluarga_tinggal_dirumah_perempuan_Controller
              .text);
      var total_keluarga_tidak_tinggal_dirumah = int.parse(
              jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki_Controller
                  .text) +
          int.parse(
              jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan_Controller
                  .text);
      var total_orang_bukan_keluarga_tapi_tinggal_dirumah = int.parse(
              jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki_Controller
                  .text) +
          int.parse(
              jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan_Controller
                  .text);
      var total_orang_tinggal_dirumah = total_keluarga_tinggal_dirumah +
          total_orang_bukan_keluarga_tapi_tinggal_dirumah;
      var total_laki_tinggal_dirumah = int.parse(
              jumlah_anggota_keluarga_tinggal_dirumah_laki_Controller.text) +
          int.parse(
              jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki_Controller
                  .text);
      var total_perempuan_tinggal_dirumah = int.parse(
              jumlah_anggota_keluarga_tinggal_dirumah_perempuan_Controller
                  .text) +
          int.parse(
              jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan_Controller
                  .text);
      var total_anggota_keluarga_memiliki_jamkes = int.parse(
              jumlah_anggota_keluarga_jaminan_kesehatan_laki_Controller.text) +
          int.parse(
              jumlah_anggota_keluarga_jaminan_kesehatan_perempuan_Controller
                  .text);
      var total_anggota_keluarga_mencari_kerja = int.parse(
              jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki_Controller
                  .text) +
          int.parse(
              jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan_Controller
                  .text);
      var total_anggota_keluarga_tki =
          int.parse(jumlah_anggota_keluarga_sedang_tki_laki_Controller.text) +
              int.parse(
                  jumlah_anggota_keluarga_sedang_tki_perempuan_Controller.text);
      var total_anggota_keluarga_pns_polri = int.parse(
              jumlah_anggota_keluarga_ikatan_dinas_pensiunan_Controller.text) +
          int.parse(
              jumlah_anggota_keluarga_ikatan_dinas_tni_polri_Controller.text) +
          int.parse(
              jumlah_anggota_keluarga_ikatan_dinas_pensiunan_Controller.text);
      var total_keluarga_full = total_keluarga_sesuai_kk +
          total_orang_bukan_keluarga_tapi_tinggal_dirumah;
      var data = {
        'id_petugas': id_petugas,
        'rt': rt,
        'rw': rw,
        'nik_kk': nomor_kk,
        'nama_kepala_keluarga': nama_kepala_keluarga_Controller.text,
        'jumlah_anggota_keluarga_sesuai_kk': total_keluarga_sesuai_kk,
        'jumlah_anggota_keluarga_sesuai_kk_laki':
            jumlah_anggota_keluarga_sesuai_kk_laki_Controller.text,
        'jumlah_anggota_keluarga_sesuai_kk_perempuan':
            jumlah_anggota_keluarga_sesuai_kk_perempuan_Controller.text,
        'jumlah_anggota_keluarga_tinggal_dirumah':
            total_keluarga_tinggal_dirumah,
        'jumlah_anggota_keluarga_tinggal_dirumah_laki':
            jumlah_anggota_keluarga_tinggal_dirumah_laki_Controller.text,
        'jumlah_anggota_keluarga_tinggal_dirumah_perempuan':
            jumlah_anggota_keluarga_tinggal_dirumah_perempuan_Controller.text,
        'jumlah_anggota_keluarga_tidak_tinggal_dirumah':
            total_keluarga_tidak_tinggal_dirumah,
        'jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki':
            jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki_Controller.text,
        'jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan':
            jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan_Controller
                .text,
        'jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah':
            total_orang_bukan_keluarga_tapi_tinggal_dirumah,
        'jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki':
            jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki_Controller
                .text,
        'jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan':
            jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan_Controller
                .text,
        'jumlah_orang_tinggal_dirumah': total_orang_tinggal_dirumah,
        'jumlah_orang_tinggal_dirumah_laki': total_laki_tinggal_dirumah,
        'jumlah_orang_tinggal_dirumah_perempuan':
            total_perempuan_tinggal_dirumah,
        'jumlah_anggota_keluarga_menyusui':
            jumlah_anggota_keluarga_menyusui_Controller.text,
        'jumlah_anggota_keluarga_jaminan_kesehatan':
            total_anggota_keluarga_memiliki_jamkes,
        'jumlah_anggota_keluarga_jaminan_kesehatan_laki':
            jumlah_anggota_keluarga_jaminan_kesehatan_laki_Controller.text,
        'jumlah_anggota_keluarga_jaminan_kesehatan_perempuan':
            jumlah_anggota_keluarga_jaminan_kesehatan_perempuan_Controller.text,
        'jumlah_anggota_keluarga_sedang_mencari_pekerjaan':
            total_anggota_keluarga_mencari_kerja,
        'jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki':
            jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki_Controller
                .text,
        'jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan':
            jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan_Controller
                .text,
        'jumlah_anggota_keluarga_sedang_tki': total_anggota_keluarga_tki,
        'jumlah_anggota_keluarga_sedang_tki_laki':
            jumlah_anggota_keluarga_sedang_tki_laki_Controller.text,
        'jumlah_anggota_keluarga_sedang_tki_perempuan':
            jumlah_anggota_keluarga_sedang_tki_perempuan_Controller.text,
        'jumlah_anggota_keluarga_ikatan_dinas':
            total_anggota_keluarga_pns_polri,
        'jumlah_anggota_keluarga_ikatan_dinas_pns':
            jumlah_anggota_keluarga_ikatan_dinas_pns_Controller.text,
        'jumlah_anggota_keluarga_ikatan_dinas_tni_polri':
            jumlah_anggota_keluarga_ikatan_dinas_tni_polri_Controller.text,
        'jumlah_anggota_keluarga_ikatan_dinas_pensiunan':
            jumlah_anggota_keluarga_ikatan_dinas_pensiunan_Controller.text,
      };

      List data_sebelum_append = [];
      data_sebelum_append.add(data);
      final dataEncode = jsonEncode(data);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('keterangan_responden', dataEncode);
      localStorage.setInt('id_petugas', id_petugas);
      localStorage.setInt('rt', rt);
      localStorage.setInt('rw', rw);
      localStorage.setInt('nik_kk', nomor_kk);
      localStorage.setInt('total_keluarga_full', total_keluarga_full);
      localStorage.setString(
          'nama_kepala_keluarga', nama_kepala_keluarga_Controller.text);
      localStorage.setInt(
          'jumlah_anggota_keluarga_sesuai_kk', total_keluarga_sesuai_kk);
      localStorage.setInt('jumlah_anggota_keluarga_sesuai_kk_laki',
          int.parse(jumlah_anggota_keluarga_sesuai_kk_laki_Controller.text));
      localStorage.setInt(
          'jumlah_anggota_keluarga_sesuai_kk_perempuan',
          int.parse(
              jumlah_anggota_keluarga_sesuai_kk_perempuan_Controller.text));
      localStorage.setInt('jumlah_anggota_keluarga_tinggal_dirumah',
          total_keluarga_tinggal_dirumah);
      localStorage.setInt(
          'jumlah_anggota_keluarga_tinggal_dirumah_laki',
          int.parse(
              jumlah_anggota_keluarga_tinggal_dirumah_laki_Controller.text));
      localStorage.setInt(
          'jumlah_anggota_keluarga_tinggal_dirumah_perempuan',
          int.parse(jumlah_anggota_keluarga_tinggal_dirumah_perempuan_Controller
              .text));
      localStorage.setInt('jumlah_anggota_keluarga_tidak_tinggal_dirumah',
          total_keluarga_tidak_tinggal_dirumah);
      localStorage.setInt(
          'jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki',
          int.parse(
              jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki_Controller
                  .text));
      localStorage.setInt(
          'jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan',
          int.parse(
              jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan_Controller
                  .text));
      localStorage.setInt('jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah',
          total_orang_bukan_keluarga_tapi_tinggal_dirumah);
      localStorage.setInt(
          'jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki',
          int.parse(
              jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki_Controller
                  .text));
      localStorage.setInt(
          'jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan',
          int.parse(
              jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan_Controller
                  .text));
      localStorage.setInt(
          'jumlah_orang_tinggal_dirumah', total_orang_tinggal_dirumah);
      localStorage.setInt(
          'jumlah_orang_tinggal_dirumah_laki', total_laki_tinggal_dirumah);
      localStorage.setInt('jumlah_orang_tinggal_dirumah_perempuan',
          total_perempuan_tinggal_dirumah);
      localStorage.setInt('jumlah_anggota_keluarga_menyusui',
          int.parse(jumlah_anggota_keluarga_menyusui_Controller.text));
      localStorage.setInt('jumlah_anggota_keluarga_jaminan_kesehatan',
          total_anggota_keluarga_memiliki_jamkes);
      localStorage.setInt(
          'jumlah_anggota_keluarga_jaminan_kesehatan_laki',
          int.parse(
              jumlah_anggota_keluarga_jaminan_kesehatan_laki_Controller.text));
      localStorage.setInt(
          'jumlah_anggota_keluarga_jaminan_kesehatan_perempuan',
          int.parse(
              jumlah_anggota_keluarga_jaminan_kesehatan_perempuan_Controller
                  .text));
      localStorage.setInt('jumlah_anggota_keluarga_sedang_mencari_pekerjaan',
          total_anggota_keluarga_mencari_kerja);
      localStorage.setInt(
          'jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki',
          int.parse(
              jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki_Controller
                  .text));
      localStorage.setInt(
          'jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan',
          int.parse(
              jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan_Controller
                  .text));
      localStorage.setInt(
          'jumlah_anggota_keluarga_sedang_tki', total_anggota_keluarga_tki);
      localStorage.setInt('jumlah_anggota_keluarga_sedang_tki_laki',
          int.parse(jumlah_anggota_keluarga_sedang_tki_laki_Controller.text));
      localStorage.setInt(
          'jumlah_anggota_keluarga_sedang_tki_perempuan',
          int.parse(
              jumlah_anggota_keluarga_sedang_tki_perempuan_Controller.text));
      localStorage.setInt('jumlah_anggota_keluarga_ikatan_dinas',
          total_anggota_keluarga_pns_polri);
      localStorage.setInt('jumlah_anggota_keluarga_ikatan_dinas_pns',
          int.parse(jumlah_anggota_keluarga_ikatan_dinas_pns_Controller.text));
      localStorage.setInt(
          'jumlah_anggota_keluarga_ikatan_dinas_tni_polri',
          int.parse(
              jumlah_anggota_keluarga_ikatan_dinas_tni_polri_Controller.text));
      localStorage.setInt(
          'jumlah_anggota_keluarga_ikatan_dinas_pensiunan',
          int.parse(
              jumlah_anggota_keluarga_ikatan_dinas_pensiunan_Controller.text));

      if (localStorage.getString('keterangan_responden') != null) {
        showAlertDialog(context);
      }
    }

    Size size = MediaQuery.of(context).size;
    _loadKeteranganTempatData();
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text("Keterangan Responden"),
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
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: nama_kepala_keluarga_Controller,
                decoration: InputDecoration(
                  labelText: 'Nama Kepala Keluarga (KK)',
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
              child: Text(
                "Jumlah anggota keluarga :",
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
                      controller:
                          jumlah_anggota_keluarga_sesuai_kk_laki_Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Laki Laki',
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
                      controller:
                          jumlah_anggota_keluarga_sesuai_kk_perempuan_Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Perempuan',
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
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Jumlah anggota keluarga yang tinggal di rumah ini (sesuai KK):",
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
                      controller:
                          jumlah_anggota_keluarga_tinggal_dirumah_laki_Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Laki Laki',
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
                      controller:
                          jumlah_anggota_keluarga_tinggal_dirumah_perempuan_Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Perempuan',
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
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Jumlah anggota keluarga yang tidak tinggal di rumah ini (sesuai KK):",
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
                      controller:
                          jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki_Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Laki Laki',
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
                      controller:
                          jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan_Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Perempuan',
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
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Jumlah orang yang tidak dalam KK namun tinggal dirumah ini:",
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
                      controller:
                          jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki_Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Laki Laki',
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
                      controller:
                          jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan_Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Perempuan',
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
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Jumlah anggota keluarga yang sedang menyusui :",
                style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: jumlah_anggota_keluarga_menyusui_Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Jumlah anggota keluarga yang sedang menyusui',
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
            ), //
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Jumlah anggota keluarga memiliki jaminan kesehatan :",
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
                      controller:
                          jumlah_anggota_keluarga_jaminan_kesehatan_laki_Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Laki Laki',
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
                      controller:
                          jumlah_anggota_keluarga_jaminan_kesehatan_perempuan_Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Perempuan',
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
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Jumlah anggota keluarga sedang mencari pekerjaan / menyiapkan usaha :",
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
                      controller:
                          jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki_Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Laki Laki',
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
                      controller:
                          jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan_Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Perempuan',
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
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Jumlah anggota keluarga sedang menjadi TKI di luar negeri :",
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
                      controller:
                          jumlah_anggota_keluarga_sedang_tki_laki_Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Laki Laki',
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
                      controller:
                          jumlah_anggota_keluarga_sedang_tki_perempuan_Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Perempuan',
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
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Jumlah anggota keluarga menjadi PNS/TNI/POLRI/Pensiunan :",
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
                        const EdgeInsets.only(left: 10, right: 10, top: 24),
                    child: TextFormField(
                      controller:
                          jumlah_anggota_keluarga_ikatan_dinas_pns_Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'PNS',
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
                        const EdgeInsets.only(left: 10, right: 10, top: 24),
                    child: TextFormField(
                      controller:
                          jumlah_anggota_keluarga_ikatan_dinas_tni_polri_Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'TNI/POLRI',
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
                        const EdgeInsets.only(left: 10, right: 10, top: 24),
                    child: TextFormField(
                      controller:
                          jumlah_anggota_keluarga_ikatan_dinas_pensiunan_Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Pensiunan',
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
