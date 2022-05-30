import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';

class ApiWrapper {
  final player = AudioPlayer();

  // Función de detención del proceso de reproducción de audio
  void stopPlayer() {
    player.stop();
  }

  // Función para cargar el contenido del que generar audio
  // a partir de un archivo de texto
  Future<String> getFrase() async {
    String datafile = await rootBundle.loadString('frases/frase.txt');
    return datafile;
  }

  // Función encargada de la request a la API Text-To-Speech
  // y del procesado de la respuesta a formato de audio reproducible
  void ttsApiCall(String textInput, bool readFromFile) async {
    var frase = "";
    if (readFromFile == true) {
      frase = await getFrase();
    } else {
      frase = textInput;
    }

    var user = {};

    var resBody = {};
    resBody["languageCode"] = "es-ES";
    resBody["name"] = "es-ES-Standard-A";
    resBody["ssmlGender"] = "FEMALE";
    user["voice"] = resBody;

    resBody = {};
    resBody["text"] = frase;
    user["input"] = resBody;

    resBody = {};
    resBody["audioEncoding"] = "MP3";
    user["audioConfig"] = resBody;

    print(user);

    var str = json.encode(user);
    print(str);

    http.Response response = await http.post(
      Uri.parse(
          'https://texttospeech.googleapis.com/v1/text:synthesize?key=AIzaSyAKame4JnmCtac6GazF_aUv5GZpsjCbpPE'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );

    if (response.statusCode == 200) {
      print("Response OK");
      print(response.body.toString());

      var jsonResponse = json.decode(response.body);
      var encoded = jsonResponse["audioContent"];

      final nose = base64Decode(encoded);
      final tempFilePath = await createTemporaryFileFromUint8List(nose);
      playAudioFromFilePath(tempFilePath);
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
    }
  }

  //Función encargada de la creación temporal de un archivo de audio
  Future<String> createTemporaryFileFromUint8List(Uint8List bytes) async {
    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/temp.mp3').create();
    file.writeAsBytesSync(bytes);
    return file.path;
  }

  //Función encargada de reproducir un archivo de audio dada una ruta
  // de directorio
  void playAudioFromFilePath(String path) async {
    try {
      await player.play(path, isLocal: true);
    } catch (e) {
      print("error al reporducir audio: ${e.toString()}");
    }
  }
}
