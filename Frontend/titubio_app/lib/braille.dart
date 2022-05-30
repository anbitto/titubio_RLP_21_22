import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sm_app_invidente/main.dart';
import 'package:sm_app_invidente/text2braille.dart';
import 'package:sm_app_invidente/text2raspi.dart';
import 'package:sm_app_invidente/api/api_wrapper.dart';
import 'package:sm_app_invidente/globals.dart' as globals;
import 'package:http/http.dart' as http;

class braille extends StatefulWidget {
  @override
  _brailleState createState() => _brailleState();
}

class _brailleState extends State<braille> {
  String brailleStr = "";
  final api = ApiWrapper();
  final t2r = text2raspiState();
  String resTextoStr = globals.resultadoTexto ?? 'default';
  bool is_Playing = false;

  _brailleState() {
    brailleStr = toBraille();
  }

  //Función de renderizado de la pantalla
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'APP INVIDENTES',
            style:
                TextStyle(fontSize: 25.0, fontFamily: 'Glacial Indifference'),
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Texto en Braille",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w700)),
                      ])),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(brailleStr, style: TextStyle(fontSize: 20)),
                      ])),
              Row(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                    width: MediaQuery.of(context).size.width * 1,
                    child: FloatingActionButton.extended(
                      heroTag: const Text('Reproducir Braille'),
                      label: const Text(
                        "Reproducir",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      icon: const Icon(
                        Icons.speaker,
                        size: 70.0,
                      ),
                      onPressed: () {
                        playAudioButtonHandler();
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                    width: MediaQuery.of(context).size.width * 1,
                    child: FloatingActionButton.extended(
                      heroTag: const Text('Imprimir Braille'),
                      label: const Text(
                        "Imprimir",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      icon: const Icon(
                        Icons.local_print_shop_rounded,
                        size: 70.0,
                      ),
                      onPressed: () {
                        t2r.t2rApiCall(resTextoStr);
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                    width: MediaQuery.of(context).size.width * 1,
                    child: FloatingActionButton.extended(
                      heroTag: const Text('Volver Principal'),
                      label: const Text(
                        "Volver al menú principal",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      icon: const Icon(
                        Icons.home,
                        size: 70.0,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (context) => MyApp(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ]));
  }

  //Función encrgada de gestionar el trigger de la llamada a la API Text-To-Speech
  void playAudioButtonHandler() {
    if (!is_Playing) {
      String content = "";

      if (globals.resultadoTexto != null) content = globals.resultadoTexto!;

      api.ttsApiCall(content, false);
      setState(() {
        is_Playing = true;
      });
    } else {
      api.stopPlayer();
      setState(() {
        is_Playing = false;
      });
    }
  }

  //Función encrgada de gestionar la llamada a la API de traducción a Braille
  String toBraille() {
    final t2b = text2brailleState();
    List<String> res = [];
    Future<List<String>> stringFuture = t2b.t2bApiCall();

    stringFuture.then((value) {
      res = value;
    });

    String aux = "";
    for (int i = 0; i < res.length; i++) {
      aux += res[i];
    }
    return aux;
  }
}
