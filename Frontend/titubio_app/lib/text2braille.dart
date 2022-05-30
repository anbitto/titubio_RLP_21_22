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

class text2brailleState {
  //Llamada a la API de traductor a braille.
  //Del json response de la API solo nos interesa el contenido de translated en contents, que correspondería a la traducción en braille.
  //El contenido de la traducción corresponde a una lista dinámica, como nos interesa tenerlo como string para luego visualizarlo por pantalla todo junto
  //lo guardamos en una lista string.
  //Cada posición de la lista string corresponde a una letra/puntuación en braille
  //La función devuelve una lista string (Future) con el resultado de la traducción
  Future<List<String>> t2bApiCall() async {
    var frase = globals.resultadoTexto;

    final uri = Uri.parse(
            'https://api.funtranslations.com/translate/braille/unicode.json')
        .replace(queryParameters: {
      'text': frase,
    });
    final response = await http.get(uri);

    List<String> res = [];
    if (response.statusCode == 200) {
      print("/braille");
      print("Response OK");
      var data = json.decode(response.body);
      var trans = data["contents"]["translated"];
      res = new List<String>.from(trans);
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
    }
    return res;
  }
}
