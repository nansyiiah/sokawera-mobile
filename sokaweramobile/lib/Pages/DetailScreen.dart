import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sokaweramobile/Models/data_keterangan_responden_id.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  final int item;
  const DetailScreen({super.key, required this.item});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // Future<List<Data>> fetchData(id) async {
  //   var response = await http.get(
  //     Uri.parse("http://10.0.2.2:8000/api/keterangan_responden/${id}"),
  //     headers: {"Accept": "application/json"},
  //   );
  //   var jsonData = jsonDecode(response.body);
  //   List<Data> data = [];
  //   // Data datass = Data
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(widget.item);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
          onPressed: () => Navigator.of(context).pop(),
          icon: Container(
            alignment: Alignment(0.5, 0),
            // height: size.height,
            // width: size.width * 0.1,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(right: 15, top: 5, bottom: 5, left: 15),
            child: PopupMenuButton<MenuItem>(
              onSelected: (value) {
                if (value == MenuItem.item1) {
                  print("awikwok1");
                }
              },
              icon: Icon(Icons.more_horiz),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: MenuItem.item1,
                  child: Text("Awikwok"),
                ),
              ],
            ),
          ),
        ],
        title: Text("Details Family"),
        backgroundColor: Color(0xFF68b7d8),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF68b7d8),
      body: Column(
        children: [
          Center(
            child: Container(
              height: size.height * 0.1,
              width: size.width * 0.2,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          )
        ],
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
