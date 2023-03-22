import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sokaweramobile/Network/data_keterangan_responden_id.dart';
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
    print(widget.item);
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Text("($widget.item)"),
          )
        ],
      ),
    );
  }
}
