import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  var token = '';

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token') ?? 'null')['token'];
  }

  auth(data, apiURL) async {
    var fullURL = "https://babygru.tech/api/auth/" + apiURL;
    return await http.post(Uri.parse(fullURL),
        body: jsonEncode(data), headers: _setHeaders());
  }

  store(data, apiURL) async {
    var fullURL = "https://babygru.tech/api/" + apiURL;
    return await http.post(Uri.parse(fullURL),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiURL) async {
    var fullUrl = "https://babygru.tech/api/" + apiURL;
    await _getToken();
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
