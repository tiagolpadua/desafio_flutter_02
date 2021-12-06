import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://hp-api.herokuapp.com/api";

class API {
  static Future getCharacters() {
    var url = baseUrl + "/characters";
    return http.get(url);
  }
}