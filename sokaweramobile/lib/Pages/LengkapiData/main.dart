import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sokaweramobile/Pages/LengkapiData/KeteranganAset.dart';
import 'package:sokaweramobile/Pages/LengkapiData/KeteranganPerumahan.dart';
import 'package:sokaweramobile/Pages/LengkapiData/Kuisioner.dart';

class LengkapiDataMain extends StatefulWidget {
  final String nik;
  final List data;
  const LengkapiDataMain({super.key, required this.data, required this.nik});

  @override
  State<LengkapiDataMain> createState() => _LengkapiDataMainState();
}

class _LengkapiDataMainState extends State<LengkapiDataMain> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Lengkapi Data",
          style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white.withOpacity(0.93),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
              child: ListView.builder(
                itemCount: widget.data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      switch (widget.data[index]) {
                        case "Kepemilikan Aset":
                          Get.to(KeteranganAsetLengkapi(
                            nik: widget.nik,
                          ));
                          break;
                        case "Kuisioner":
                          Get.to(KuisionerLengkapi(nik: widget.nik));
                          break;
                        case "Keterangan Perumahan":
                          Get.to(KeteranganPerumahanLengkapi(nik: widget.nik));
                        default:
                      }
                    },
                    child: Container(
                      height: size.height * 0.07,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "${widget.data[index]}",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(Icons.keyboard_arrow_right_sharp),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
