import 'package:flutter/material.dart';
import 'package:sm_app_invidente/imagen.dart';
import 'package:sm_app_invidente/teclado.dart';
import 'package:sm_app_invidente/texto.dart';
import 'package:sm_app_invidente/tutorial.dart';
import 'package:sm_app_invidente/voz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

import 'package:sm_app_invidente/api/api_wrapper.dart';

void main() {
  runApp(const MyApp());
}

//Esta clase es para enseñar el menú principal, con 4 botones
//que guían a las diferentes funcionalidades de la app.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App invidentes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'APP INVIDENTES',
          style: TextStyle(fontSize: 25.0, fontFamily: 'Glacial Indifference'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 1,
                child: FloatingActionButton.extended(
                  heroTag: Text('Dictar por voz'),
                  label: Text('Dictar por voz'),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  icon: const Icon(
                    Icons.record_voice_over,
                    size: 70.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => voz(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 1,
                child: FloatingActionButton.extended(
                  heroTag: Text('Reconocimiento de texto'),
                  label: Text('Reconocimiento de texto'),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  icon: const Icon(
                    Icons.image,
                    size: 70.0,
                  ),
                  onPressed: () {
                    /*Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => imagen(),
                      ),
                    );*/
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 1,
                child: FloatingActionButton.extended(
                  heroTag: Text('Texto por teclado'),
                  label: Text('Texto por teclado'),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  icon: const Icon(
                    Icons.keyboard,
                    size: 70.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => teclado(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 1,
                child: FloatingActionButton.extended(
                  heroTag: Text('Reconocimiento por txt'),
                  label: Text('Reconocimiento por txt'),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  icon: const Icon(
                    Icons.text_snippet_outlined,
                    size: 70.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => texto(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 1,
                child: FloatingActionButton.extended(
                  heroTag: Text('Imprimir con cámara bot'),
                  label: Text('Imprimir con cámara bot'),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  icon: const Icon(
                    Icons.local_print_shop_rounded,
                    size: 70.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => TutorialScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
