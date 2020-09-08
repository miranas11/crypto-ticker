import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
  var url;

  Networking({@required this.url});

  final api = '2A80AAF2-CB9E-4969-97DB-1404792AFD6F';
  Future<dynamic> getData() async {
    http.Response response = await http.get(url + api);
    print(response.body);
    return jsonDecode(response.body);
  }
}
