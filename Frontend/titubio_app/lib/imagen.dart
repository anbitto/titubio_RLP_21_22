// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';

// import 'package:sm_app_invidente/main.dart';
// import 'package:sm_app_invidente/preview.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:open_file/open_file.dart';
// import 'package:sm_app_invidente/globals.dart' as globals;

// class imagen extends StatefulWidget {
//   @override
//   _imagenState createState() => _imagenState();
// }

// class _imagenState extends State<imagen> {
//   PickedFile? imageFile = null;


//   //Función para recoger la imagen de la galeria o de la camara
//   void getImage(ImageSource source) async {
//     try {
//       final pickedImage = await ImagePicker().pickImage(source: source);
//       if (pickedImage != null) {
//         globals.textScanning = true;
//         //imageFile = pickedImage;
//         getRecognisedText(pickedImage);
//       }
//     } catch (e) {
//       globals.textScanning = false;
//       imageFile = null;
//       globals.resultadoTexto = "Error al escanear";
//     }
//   }

//   //Aquí llamamos a la API de reconocimiento de texto
//   //a la cual le mandamos la imagen seleccionada por el
//   //usuario o la foto que acaba de hacer

//   //Nos guardamos el resultado final en nuestra variable
//   //resultado texto que enseñaremos en la siguiente pantalla
//   void getRecognisedText(XFile image) async {
//     final inputImage = InputImage.fromFilePath(image.path);
//     final textDetector = GoogleMlKit.vision.textDetector();
//     RecognisedText recognisedText = await textDetector.processImage(inputImage);
//     await textDetector.close();
//     globals.resultadoTexto = "";
//     for (TextBlock block in recognisedText.blocks) {
//       for (TextLine line in block.lines) {
//         globals.resultadoTexto = globals.resultadoTexto! + line.text + "\n";
//       }
//     }
//     globals.textScanning = false;
//   }

//   //Pantalla de reconocimiento por imágenes
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text(
//             'APP INVIDENTES',
//             style:
//                 TextStyle(fontSize: 25.0, fontFamily: 'Glacial Indifference'),
//           ),
//         ),
//         body: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.18,
//                     width: MediaQuery.of(context).size.width * 1,
//                     child: FloatingActionButton.extended(
//                       heroTag: const Text('Imagen Galeria'),
//                       label: const Text(
//                         "Imagen Galeria",
//                         style:
//                             const TextStyle(color: Colors.white, fontSize: 30),
//                       ),
//                       foregroundColor: Colors.white,
//                       backgroundColor: Colors.green,
//                       icon: const Icon(
//                         Icons.image,
//                         size: 70.0,
//                       ),
//                       onPressed: () {
//                         //_imagenGaleria(context);
//                         getImage(ImageSource.gallery);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.18,
//                     width: MediaQuery.of(context).size.width * 1,
//                     child: FloatingActionButton.extended(
//                       heroTag: const Text('Hacer foto'),
//                       label: const Text(
//                         "Hacer foto",
//                         style:
//                             const TextStyle(color: Colors.white, fontSize: 30),
//                       ),
//                       foregroundColor: Colors.white,
//                       backgroundColor: Colors.green,
//                       icon: const Icon(
//                         Icons.camera_alt,
//                         size: 70.0,
//                       ),
//                       onPressed: () {
//                         getImage(ImageSource.camera);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ButtonTheme(
//                     height: MediaQuery.of(context).size.height * 0.2,
//                     minWidth: MediaQuery.of(context).size.width * 0.5,
//                     child: RaisedButton(
//                       disabledColor: Colors.grey,
//                       color: Colors.red,
//                       onPressed: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute<void>(
//                             builder: (context) => MyApp(),
//                           ),
//                         );
//                       },
//                       child: const Text(
//                         "Volver",
//                         style:
//                             const TextStyle(color: Colors.white, fontSize: 22),
//                       ),
//                     ),
//                   ),
//                   ButtonTheme(
//                     height: MediaQuery.of(context).size.height * 0.2,
//                     minWidth: MediaQuery.of(context).size.width * 0.5,
//                     child: RaisedButton(
//                       disabledColor: Colors.grey,
//                       color: Colors.green,
//                       onPressed: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute<void>(
//                             builder: (context) => preview(),
//                           ),
//                         );
//                       },
//                       child: const Text(
//                         "Aceptar",
//                         style: TextStyle(color: Colors.white, fontSize: 22),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ]));
//   }
// }
