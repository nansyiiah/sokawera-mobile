import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputScreen1 extends StatefulWidget {
  const InputScreen1({super.key});

  @override
  State<InputScreen1> createState() => _InputScreen1State();
}

class _InputScreen1State extends State<InputScreen1> {
  String name = "";
  final TextEditingController provinsiController =
      TextEditingController(text: "JAWA TENGAH");
  final TextEditingController kabupatenController =
      TextEditingController(text: "BANYUMAS");
  final TextEditingController kecamatanController =
      TextEditingController(text: "PATIKRAJA");
  final TextEditingController desaController =
      TextEditingController(text: "SOKAWERA");
  final TextEditingController dusunController = TextEditingController();
  final TextEditingController namaJalanController = TextEditingController();
  final TextEditingController rtController = TextEditingController();
  final TextEditingController rwController = TextEditingController();
  final TextEditingController nomorKKController = TextEditingController();
  void initState() {
    _loadUserData();
    super.initState();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('user');
    if (user != null) {
      setState(() {
        name = user; //nama petugas
      });
    } else {
      setState(() {
        name = "null";
      });
    }
  }

  _login() async {
    // var data = {
    //   'username': emailController.text,
    //   'password': passwordController.text,
    // };

    // var res = await Network().auth(data, '/login');
    // var body = json.decode(res.body);
    // if (body["message"] == "Success") {
    //   SharedPreferences localStorage = await SharedPreferences.getInstance();
    //   localStorage.setString('token', body["token"]);
    //   localStorage.setString('user', body["data"]);
    //   Get.to(BottomNavBar());
    // } else {
    //   var snackBar = SnackBar(content: Text('Email / Password Salah'));
    //   // Step 3
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Keterangan Tempat"),
        backgroundColor: Color(0xFF68b7d8),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: TextFormField(
                controller: provinsiController,
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Provinsi',
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
                controller: kabupatenController,
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Kabupaten',
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
                controller: kecamatanController,
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Kecamatan',
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
                controller: desaController,
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Desa',
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
                controller: dusunController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Dusun',
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
                controller: namaJalanController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Nama Jalan / Gang',
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
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, top: 24),
                    child: TextFormField(
                      controller: rtController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'RT',
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
                      controller: rwController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'RW',
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
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 24, bottom: 24),
              child: TextFormField(
                controller: nomorKKController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Nomor KK',
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
                onTap: () {},
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
