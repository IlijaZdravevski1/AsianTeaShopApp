import 'package:AsianTea/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../custom/custom_app_bar.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen();

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<InfoScreen> {
  TextEditingController controller = TextEditingController();

  _InfoState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8BFD8),
      appBar: CustomAppBar(appBar: AppBar(), widgets: [
        Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 30.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Icon(
                    Icons.account_circle,
                    size: 30.0,
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
            ))
      ],
      ),
      body: Container(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.07, 20, 0),
              child: Column(children: <Widget>[
                const Text(
                  "About us",
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
                SizedBox(height: 40),
                 // QrImage(
                 //   data:
                 //   "https://thechineseteashop.com/",
                 //   size: 250,
                 //   gapless: true,
                 //   version: QrVersions.auto,
                 //   foregroundColor: const Color(0xFF7B5B36),
                 //   backgroundColor: const Color(0xFFFFFFFF),
                 //   eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.circle),
                 // ),
                SizedBox(height: 50),
                const Text(
                  "we are an online store that offers a wide range of teas of Asian origin."
                      " our teas are 100% original.",
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ]))),
    );
  }
}
