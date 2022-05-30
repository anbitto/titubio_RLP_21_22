import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:sm_app_invidente/globals.dart' as globals;
import 'package:http/http.dart' as http;

class text2raspiState {
  void t2rApiCall(String text) async {
    final response = await http.post(
      Uri.parse('https://a9c9-158-109-94-83.eu.ngrok.io/print'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'text': text,
      }),
    );
    if (response.statusCode == 200) {
      print("/print");
      print("Response OK");
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
    }
  }

  void t2rScannBot(String text) async {
    final response = await http.get(
      Uri.parse('https://a9c9-158-109-94-83.eu.ngrok.io/scann'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      print("/scann");
      print("Response OK");
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
    }
  }
}
