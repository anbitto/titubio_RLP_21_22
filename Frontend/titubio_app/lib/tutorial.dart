import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:sm_app_invidente/globals.dart';
import 'package:sm_app_invidente/text2raspi.dart';
import 'package:sm_app_invidente/preview.dart';
import 'package:sm_app_invidente/tutorial_list_pages.dart';

class TutorialScreen extends StatefulWidget {
  TutorialScreen({Key? key}) : super(key: key);

  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  PageController pageController = PageController(initialPage: 0);
  int pageChangedInt = 0;
  double pageChangedDouble = 0.0;
  int end = 4;
  final t2r = text2raspiState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          pageSnapping: true,
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              pageChangedInt = index;
              pageChangedDouble = index.toDouble();
            });
          },
          itemCount: listPages.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: new Image.asset(listPages[pageChangedInt].imagePath,
                        scale: 3),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      listPages[pageChangedInt].title,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 40),
                      child: Text(
                        listPages[pageChangedInt].subtitle,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Align(
                    //Este es para alinear bien todos losPageview
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Visibility(
                          visible: pageChangedInt == 3,
                          child: SizedBox(
                            height: 22,
                            //child: Text("hola"),
                          )),
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 13),
                    child: DotsIndicator(
                      dotsCount: listPages.length,
                      position: pageChangedDouble,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      child: buildButton(pageChangedInt),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget buildButton(pageChangedInt) {
    return Visibility(
        visible: pageChangedInt == 2,
        maintainState: true,
        maintainAnimation: true,
        maintainSize: true,
        child: ElevatedButton(
            child: Text('Escanear'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => preview(),
                ),
              );
            }));
  }
}
