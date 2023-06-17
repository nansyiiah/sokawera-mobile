import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sokaweramobile/Network/api.dart';
import 'package:sokaweramobile/Pages/components/BottomNavBar.dart';

class EditKejadianKematian extends StatefulWidget {
  final List data;
  const EditKejadianKematian({super.key, required this.data});

  @override
  State<EditKejadianKematian> createState() => _EditKejadianKematianState();
}

class _EditKejadianKematianState extends State<EditKejadianKematian> {
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

  TextEditingController namaController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController penyebabKematianController = TextEditingController();
  TextEditingController tempatMeninggalController = TextEditingController();

  editData() async {
    var data = {
      "nomor_kk": widget.data[0]["nomor_kk"],
      "nama": namaController.text,
      "tgl_kematian": dateController.text,
      "penyebab_kematian": penyebabKematianController.text,
      "tempat_meninggal": tempatMeninggalController.text
    };
    var res = await Network()
        .store(data, "kejadian_kematian/edit/${widget.data[0]["nomor_kk"]}");
    var body = jsonDecode(res.body);
    if (body["code"] == 200) {
      showAlertDialog(context);
    } else {
      showErrorDialog(context);
    }
  }

  deleteData() async {
    var res = await Network()
        .deleteData("kejadian_kematian", widget.data[0]["nomor_kk"]);
    var body = jsonDecode(res.body);
    if (body["code"] == 200) {
      showAlertDialog(context);
    } else {
      print(body);
      showErrorDialog(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    namaController.text = widget.data[0]["nama"];
    dateController.text = widget.data[0]["tgl_kematian"];
    penyebabKematianController.text = widget.data[0]["penyebab_kematian"];
    tempatMeninggalController.text = widget.data[0]["tempat_meninggal"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var name = widget.data[0]["nama"];
    var splitting = name.split(' ');
    Size size = MediaQuery.of(context).size;
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
                  deleteData();
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
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: namaController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Nama',
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
                controller: dateController,
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), //get today's date
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(
                        pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

                    setState(() {
                      dateController.text =
                          formattedDate; //set foratted date to TextField value.
                    });
                  } else {
                    setState(() {
                      dateController.text = "Tanggal belum diisi";
                    });
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.calendar_month_rounded),
                  labelText: 'Tanggal Kematian',
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
                controller: penyebabKematianController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Penyebab Kematian',
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
                controller: tempatMeninggalController,
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Tempat Meninggal',
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
                  // _savedDataToLocal();
                  editData();
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

enum MenuItem {
  item1,
  item2,
  item3,
  item4,
}
