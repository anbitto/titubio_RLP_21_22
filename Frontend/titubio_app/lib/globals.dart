import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String texto_teclado="";

var ficheroAgregado;
var pathFichero=null;


var pathImagen=null;
var pathTxt=null;
var pathFoto=null;
PickedFile? imagenCamara=null;

String? resultadoTexto="No he leído nada";

bool textScanning=false;

//Variables globales