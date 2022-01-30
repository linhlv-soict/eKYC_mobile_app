// import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class IDCard {
  final String id;
  final String birthday;
  final String name;
  final String hometown;
  final String address;
  final String issueDate;

  IDCard({
    required this.id,
    required this.birthday,
    required this.name,
    required this.hometown,
    required this.address,
    required this.issueDate,
  });

  factory IDCard.fromJson(
      Map<String, dynamic> json, Map<String, dynamic> json1) {
    // print(json);
    return IDCard(
        id: json["objects"][0]["description"],
        birthday: json["objects"][1]["description"],
        name: json["objects"][2]["description"],
        hometown: json["objects"][3]["description"],
        address: json["objects"][4]["description"],
        issueDate: json1["objects"][0]["description"]);
  }
}

Future<IDCard> fetchIdCard(String _frontImgPath, String _backImgPath) async {
  File img = File(_frontImgPath);
  List<int> imageBytes = img.readAsBytesSync();
  print(imageBytes);
  String base64Image = base64Encode(imageBytes);

  File img1 = File(_backImgPath);
  List<int> imageBytes1 = img1.readAsBytesSync();
  print(imageBytes1);
  String base64Image1 = base64Encode(imageBytes1);

  // print(base64Image);
  String url = "http://192.168.1.84:8000/v2/images:annotates";
  Map<String, String> headers = {"Content-type": "application/json"};
  String json =
      '{"requests":[{"features":[{"type":"FRONT_ID_CARD"}],"image":{"content":"$base64Image"}}]}';
  String json1 =
      '{"requests":[{"features":[{"type":"BACK_ID_CARD"}],"image":{"content":"$base64Image1"}}]}';
  Response response = await post(Uri.parse(url), headers: headers, body: json);
  Response response1 =
      await post(Uri.parse(url), headers: headers, body: json1);
  if (response.statusCode == 200 && response1.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final data = utf8.decode(response.body.runes.toList());
    int len = data.length;
    print(data.substring(1, len - 1));

    final data1 = utf8.decode(response1.body.runes.toList());
    int len1 = data1.length;
    print(data1.substring(1, len1 - 1));
    return IDCard.fromJson(jsonDecode(data.substring(1, len - 1)),
        jsonDecode(data1.substring(1, len1 - 1)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load api');
  }
}
