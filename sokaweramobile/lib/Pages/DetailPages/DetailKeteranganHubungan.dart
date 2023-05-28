import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sokaweramobile/Network/api.dart';
import 'package:sokaweramobile/Pages/components/BottomNavBar.dart';

class DetailKeteranganHubungan extends StatefulWidget {
  final List jsonData;
  final List jsonPendidikan;
  const DetailKeteranganHubungan(
      {super.key, required this.jsonData, required this.jsonPendidikan});

  @override
  State<DetailKeteranganHubungan> createState() =>
      _DetailKeteranganHubunganState();
}

class _DetailKeteranganHubunganState extends State<DetailKeteranganHubungan> {
  late Future myFuture;
  bool _isEmpty2 = false;
  bool _isMe = false;
  bool _isHaveUsaha = false;
  List schoolData = [];
  List tes = [];
  var value;

  String selectedValue2 = "";
  String selectedValue3 = "";
  String selectedValue4 = "";
  String selectedValue5 = "";
  String selectedStatus = "";

  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems2 = [
      DropdownMenuItem(child: Text("Ya"), value: "Ya"),
      DropdownMenuItem(child: Text("Tidak"), value: "Tidak"),
      DropdownMenuItem(
          child: Text("Ya (Bukan Anggota Keluarga)"),
          value: "Ya Bukan Anggota Keluarga"),
    ];
    return menuItems2;
  }

  List<DropdownMenuItem<String>> get dropdownItemsStatus {
    List<DropdownMenuItem<String>> menuItemsStatus = [
      DropdownMenuItem(child: Text("Belum Kawin"), value: "Belum Kawin"),
      DropdownMenuItem(child: Text("Kawin / Nikah"), value: "Kawin / Nikah"),
      DropdownMenuItem(child: Text("Cerai Hidup"), value: "Cerai Hidup"),
      DropdownMenuItem(child: Text("Cerai Mati"), value: "Cerai Mati"),
    ];
    return menuItemsStatus;
  }

  List<DropdownMenuItem<String>> get dropdownItems4 {
    List<DropdownMenuItem<String>> menuItems4 = [
      DropdownMenuItem(child: Text("Sedang Hamil"), value: "Sedang Hamil"),
      DropdownMenuItem(
          child: Text("Tidak Sedang Hamil"), value: "Tidak Sedang Hamil"),
    ];
    return menuItems4;
  }

  List<DropdownMenuItem<String>> get dropdownItems3 {
    List<DropdownMenuItem<String>> menuItems3 = [
      DropdownMenuItem(child: Text("Laki Laki"), value: "Laki Laki"),
      DropdownMenuItem(child: Text("Perempuan"), value: "Perempuan"),
    ];
    return menuItems3;
  }

  List<DropdownMenuItem<String>> get dropdownItems5 {
    List<DropdownMenuItem<String>> menuItems5 = [
      DropdownMenuItem(
          child: Text("Tidak / belum sekolah"), value: "Tidak / belum sekolah"),
      DropdownMenuItem(child: Text("Masih Sekolah"), value: "Masih Sekolah"),
      DropdownMenuItem(
          child: Text("Tidak bersekolah lagi"), value: "Tidak bersekolah lagi"),
    ];
    return menuItems5;
  }

  String selectedValueKost = "";
  String selectedValueBeasiswa = "";

  List<DropdownMenuItem<String>> get dropdownItemsKost {
    List<DropdownMenuItem<String>> menuItemsKost = [
      DropdownMenuItem(child: Text("Ya"), value: "Ya"),
      DropdownMenuItem(child: Text("Tidak"), value: "Tidak"),
    ];
    return menuItemsKost;
  }

  TextEditingController nik = TextEditingController();
  TextEditingController hubungan = TextEditingController();
  TextEditingController umur = TextEditingController();
  TextEditingController ijazah_tertinggi = TextEditingController();
  TextEditingController bekerja = TextEditingController();
  TextEditingController lapangan_kerja = TextEditingController();
  TextEditingController status_kerja = TextEditingController();
  TextEditingController namaAnakSekolah = TextEditingController();
  TextEditingController jenjang_pendidikan_ditempuh = TextEditingController();
  TextEditingController nama_sekolah = TextEditingController();
  TextEditingController kelas = TextEditingController();
  TextEditingController kost_tidak = TextEditingController();
  TextEditingController beasiswa_tidak = TextEditingController();
  TextEditingController melanjutkan_sekolah_tidak = TextEditingController();
  TextEditingController jumlah_biaya_sekolah = TextEditingController();

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

  _loadKetPendidikan(data) async {
    for (var element in data) {
      var warga = {
        "id": element["id"],
        "nama": element["nama"],
        "jenjang_pendidikan_ditempuh": element["jenjang_pendidikan_ditempuh"],
        "nama_sekolah": element["nama_sekolah"],
        "kelas": element["kelas"],
        "kost_tidak": element["kost_tidak"],
        "beasiswa_tidak": element["beasiswa_tidak"],
        "melanjutkan_sekolah_tidak": element["melanjutkan_sekolah_tidak"],
        "nama_sekolah_tujuan": element["nama_sekolah_tujuan"],
        "jumlah_biaya_sekolah": element["jumlah_biaya_sekolah"],
        "nik_kk": element["nik_kk"],
      };
      schoolData.add(warga);
    }
    return data;
  }

  Me(data, nama) async {
    for (var element in data) {
      if (element['nama'] == nama) {
        setState(() {
          _isMe = true;
          var warga = {
            "id": element["id"],
            "nama": element["nama"],
            "jenjang_pendidikan_ditempuh":
                element["jenjang_pendidikan_ditempuh"],
            "nama_sekolah": element["nama_sekolah"],
            "kelas": element["kelas"],
            "kost_tidak": element["kost_tidak"],
            "beasiswa_tidak": element["beasiswa_tidak"],
            "melanjutkan_sekolah_tidak": element["melanjutkan_sekolah_tidak"],
            "nama_sekolah_tujuan": element["nama_sekolah_tujuan"],
            "jumlah_biaya_sekolah": element["jumlah_biaya_sekolah"],
            "nik_kk": element["nik_kk"],
          };
          tes = [warga];
        });
      } else {
        var warga = {
          "id": "null",
          "nama": "null",
          "jenjang_pendidikan_ditempuh": "null",
          "nama_sekolah": "null",
          "kelas": "null",
          "kost_tidak": "null",
          "beasiswa_tidak": "null",
          "melanjutkan_sekolah_tidak": "null",
          "nama_sekolah_tujuan": "null",
          "jumlah_biaya_sekolah": "null",
          "nik_kk": "null",
        };
        tes.add(warga);
      }
    }
  }

  _editKeteranganSosial(nik, jsonData) async {
    var data = {
      "nik_kk": jsonData[0]['nik_kk'],
      'nik': jsonData[0]['nik'],
      'nama': jsonData[0]['nama'],
      "rt": jsonData[0]['rt'],
      "rw": jsonData[0]['rw'],
      "nama": jsonData[0]['nama'],
      "hubungan": jsonData[0]['hubungan'],
      "tinggal": selectedValue2,
      "jenis_kelamin": selectedValue3,
      "umur": umur.text,
      "status": selectedStatus,
      "status_kehamilan": selectedValue4,
      "partisipasi": selectedValue5,
      "ijazah_tertinggi": ijazah_tertinggi.text,
      "bekerja": bekerja.text,
      "lapangan_kerja": lapangan_kerja.text,
      "status_kerja": status_kerja.text,
    };
    var res = await Network().store(data, 'keterangan_sosial/edit/${nik}');
    var body = jsonDecode(res.body);
    if (body["code"] == 200) {
      showAlertDialog(context);
    } else {
      showErrorDialog(context);
    }
  }

  _editKeteranganPendidikan(id) async {
    var data = {
      'nama': namaAnakSekolah.text,
      'jenjang_pendidikan_ditempuh': jenjang_pendidikan_ditempuh.text,
      'nama_sekolah': nama_sekolah.text,
      'kelas': kelas.text,
      'kost_tidak': selectedValueKost,
      'beasiswa_tidak': selectedValueBeasiswa,
      'melanjutkan_sekolah_tidak': melanjutkan_sekolah_tidak.text,
      'jumlah_biaya_sekolah': jumlah_biaya_sekolah.text,
    };
    var res =
        await Network().store(data, 'keterangan_khusus_pendidikan/edit/${id}');
    var body = jsonDecode(res.body);
    if (body['code'] == 200) {
      showAlertDialog(context);
    } else {
      print(body);
      showErrorDialog(context);
    }
  }

  _loadData(data) {
    nik.text = data['nik'];
    hubungan.text = data['hubungan'];
    umur.text = data['umur'];
    selectedValue2 = data['tinggal'];
    selectedValue3 = data['jenis_kelamin'];
    selectedStatus = data['status'];
    selectedValue4 = data['status_kehamilan'];
    selectedValue5 = data['partisipasi'];
    ijazah_tertinggi.text = data['ijazah_tertinggi'];
    bekerja.text = data['bekerja'];
    lapangan_kerja.text = data['lapangan_kerja'];
    status_kerja.text = data['status_kerja'];
    return data;
  }

  var idKosong;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.jsonPendidikan.length != 0) {
      myFuture = _loadKetPendidikan(widget.jsonPendidikan);
      _loadData(widget.jsonData[0]);
      Me(schoolData, widget.jsonData[0]['nama']);
      idKosong = tes[0]["id"] ?? ["null"];
      namaAnakSekolah.text = tes[0]["nama"] ?? ["null"];
      jenjang_pendidikan_ditempuh.text =
          tes[0]['jenjang_pendidikan_ditempuh'] ?? ["null"];
      nama_sekolah.text = tes[0]['nama_sekolah'] ?? ['null'];
      kelas.text = tes[0]['kelas'] ?? ['null'];
      kost_tidak.text = tes[0]['kost_tidak'] ?? ['null'];
      selectedValueKost = tes[0]['kost_tidak'] ?? ['null'];
      beasiswa_tidak.text = tes[0]['beasiswa_tidak'] ?? ['null'];
      selectedValueBeasiswa = tes[0]['beasiswa_tidak'] ?? ['null'];
      melanjutkan_sekolah_tidak.text =
          tes[0]['melanjutkan_sekolah_tidak'] ?? ['null'];
      jumlah_biaya_sekolah.text = tes[0]['jumlah_biaya_sekolah'] ?? ['null'];
    } else {
      _loadData(widget.jsonData[0]);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var name = widget.jsonData[0]["nama"];
    var splitting = name.split(' ');
    Size size = MediaQuery.of(context).size;
    if (widget.jsonPendidikan.length != 0) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Detail ${splitting[0]}",
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
          actions: [
            Container(
              padding: EdgeInsets.only(right: 10),
              child: PopupMenuButton<MenuItem>(
                onSelected: (value) {
                  if (value == MenuItem.item1) {
                    // _deleteData(widget.nik);
                  }
                },
                icon: Icon(
                  Icons.more_horiz,
                  color: Colors.black,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: MenuItem.item1,
                    child: Text("Delete"),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white.withOpacity(0.93),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: myFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData == false) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var data = (snapshot.data as List).toList();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Keterangan Sosial",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: size.height * 0.07,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: nik,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: "NIK",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: size.height * 0.07,
                          width: size.width * 0.4,
                          margin: EdgeInsets.only(left: 24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: hubungan,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: "Hubungan",
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: size.height * 0.07,
                          width: size.width * 0.4,
                          margin: EdgeInsets.only(right: 24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: umur,
                            enabled: true,
                            decoration: InputDecoration(
                              labelText: "Umur",
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: size.height * 0.079,
                          width: size.width * 0.4,
                          margin: EdgeInsets.only(left: 24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text(
                                  "Tinggal dirumah ?",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              DropdownButtonHideUnderline(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: DropdownButton(
                                    hint: Text("Tinggal dirumah"),
                                    isExpanded: true,
                                    value: selectedValue2,
                                    items: dropdownItems2,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedValue2 = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: size.height * 0.079,
                          width: size.width * 0.4,
                          margin: EdgeInsets.only(right: 24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 40,
                                ),
                                child: Text(
                                  "Jenis Kelamin",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              DropdownButtonHideUnderline(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: selectedValue3,
                                    items: dropdownItems3,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedValue3 = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: size.height * 0.079,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "Status Pernikahan",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          DropdownButtonHideUnderline(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: DropdownButton(
                                isExpanded: true,
                                value: selectedStatus,
                                items: dropdownItemsStatus,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedStatus = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: size.height * 0.079,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "Status Kehamilan",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          DropdownButtonHideUnderline(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: DropdownButton(
                                hint: Text("Status Kehamilan"),
                                isExpanded: true,
                                value: selectedValue4,
                                items: dropdownItems4,
                                onChanged: null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: size.height * 0.079,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "Partisipasi Sekolah",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          DropdownButtonHideUnderline(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: DropdownButton(
                                isExpanded: true,
                                value: selectedValue5,
                                items: dropdownItems5,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue5 = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: size.height * 0.07,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: ijazah_tertinggi,
                        enabled: true,
                        decoration: InputDecoration(
                          labelText: "Ijasah Tertinggi",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: size.height * 0.07,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: bekerja,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: "Bekerja atau Tidak",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: size.height * 0.07,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: lapangan_kerja,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: "Lapangan Pekerjaan",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: size.height * 0.07,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: status_kerja,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: "Status Pekerjaan",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Keterangan Pendidikan",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: _isMe
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: size.height * 0.07,
                                  width: size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 24),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: TextFormField(
                                    controller: namaAnakSekolah,
                                    enabled: true,
                                    decoration: InputDecoration(
                                      labelText:
                                          "Nama Anggota Keluarga yang masih sekolah",
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: size.height * 0.07,
                                  width: size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 24),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: TextFormField(
                                    controller: jenjang_pendidikan_ditempuh,
                                    enabled: true,
                                    decoration: InputDecoration(
                                      labelText:
                                          "Jenjang Pendidikan yang sedang ditempuh",
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: size.height * 0.07,
                                  width: size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 24),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: TextFormField(
                                    controller: nama_sekolah,
                                    enabled: true,
                                    decoration: InputDecoration(
                                      labelText: "Nama Sekolah",
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: size.height * 0.07,
                                  width: size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 24),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: TextFormField(
                                    controller: kelas,
                                    enabled: true,
                                    decoration: InputDecoration(
                                      labelText: "Kelas / Tingkat",
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: size.height * 0.079,
                                      width: size.width * 0.4,
                                      margin: EdgeInsets.only(left: 24),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: Text(
                                              "Kost atau Tidak ?",
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          DropdownButtonHideUnderline(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: DropdownButton(
                                                hint: Text("Kost atau tidak"),
                                                isExpanded: true,
                                                value: selectedValueKost,
                                                items: dropdownItemsKost,
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selectedValueKost =
                                                        newValue!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: size.height * 0.079,
                                      width: size.width * 0.4,
                                      margin: EdgeInsets.only(right: 24),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 40,
                                            ),
                                            child: Text(
                                              "Beasiswa tidak",
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          DropdownButtonHideUnderline(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: DropdownButton(
                                                isExpanded: true,
                                                value: selectedValueBeasiswa,
                                                items: dropdownItemsKost,
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selectedValueBeasiswa =
                                                        newValue!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: size.height * 0.07,
                                  width: size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 24),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: TextFormField(
                                    controller: melanjutkan_sekolah_tidak,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      labelText: "Melanjutkan sekolah tidak",
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: size.height * 0.07,
                                  width: size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 24),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: TextFormField(
                                    controller: jumlah_biaya_sekolah,
                                    enabled: true,
                                    decoration: InputDecoration(
                                      labelText: "Jumlah biaya sekolah",
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              "No Data",
                            ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: size.height * 0.11,
                      width: size.width,
                      child: InkWell(
                        onTap: () async {
                          // await _postAllData();
                          await _editKeteranganSosial(
                              widget.jsonData[0]['nik'], widget.jsonData);
                          await _editKeteranganPendidikan(idKosong);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 24, right: 24, top: 40),
                          padding: EdgeInsets.only(
                              left: 24, right: 24, top: 14, bottom: 14),
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
                      height: 50,
                    ),
                  ],
                );
              }
            },
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Detail ${splitting[0]}",
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
          actions: [
            Container(
              padding: EdgeInsets.only(right: 10),
              child: PopupMenuButton<MenuItem>(
                onSelected: (value) {
                  if (value == MenuItem.item1) {
                    // _deleteData(widget.nik);
                  }
                },
                icon: Icon(
                  Icons.more_horiz,
                  color: Colors.black,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: MenuItem.item1,
                    child: Text("Delete"),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Keterangan Sosial",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.07,
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: nik,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "NIK",
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: size.height * 0.07,
                    width: size.width * 0.4,
                    margin: EdgeInsets.only(left: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: hubungan,
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: "Hubungan",
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: size.height * 0.07,
                    width: size.width * 0.4,
                    margin: EdgeInsets.only(right: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: umur,
                      enabled: true,
                      decoration: InputDecoration(
                        labelText: "Umur",
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: size.height * 0.079,
                    width: size.width * 0.4,
                    margin: EdgeInsets.only(left: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            "Tinggal dirumah ?",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        DropdownButtonHideUnderline(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: DropdownButton(
                              hint: Text("Tinggal dirumah"),
                              isExpanded: true,
                              value: selectedValue2,
                              items: dropdownItems2,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue2 = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: size.height * 0.079,
                    width: size.width * 0.4,
                    margin: EdgeInsets.only(right: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 40,
                          ),
                          child: Text(
                            "Jenis Kelamin",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        DropdownButtonHideUnderline(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: DropdownButton(
                              isExpanded: true,
                              value: selectedValue3,
                              items: dropdownItems3,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue3 = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.079,
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Status Kehamilan",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButton(
                          hint: Text("Status Kehamilan"),
                          isExpanded: true,
                          value: selectedValue4,
                          items: dropdownItems4,
                          onChanged: null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.079,
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Partisipasi Sekolah",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButton(
                          isExpanded: true,
                          value: selectedValue5,
                          items: dropdownItems5,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue5 = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.07,
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: ijazah_tertinggi,
                  enabled: true,
                  decoration: InputDecoration(
                    labelText: "Ijasah Tertinggi",
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.07,
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: bekerja,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Bekerja atau Tidak",
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.07,
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: lapangan_kerja,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Lapangan Pekerjaan",
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.07,
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: status_kerja,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Status Pekerjaan",
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: size.height * 0.11,
                width: size.width,
                child: InkWell(
                  onTap: () async {
                    // await _postAllData();
                    await _editKeteranganSosial(
                        widget.jsonData[0]['nik'], widget.jsonData);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 24, right: 24, top: 40),
                    padding: EdgeInsets.only(
                        left: 24, right: 24, top: 14, bottom: 14),
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
                height: 50,
              ),
            ],
          ),
        ),
      );
    }
  }
}

enum MenuItem {
  item1,
  item2,
  item3,
  item4,
}
