import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPageDashboard extends StatefulWidget {
  final String dataDetail;
  final List jsonData;
  const DetailPageDashboard(
      {super.key, required this.dataDetail, required this.jsonData});

  @override
  State<DetailPageDashboard> createState() => _DetailPageDashboardState();
}

class _DetailPageDashboardState extends State<DetailPageDashboard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Detail ${widget.dataDetail}",
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
      backgroundColor: Colors.white.withOpacity(0.93),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.jsonData.length,
          itemBuilder: (context, index) {
            return Container(
              height: size.height * 0.05,
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "${widget.jsonData[index]["nama"]}",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(Icons.arrow_right_rounded),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
