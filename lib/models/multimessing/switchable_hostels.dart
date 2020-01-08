// To parse this JSON data, do
//
//     final switchableHostels = switchableHostelsFromJson(jsonString);

import 'dart:convert';

List<List<dynamic>> switchableHostelsFromJson(String str) =>
    List<List<dynamic>>.from(
        json.decode(str).map((x) => List<dynamic>.from(x.map((x) => x))));

String switchableHostelsToJson(List<List<dynamic>> data) => json.encode(
    List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x)))));
