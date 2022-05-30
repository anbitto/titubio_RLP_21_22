import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sm_app_invidente/main.dart';
import 'package:sm_app_invidente/preview.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sm_app_invidente/globals.dart' as globals;
import 'package:path_provider/path_provider.dart';


class texto extends StatefulWidget{
  @override
  _textoState createState() => _textoState();
}

class _textoState extends State<texto>{


  //Función para recuperar lo escrito en un txt/pdf
  void _txt() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        withData:true,
        allowedExtensions: ['txt', 'pdf']
    );
    if (result == null) return;
    globals.pathTxt=result.files.first.path;
    PlatformFile file = result.files.first;
    print(file.bytes);
    Uint8List? bytes = file.bytes;
    String s = new String.fromCharCodes(bytes!);
    print(s);
    globals.resultadoTexto=s;
  }

  //Pantalla "Extra" para también traducir a
  //Braille lo escrito en un txt/pdf
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'APP INVIDENTES',
          style: TextStyle(fontSize: 25.0, fontFamily: 'Glacial Indifference'),
        ),
      ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("TXT",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                      ])),
              Row(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                    width: MediaQuery.of(context).size.width * 1,
                    child: FloatingActionButton.extended(
                      heroTag: const Text('Seleccionar txt'),
                      label: const Text(
                        "Seleccionar txt",
                        style: const TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      icon: const Icon(
                        Icons.text_snippet_outlined,
                        size: 70.0,
                      ),
                      onPressed: () {
                        _txt();
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonTheme(
                    height: MediaQuery.of(context).size.height * 0.2,
                    minWidth: MediaQuery.of(context).size.width * 0.5,
                    child: RaisedButton(
                      disabledColor: Colors.grey,
                      color: Colors.red,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (context) => MyApp(),
                          ),
                        );
                      },
                      child: const Text(
                        "Volver",
                        style: const TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    height: MediaQuery.of(context).size.height * 0.2,
                    minWidth: MediaQuery.of(context).size.width * 0.5,
                    child: RaisedButton(
                      disabledColor: Colors.grey,
                      color: Colors.green,
                      onPressed: () {
                        print("HOLA");
                        //globals.resultadoTexto="Vengo del Reconocimiento por txt.";
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (context) => preview(),
                          ),
                        );
                      },
                      child: const Text(
                        "Aceptar",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                ],
              ),
            ]));
  }
}