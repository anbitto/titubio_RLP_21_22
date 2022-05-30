import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sm_app_invidente/braille.dart';
import 'package:sm_app_invidente/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:sm_app_invidente/globals.dart' as globals;


class preview extends StatefulWidget{
  @override
  _previewState createState() => _previewState();
}

class _previewState extends State<preview> {

  //Función para ver el texto escrito reconocido
  //Éste se enviará a "traducir" a Braille
  Widget _showText() {
    if (globals.resultadoTexto != null) {
      return Align(
          alignment: Alignment.center,
          child: Text(globals.resultadoTexto!));
    } else {
      return Align(
        alignment: Alignment.center,
        child: Text("No se ha reconocido texto"),
      );
    }
  }

  //Pantalla donde se observa el texto escrito
  //Con botón para traducir a Braille
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
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Texto Reconocido",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                      ])),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 25),
                        height: MediaQuery.of(context).size.height * 0.31,
                        width: MediaQuery.of(context).size.width * 0.90,
                        decoration: BoxDecoration(
                            color: Colors.lightGreen[50],
                            borderRadius: BorderRadius.circular(10)),
                        child: _showText(),
                      )
                    ],
                  ),),

              Row(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                    width: MediaQuery.of(context).size.width * 1,
                    child: FloatingActionButton.extended(
                      heroTag: const Text('Traducir'),
                      label: const Text(
                        "Traducir a Braille",
                        style: const TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      icon: const Icon(
                        Icons.api,
                        size: 70.0,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (context) => braille(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

            ]));
  }
}
