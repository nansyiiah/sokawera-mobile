import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sokaweramobile/Pages/InputScreen/DetailInputscreen.dart';
import 'package:sokaweramobile/Pages/components/BottomNavBar.dart';

class KeteranganSosial extends StatefulWidget {
  const KeteranganSosial({super.key});

  @override
  State<KeteranganSosial> createState() => _KeteranganSosialState();
}

class _KeteranganSosialState extends State<KeteranganSosial> {
  var total_data;
  bool _isFilled = false;
  _loadKeteranganTotalData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getInt('total_keluarga_full');
    if (user != null) {
      setState(() {
        total_data = user;
      });
    } else {
      return null;
    }
  }

  var list_nama = [];

  _loadListKeteranganSosial() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getStringList("nama_anggota") ?? [];
    if (user != null) {
      for (var element in user) {
        var parsing = jsonDecode(element);
        if (user.length <= total_data) {
          list_nama.add(parsing["nama"]);
        }
      }
      var kekurangan = total_data - user.length;
      for (var i = 0; i < kekurangan; i++) {
        list_nama.add("Belum diisi");
      }
      if (user.length == total_data) {
        _isFilled = true;
      }
    }
  }

  _deleteLocalKeteranganTempatData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove("nama_anggota");
    Navigator.of(context, rootNavigator: true).pop();
    Get.to(BottomNavBar());
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
        _deleteLocalKeteranganTempatData();
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

  @override
  void initState() {
    // TODO: implement initState
    _loadKeteranganTotalData();
    _loadListKeteranganSosial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text("Keterangan Sosial"),
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
              height: size.height * 0.75,
              child: ListView.builder(
                itemCount: total_data,
                itemBuilder: (context, index) {
                  var index_increment = index + 1;

                  return InkWell(
                    onTap: () {
                      Get.to(DetailInputscreen(item: index_increment));
                    },
                    child: Container(
                      height: size.height * 0.06,
                      margin: EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 24,
                      ),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      alignment: Alignment.center,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 0.3,
                            color: Colors.grey,
                          )
                        ],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "${index_increment}.",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                list_nama.isEmpty
                                    ? "Belum diisi"
                                    : list_nama[index],
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Icon(Icons.arrow_right),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.11,
              width: size.width,
              child: AbsorbPointer(
                absorbing: _isFilled ? false : true,
                child: InkWell(
                  onTap: () {
                    // _savedDataToLocal();
                    print("awikwok");
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 24, right: 24, bottom: 24),
                    padding: EdgeInsets.only(
                        left: 24, right: 24, top: 24, bottom: 24),
                    decoration: BoxDecoration(
                      color: _isFilled ? Color(0xFF68b7d8) : Colors.grey,
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
            ),
          ],
        ),
      ),
    );
  }
}
