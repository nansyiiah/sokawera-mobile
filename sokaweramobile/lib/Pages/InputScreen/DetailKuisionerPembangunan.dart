import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sokaweramobile/Pages/components/BottomNavBar.dart';

class DetailKuisionerPembangunan extends StatefulWidget {
  const DetailKuisionerPembangunan({super.key});

  @override
  State<DetailKuisionerPembangunan> createState() =>
      _DetailKuisionerPembangunanState();
}

class _DetailKuisionerPembangunanState
    extends State<DetailKuisionerPembangunan> {
  var nik_kk;
  bool _isKejahatan = false;
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

  var selectedValue1 = "Sangat Mengetahui";
  List<DropdownMenuItem<String>> get dropdownItems1 {
    List<DropdownMenuItem<String>> menuItems1 = [
      DropdownMenuItem(
          child: Text("Sangat Mengetahui"), value: "Sangat Mengetahui"),
      DropdownMenuItem(
          child: Text("Cukup Mengetahui"), value: "Cukup Mengetahui"),
      DropdownMenuItem(
          child: Text("Sedikit Mengetahui"), value: "Sedikit Mengetahui"),
      DropdownMenuItem(
          child: Text("Tidak Mengetahui"), value: "Tidak Mengetahui"),
    ];
    return menuItems1;
  }

  var selectedValue2 = "Sangat Mengetahui";
  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems2 = [
      DropdownMenuItem(
          child: Text("Sangat Mengetahui"), value: "Sangat Mengetahui"),
      DropdownMenuItem(
          child: Text("Cukup Mengetahui"), value: "Cukup Mengetahui"),
      DropdownMenuItem(
          child: Text("Sedikit Mengetahui"), value: "Sedikit Mengetahui"),
      DropdownMenuItem(
          child: Text("Tidak Mengetahui"), value: "Tidak Mengetahui"),
    ];
    return menuItems2;
  }

  var selectedValue3 = "Sangat Mengetahui";
  List<DropdownMenuItem<String>> get dropdownItems3 {
    List<DropdownMenuItem<String>> menuItems3 = [
      DropdownMenuItem(
          child: Text("Sangat Mengetahui"), value: "Sangat Mengetahui"),
      DropdownMenuItem(
          child: Text("Cukup Mengetahui"), value: "Cukup Mengetahui"),
      DropdownMenuItem(
          child: Text("Sedikit Mengetahui"), value: "Sedikit Mengetahui"),
      DropdownMenuItem(
          child: Text("Tidak Mengetahui"), value: "Tidak Mengetahui"),
    ];
    return menuItems3;
  }

  var selectedValue4 = "Sangat Bermanfaat";
  List<DropdownMenuItem<String>> get dropdownItems4 {
    List<DropdownMenuItem<String>> menuItems4 = [
      DropdownMenuItem(
          child: Text("Sangat Bermanfaat"), value: "Sangat Bermanfaat"),
      DropdownMenuItem(
          child: Text("Cukup Bermanfaat"), value: "Cukup Bermanfaat"),
      DropdownMenuItem(
          child: Text("Kurang Bermanfaat"), value: "Kurang Bermanfaat"),
      DropdownMenuItem(
          child: Text("Tidak Bermanfaat"), value: "Tidak Bermanfaat"),
    ];
    return menuItems4;
  }

  var selectedValue5 = "Sudah Sesuai";
  List<DropdownMenuItem<String>> get dropdownItems5 {
    List<DropdownMenuItem<String>> menuItems5 = [
      DropdownMenuItem(child: Text("Sudah Sesuai"), value: "Sudah Sesuai"),
      DropdownMenuItem(child: Text("Cukup Sesuai"), value: "Cukup Sesuai"),
      DropdownMenuItem(child: Text("Kurang Sesuai"), value: "Kurang Sesuai"),
      DropdownMenuItem(child: Text("Tidak Sesuai"), value: "Tidak Sesuai"),
      DropdownMenuItem(child: Text("Perlu Ditambah"), value: "Perlu Ditambah"),
    ];
    return menuItems5;
  }

  var selectedValue6 = "Sudah Sesuai";
  List<DropdownMenuItem<String>> get dropdownItems6 {
    List<DropdownMenuItem<String>> menuItems6 = [
      DropdownMenuItem(child: Text("Sudah Sesuai"), value: "Sudah Sesuai"),
      DropdownMenuItem(child: Text("Cukup Sesuai"), value: "Cukup Sesuai"),
      DropdownMenuItem(child: Text("Kurang Sesuai"), value: "Kurang Sesuai"),
      DropdownMenuItem(child: Text("Tidak Sesuai"), value: "Tidak Sesuai"),
      DropdownMenuItem(child: Text("Tidak Tahu"), value: "Tidak Tahu"),
    ];
    return menuItems6;
  }

  var selectedValue7 = "Memuaskan";
  List<DropdownMenuItem<String>> get dropdownItems7 {
    List<DropdownMenuItem<String>> menuItems7 = [
      DropdownMenuItem(child: Text("Memuaskan"), value: "Memuaskan"),
      DropdownMenuItem(
          child: Text("Cukup Memuaskan"), value: "Cukup Memuaskan"),
      DropdownMenuItem(
          child: Text("Kurang Memuaskan"), value: "Kurang Memuaskan"),
      DropdownMenuItem(
          child: Text("Tidak Memuaskan"), value: "Tidak Memuaskan"),
      DropdownMenuItem(child: Text("Tidak Tahu"), value: "Tidak Tahu"),
    ];
    return menuItems7;
  }

  var selectedValue10 = "Memuaskan";
  List<DropdownMenuItem<String>> get dropdownItems10 {
    List<DropdownMenuItem<String>> menuItems10 = [
      DropdownMenuItem(child: Text("Memuaskan"), value: "Memuaskan"),
      DropdownMenuItem(
          child: Text("Cukup Memuaskan"), value: "Cukup Memuaskan"),
      DropdownMenuItem(
          child: Text("Kurang Memuaskan"), value: "Kurang Memuaskan"),
      DropdownMenuItem(
          child: Text("Tidak Memuaskan"), value: "Tidak Memuaskan"),
      DropdownMenuItem(child: Text("Tidak Tahu"), value: "Tidak Tahu"),
    ];
    return menuItems10;
  }

  var selectedValue13 = "Baik";
  List<DropdownMenuItem<String>> get dropdownItems13 {
    List<DropdownMenuItem<String>> menuItems13 = [
      DropdownMenuItem(child: Text("Baik"), value: "Baik"),
      DropdownMenuItem(child: Text("Cukup Baik"), value: "Cukup Baik"),
      DropdownMenuItem(child: Text("Kurang Baik"), value: "Kurang Baik"),
      DropdownMenuItem(
          child: Text("Sangat Kurang Baik"), value: "Sangat Kurang Baik"),
    ];
    return menuItems13;
  }

  var selectedValue14 = "Perilaku SDM";
  List<DropdownMenuItem<String>> get dropdownItems14 {
    List<DropdownMenuItem<String>> menuItems14 = [
      DropdownMenuItem(child: Text("Perilaku SDM"), value: "Perilaku SDM"),
      DropdownMenuItem(
          child: Text("Peningkatan kapasitas SDM"),
          value: "Peningkatan kapasitas SDM"),
      DropdownMenuItem(
          child: Text("Peningkatan peran serta masyarakat"),
          value: "Peningkatan peran serta masyarakat"),
      DropdownMenuItem(
          child: Text("Sistem pelayanan"), value: "Sistem pelayanan"),
    ];
    return menuItems14;
  }

  var selectedValueS1 = "Tidak Ada";
  List<DropdownMenuItem<String>> get dropdownItemsS1 {
    List<DropdownMenuItem<String>> menuItemsS1 = [
      DropdownMenuItem(child: Text("Tidak Ada"), value: "Tidak Ada"),
      DropdownMenuItem(child: Text("1 Orang"), value: "1 Orang"),
      DropdownMenuItem(child: Text("2 Orang"), value: "2 Orang"),
      DropdownMenuItem(child: Text(">2 Orang"), value: ">2 Orang"),
      DropdownMenuItem(child: Text("Tidak Tahu"), value: "Tidak Tahu"),
    ];
    return menuItemsS1;
  }

  var selectedValueS2 = "Tidak Ada";
  List<DropdownMenuItem<String>> get dropdownItemsS2 {
    List<DropdownMenuItem<String>> menuItemsS2 = [
      DropdownMenuItem(child: Text("Tidak Ada"), value: "Tidak Ada"),
      DropdownMenuItem(child: Text("1 Orang"), value: "1 Orang"),
      DropdownMenuItem(child: Text("2 Orang"), value: "2 Orang"),
      DropdownMenuItem(child: Text("3 Orang"), value: "3 Orang"),
      DropdownMenuItem(child: Text("≥4 Orang"), value: "≥4 Orang"),
    ];
    return menuItemsS2;
  }

  var selectedValueS3 = "Tidak Ada";
  List<DropdownMenuItem<String>> get dropdownItemsS3 {
    List<DropdownMenuItem<String>> menuItemsS3 = [
      DropdownMenuItem(child: Text("Tidak Ada"), value: "Tidak Ada"),
      DropdownMenuItem(child: Text("1 Orang"), value: "1 Orang"),
      DropdownMenuItem(child: Text("2 Orang"), value: "2 Orang"),
      DropdownMenuItem(child: Text("3 Orang"), value: "3 Orang"),
      DropdownMenuItem(child: Text("≥4 Orang"), value: "≥4 Orang"),
    ];
    return menuItemsS3;
  }

  TextEditingController alasanPoint7 = TextEditingController();
  TextEditingController alasanPoint10 = TextEditingController();
  TextEditingController kegiatanPemerintahDesa = TextEditingController();
  TextEditingController alasanPoint14 = TextEditingController();
  TextEditingController prioritasPembangunan = TextEditingController();
  TextEditingController alasanPrioritasPembangunan = TextEditingController();
  TextEditingController jenisKejahatan = TextEditingController();
  TextEditingController jenisBencana = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _getNomorKKLocal();
    super.initState();
  }

  bool _isBencana = false;

  getStatusKejahatan() async {
    if (selectedValueS2 == "Tidak Ada") {
      setState(() {
        _isKejahatan = false;
        jenisKejahatan.text = "Tidak Ada";
      });
    } else {
      setState(() {
        _isKejahatan = true;
      });
    }

    if (selectedValueS3 == "Tidak Ada") {
      setState(() {
        _isBencana = false;
        jenisBencana.text = "Tidak Ada";
      });
    } else {
      setState(() {
        _isBencana = true;
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

  _savedDataToLocal() async {
    var data = {
      'nomor_kk': '${nik_kk}',
      'mengetahui_rpjm_desa': selectedValue1,
      'mengetahui_rkp_desa': selectedValue2,
      'mengetahui_musrenbangdes': selectedValue3,
      'manfaat_bltdd': selectedValue4,
      'keluarga_penerima_bltdd': selectedValue5,
      'pembangunan_tahun_anggaran': selectedValue6,
      'pelayanan_administrasi': selectedValue7,
      'penyebab_point_7': alasanPoint7.text,
      'kepuasan_pelayanan_umum': selectedValue10,
      'penyebab_point_10': alasanPoint10.text,
      'kegiatan_pemerintah_desa': selectedValue13,
      'perbaikan_mendasar_pemerintah_desa': selectedValue14,
      'penyebab_point_14': alasanPoint14.text,
      'jml_anggota_keluarga_mengikuti': selectedValueS1,
      'prioritas_pembangunan': prioritasPembangunan.text,
      'alasan_memilih_prioritas_itu': alasanPrioritasPembangunan.text,
      'jml_anggota_keluarga_korban_kejahatan': selectedValueS2,
      'jenis_korban_kejahatan': jenisKejahatan.text,
      'jml_anggota_keluarga_korban_bencana': selectedValueS3,
      'jenis_bencana_alam': jenisBencana.text,
    };
    final userEncode = jsonEncode(data);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('eval_pembangunan', userEncode);
    showAlertDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getStatusKejahatan();
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text("Kuisioner"),
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
              child: Text(
                textAlign: TextAlign.center,
                "Apakah saudara mengetahui RPJM Desa ? ",
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
                "Apakah saudara mengetahui RKP Desa ? ",
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
                "Apakah saudara mengetahui Musrenbangdes ? ",
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
                "Pendapat Saudara tentang manfaat Program BLT-DD ?",
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
                "Pendapat Saudara tentang Keluarga penerima BLT-DD Tahun 2021 ?",
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
                "Pendapat Saudara mengenai pembangunan tahun anggaran 2020 terhadap kebutuhan masyarakat ?",
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
                "Kepuasan pelayanan administrasi Pemerintah Desa dari tahun 2020 sampai sekarang ?",
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
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: alasanPoint7,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Jelaskan alasan kepuasan pelayanan administrasi',
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
                "Kepuasan pelayanan non administrasi Pemerintah Desa dari tahun 2020 sampai sekarang ?",
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
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: alasanPoint10,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText:
                      'Jelaskan alasan kepuasan pelayanan non administrasi',
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
                "Secara umum kegiatan Pemerintah Desa sejak tahun 2020 sampai sekarang ?",
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
                value: selectedValue13,
                items: dropdownItems13,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue13 = newValue!;
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
                "Perbaikan mendasar yang perlu segera dilakukan Pemerintah Desa ?",
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
                value: selectedValue14,
                items: dropdownItems14,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue14 = newValue!;
                  });
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: alasanPoint14,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText:
                      'Jelaskan alasan kepuasan pelayanan non administrasi',
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
                "Perencanaan dan Pembangunan Desa",
                style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Berapa jumlah anggota keluarga yang pernah mengikuti Musdus / Musdes / Musrenbangdes sejak tahun 2020 sampai sekarang ?",
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
                value: selectedValueS1,
                items: dropdownItemsS1,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValueS1 = newValue!;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: prioritasPembangunan,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Prioritas pembangunan ?',
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
                controller: alasanPrioritasPembangunan,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText:
                      'Sebutkan alasan / lokasi yang mendasari pilihan saudara',
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
                "Keamanan Dan Bencana",
                style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Jumlah anggota keluarga yang menjadi korban kejahatan selama setahun yang lalu ?",
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
                value: selectedValueS2,
                items: dropdownItemsS2,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValueS2 = newValue!;
                  });
                },
              ),
            ),
            Visibility(
              visible: _isKejahatan ? true : false,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
                child: TextFormField(
                  controller: jenisKejahatan,
                  enabled: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Sebutkan jenis kejahatan yang dialami',
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
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Jumlah anggota keluarga yang menjadi korban kejadian bencana alam selama setahun yang lalu ?",
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
                value: selectedValueS3,
                items: dropdownItemsS3,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValueS3 = newValue!;
                  });
                },
              ),
            ),
            Visibility(
              visible: _isBencana ? true : false,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
                child: TextFormField(
                  controller: jenisBencana,
                  enabled: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Sebutkan jenis bencana yang menimpa',
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
