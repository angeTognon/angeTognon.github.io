import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

bool accueil = true;
bool planning = false;
bool salaire = false;
bool sanction = false;
bool presence = false;
bool rh = false;
bool actualite = false;
bool parametre = false;

bool statu1 = false;
bool statu2 = false;
bool statu3 = false;
bool statu4 = false;

h(double h) {
  return SizedBox(
    height: h,
  );
}

w(double w) {
  return SizedBox(
    width: w,
  );
}

String generateRandomCode() {
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();
  return String.fromCharCodes(
    Iterable.generate(
      6,
      (_) => chars.codeUnitAt(
        random.nextInt(chars.length),
      ),
    ),
  );
}

String receveur = "";
String codee = "";
String user_name = "";

Color txtDesc = const Color.fromARGB(166, 0, 0, 0);
Color mainColor = const Color(0xFF0a9c08);
Color grey = const Color.fromARGB(255, 230, 230, 230);
//Color mainColor = Color.fromARGB(255, 0, 112, 160);
Color mainColor__ = const Color.fromARGB(16, 7, 65, 173);
Color amainColor__ = const Color.fromARGB(16, 7, 65, 173);
Color mainColor2__ = const Color.fromARGB(255, 7, 65, 173);
// Color mainColor = Color.fromARGB(255, 0, 136, 20);
Color mainColor2 =
    const Color.fromARGB(255, 5, 127, 180); //Color.fromARGB(73, 42, 116, 100)
Color mainColor3 = const Color.fromARGB(73, 42, 116, 100); //
Color mainColor4 = const Color.fromARGB(33, 42, 116, 100); //
Color mainColor5 = const Color.fromARGB(255, 7, 65, 173); //

MAB(BuildContext context) {
  return AppBar(
    backgroundColor: const Color.fromARGB(255, 42, 116, 100),
    title: const Text(
      "PharmaRH",
      style: TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 20,
        fontFamily: 'bold',
      ),
    ),
    actions: [
      const Text(
        "Aide",
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'normal',
        ),
      ),
      w(15),
      CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        child: Image.asset("assets/images/notif_icon.png"),
      ),
      w(15)
    ],
  );
}
