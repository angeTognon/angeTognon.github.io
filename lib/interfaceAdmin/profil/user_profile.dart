// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:convert';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zth_app/interfaceAdmin/home.dart';
import 'package:zth_app/interfaceAdmin/menu/accueil.dart';
import 'package:zth_app/interfaceAdmin/menu/message/chat.dart';
import 'package:zth_app/interfaceAdmin/menu/planning/planning.dart';
import 'package:zth_app/interfaceAdmin/menu/pr%C3%A9sence/presence.dart';
import 'package:zth_app/interfaceAdmin/menu/rh.dart';
import 'package:zth_app/interfaceAdmin/menu/salaire/salaire.dart';
import 'package:zth_app/interfaceAdmin/menu/salaire/settings.dart';
import 'package:zth_app/interfaceAdmin/menu/sanctions/sanction.dart';
import 'package:zth_app/interfaceEmploy%C3%A9/presences.dart';
import 'package:zth_app/main.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'dart:js' as js;
import 'package:http/http.dart' as http;

class UserProfile extends StatefulWidget {
  String name;
  String post;
  String dateNaissance;
  String phone;
  String mail;
  String dateEmbauche;
  String groupeSanguin;
  String ville;
  String quartier;
  String contactProche;
  String niveauHierachique;
  String salaireBase;
  String cv;
  String contrat;
  String certificat;
  String fiche;
  String salaireBrute;
  dynamic archiver;
  int id;

  UserProfile({
    super.key,
    required this.name,
    required this.post,
    required this.dateNaissance,
    required this.phone,
    required this.mail,
    required this.groupeSanguin,
    required this.ville,
    required this.quartier,
    required this.niveauHierachique,
    required this.contactProche,
    required this.salaireBase,
    required this.dateEmbauche,
    required this.cv,
    required this.contrat,
    required this.certificat,
    required this.fiche,
    required this.archiver,
    required this.id,
    required this.salaireBrute,
  });

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Map<String, double> dataMap = {
    "Nombre de Jours de congés pris": 2,
    "Nombre de jours de Congés restants": 22,
  };
  final ordinalGroup = [
    OrdinalGroup(
      color: mainColor,
      id: '1',
      data: [
        OrdinalData(
          domain: 'Janvier',
          measure: 3,
        ),
        OrdinalData(domain: 'Février', measure: 0),
        OrdinalData(domain: 'Mars', measure: 0),
        OrdinalData(domain: 'Avril', measure: 2),
        OrdinalData(domain: 'Mai', measure: 0),
        OrdinalData(domain: 'Juin', measure: 8),
        OrdinalData(domain: 'Juillet', measure: 6.5),
      ],
    ),
  ];
  @override
  void initState() {
    setState(() {
      rh = false;
    });
    // TODO: implement initState
    super.initState();
  }

  deleteSalary(int id) async {
    setState(() {
      show = true;
    });
    var url = "https://zoutechhub.com/pharmaRh/deleteSalary.php?id=$id";
    var response = await http.post(Uri.parse(url));
    print(response.body);
    print(response.statusCode);
    if (response.body == "OK") {
      setState(() {
        show = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 18, 133, 22),
          content: Text(
            "Supression Réussie.",
            style: TextStyle(
              fontFamily: 'normal',
              color: Colors.white,
            ),
          )));
      //Navigator.pop(context);
    } else {
      setState(() {
        show = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Erreur. Veuillez actualiser la page",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));
      });
    }
  }

  bool show = false;
  archiver(int id) async {
    setState(() {
      show = true;
    });
    var url = "https://zoutechhub.com/pharmaRh/archiver.php?id=$id";
    var response = await http.post(Uri.parse(url));
    print(response.body);
    print(response.statusCode);
    if (response.body == "OK") {
      setState(() {
        show = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 18, 133, 22),
          content: Text(
            "Archivage Réussie",
            style: TextStyle(
              fontFamily: 'normal',
              color: Colors.white,
            ),
          )));
      rh = true;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ));
    } else {
      setState(() {
        show = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "Erreur. Veuillez actualiser la page",
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          )));
    }
  }

  desarchiver(int id) async {
    setState(() {
      show = true;
    });
    var url = "https://zoutechhub.com/pharmaRh/desarchiver.php?id=$id";
    var response = await http.post(Uri.parse(url));
    print(response.body);
    print(response.statusCode);
    if (response.body == "OK") {
      setState(() {
        show = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 18, 133, 22),
          content: Text(
            "Archivage Réussie",
            style: TextStyle(
              fontFamily: 'normal',
              color: Colors.white,
            ),
          )));
    } else {
      setState(() {
        show = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "Erreur. Veuillez actualiser la page",
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          )));
    }
  }

  final String _selectedValue = 'Type de Document';
  String fileName_ = "";
  /* Future<bool> uploadFileToServer(String username) async {
    setState(() {
      show = true;
    });
    try {
      if (result != null && result.files.isNotEmpty) {
        file = result.files.single;
        final bytes = file.bytes;
        if (bytes != null) {
          final uri = Uri.parse(
              'https://zoutechhub.com/pharmaRh/ajouterDocSalary.php?folder=$username');
          final request = http.MultipartRequest('POST', uri);
          request.files.add(
              http.MultipartFile.fromBytes('file', bytes, filename: fileName_));
          final response = await request.send();
          final responseData = await response.stream.bytesToString();
          final jsonResponse = jsonDecode(responseData);

          if (response.statusCode == 200 && !jsonResponse['error']) {
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Color.fromARGB(255, 18, 133, 22),
                  content: Text(
                    "Ajout Réussi",
                    style: TextStyle(
                      fontFamily: 'normal',
                      color: Colors.white,
                    ),
                  )));
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ));
            });
            return true;
          } else {
            print('Error uploading file: ${jsonResponse['msg']}');
            return false;
          }
        } else {
          print('No file selected');
          return false;
        }
      } else {
        print('No file selected');
        return false;
      }
    } catch (e) {
      setState(() {
        show = false;
      });

      print('Error uploading file: $e');
      return false;
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Row(
          children: [
            MenuPrincipal(),
            accueil
                ? Accueil()
                : planning
                    ? Planning()
                    : salaire
                        ? Salaire()
                        : sanction
                            ? GestionPleinBlame()
                            : presence
                                ? Presence()
                                : rh
                                    ? RH()
                                    : actualite
                                        ? ChatScreen()
                                        : parametre
                                            ? Settings()
                                            : SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Card(
                                                      elevation: 3,
                                                      color: Colors.white,
                                                      child: SizedBox(
                                                        height: 230,
                                                        width: ((MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    10) /
                                                                12) -
                                                            10,
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 200,
                                                                      top: 40,
                                                                      right:
                                                                          40),
                                                              height: 115,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                widget.name,
                                                                                style: TextStyle(fontFamily: 'bold', color: Colors.white, fontSize: 22),
                                                                              ),
                                                                              w(20),
                                                                              Text(
                                                                                "#25597AHJB876",
                                                                                style: TextStyle(fontFamily: 'normal', color: Colors.white, fontSize: 15),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Text(
                                                                            widget.post,
                                                                            style: TextStyle(
                                                                                fontFamily: 'normal',
                                                                                color: Colors.white,
                                                                                fontSize: 15),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.end,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.cake,
                                                                                    color: const Color.fromARGB(182, 255, 255, 255),
                                                                                  ),
                                                                                  w(5),
                                                                                  Text(
                                                                                    widget.dateNaissance,
                                                                                    style: TextStyle(fontFamily: 'normal', color: const Color.fromARGB(182, 255, 255, 255), fontSize: 14),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Row(
                                                                                    children: [
                                                                                      Icon(
                                                                                        Icons.phone,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                      w(5),
                                                                                      Text(
                                                                                        widget.phone,
                                                                                        style: TextStyle(fontFamily: 'normal', color: Colors.white, fontSize: 14),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  w(20),
                                                                                  Row(
                                                                                    children: [
                                                                                      Icon(
                                                                                        Icons.mail,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                      w(5),
                                                                                      Text(
                                                                                        widget.mail,
                                                                                        style: TextStyle(fontFamily: 'normal', color: Colors.white, fontSize: 14),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              width: ((MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          10) /
                                                                      12) -
                                                                  3,
                                                              color: mainColor2,
                                                            ),
                                                            Positioned(
                                                              bottom: 0,
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            200,
                                                                        top: 20,
                                                                        right:
                                                                            40),
                                                                height: 115,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(
                                                                              width: (MediaQuery.of(context).size.width) / 1.5,
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(
                                                                                    "CDI - Du ${widget.dateEmbauche} à ce jour",
                                                                                    style: TextStyle(fontFamily: 'normal', color: const Color.fromARGB(255, 0, 0, 0), fontSize: 15),
                                                                                  ),
                                                                                  Row(
                                                                                    children: [
                                                                                      show
                                                                                          ? CircularProgressIndicator()
                                                                                          : InkWell(
                                                                                              onTap: () {
                                                                                                archiver(widget.id);
                                                                                              },
                                                                                              child: Container(
                                                                                                height: 35,
                                                                                                width: 170,
                                                                                                decoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(10)),
                                                                                                child: Center(
                                                                                                  child: Text(
                                                                                                    "Archiver",
                                                                                                    style: TextStyle(fontFamily: 'bold', color: Colors.white),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                      w(20),
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          deleteSalary(widget.id);
                                                                                        },
                                                                                        child: Container(
                                                                                          padding: EdgeInsets.only(left: 15, right: 15),
                                                                                          height: 35,
                                                                                          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: mainColor), borderRadius: BorderRadius.circular(10)),
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              "Supprimer",
                                                                                              style: TextStyle(fontFamily: 'bold', color: const Color.fromARGB(255, 0, 0, 0)),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                width: ((MediaQuery.of(context).size.width *
                                                                            10) /
                                                                        12) -
                                                                    3,
                                                              ),
                                                            ),
                                                            Positioned(
                                                              top: 40,
                                                              left: 40,
                                                              child: Container(
                                                                height: 150,
                                                                width: 150,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
                                                                    image: DecorationImage(
                                                                        image: AssetImage(
                                                                            "assets/images/ANGE.jpg"),
                                                                        fit: BoxFit
                                                                            .cover)),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              left: 20,
                                                              top: 20,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    rh = true;
                                                                  });
                                                                },
                                                                child: Icon(
                                                                  size: 34,
                                                                  Icons
                                                                      .arrow_back,
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      255),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    h(10),
                                                    SizedBox(
                                                      height: 400,
                                                      width: ((MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  10) /
                                                              12) -
                                                          3,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Card(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  240,
                                                                  240,
                                                                  240),
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            20),
                                                                height: 400,
                                                                width: 550,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "Informations personnelles",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'bold',
                                                                          fontSize:
                                                                              17,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    h(20),
                                                                    Container(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      "1- Nom & prénoms",
                                                                                      style: TextStyle(fontFamily: 'bold', fontSize: 14, color: Colors.black54),
                                                                                    ),
                                                                                    h(5),
                                                                                    Container(
                                                                                      width: 230,
                                                                                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                                                                      // padding: EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                                                                      child: Text(
                                                                                        widget.name,
                                                                                        style: TextStyle(fontFamily: 'bold', fontSize: 13, color: Colors.black87),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              h(15),
                                                                              Container(
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      "2- Groupe Sanguin",
                                                                                      style: TextStyle(fontFamily: 'bold', fontSize: 14, color: Colors.black54),
                                                                                    ),
                                                                                    h(5),
                                                                                    Container(
                                                                                      width: 230,
                                                                                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                                                                      // padding: EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                                                                      child: Text(
                                                                                        widget.groupeSanguin,
                                                                                        style: TextStyle(fontFamily: 'bold', fontSize: 13, color: Colors.black87),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              h(15),
                                                                              Container(
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      "3- Ville",
                                                                                      style: TextStyle(fontFamily: 'bold', fontSize: 14, color: Colors.black54),
                                                                                    ),
                                                                                    h(5),
                                                                                    Container(
                                                                                      width: 230,
                                                                                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                                                                      // padding: EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                                                                      child: Text(
                                                                                        widget.ville,
                                                                                        style: TextStyle(fontFamily: 'bold', fontSize: 13, color: Colors.black87),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              h(15),
                                                                              Container(
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      "4- Quartier",
                                                                                      style: TextStyle(fontFamily: 'bold', fontSize: 14, color: Colors.black54),
                                                                                    ),
                                                                                    h(5),
                                                                                    Container(
                                                                                      width: 230,
                                                                                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                                                                      child: Text(
                                                                                        widget.quartier,
                                                                                        style: TextStyle(fontFamily: 'bold', fontSize: 13, color: Colors.black87),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      "5- Contact d'un Proche",
                                                                                      style: TextStyle(fontFamily: 'bold', fontSize: 14, color: Colors.black54),
                                                                                    ),
                                                                                    h(5),
                                                                                    Container(
                                                                                      width: 230,
                                                                                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                                                                      // padding: EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                                                                      child: Text(
                                                                                        widget.contactProche,
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'bold',
                                                                                          color: Colors.black87,
                                                                                          fontSize: 13,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              h(15),
                                                                              Container(
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      "6- Niveau hiérachique",
                                                                                      style: TextStyle(fontFamily: 'bold', fontSize: 14, color: Colors.black54),
                                                                                    ),
                                                                                    h(5),
                                                                                    Container(
                                                                                      width: 230,
                                                                                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                                                                      // padding: EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                                                                      child: Text(
                                                                                        widget.niveauHierachique,
                                                                                        style: TextStyle(
                                                                                          color: Colors.black87,
                                                                                          fontFamily: 'bold',
                                                                                          fontSize: 13,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              h(15),
                                                                              Container(
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      "7- Salaire de base",
                                                                                      style: TextStyle(fontFamily: 'bold', fontSize: 14, color: Colors.black54),
                                                                                    ),
                                                                                    h(5),
                                                                                    Container(
                                                                                      width: 230,
                                                                                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                                                                      // padding: EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                                                                      child: Text(
                                                                                        "${widget.salaireBase} FCFA",
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'bold',
                                                                                          color: Colors.black87,
                                                                                          fontSize: 13,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              h(15),
                                                                              Container(
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      "8- Salaire brut",
                                                                                      style: TextStyle(fontFamily: 'bold', fontSize: 14, color: Colors.black54),
                                                                                    ),
                                                                                    h(5),
                                                                                    Container(
                                                                                      width: 230,
                                                                                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                                                                      // padding: EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                                                                      child: Text(
                                                                                        "${widget.salaireBrute} FCFA",
                                                                                        style: TextStyle(fontFamily: 'bold', fontSize: 13, color: Colors.black87),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Card(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  240,
                                                                  240,
                                                                  240),
                                                              surfaceTintColor:
                                                                  Colors.white,
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            20),
                                                                height: 400,
                                                                width: 550,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "Gestion des dossiers employé",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'bold',
                                                                          fontSize:
                                                                              17,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    h(20),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            widget.cv == ""
                                                                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                    backgroundColor: Color.fromARGB(255, 106, 15, 15),
                                                                                    content: Text(
                                                                                      "Veuillez d'abord ajouter un document",
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'normal',
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                    )))
                                                                                : js.context.callMethod('open', [widget.cv]);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                130,
                                                                            width:
                                                                                130,
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                "CV",
                                                                                style: TextStyle(fontSize: 15, fontFamily: 'bold', color: Colors.white),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            ),
                                                                            decoration: BoxDecoration(
                                                                                gradient: LinearGradient(begin: Alignment.topLeft, colors: [
                                                                                  Colors.black54,
                                                                                  mainColor2
                                                                                ]),
                                                                                borderRadius: BorderRadius.circular(10)),
                                                                          ),
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            widget.contrat == ""
                                                                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                    backgroundColor: Color.fromARGB(255, 106, 15, 15),
                                                                                    content: Text(
                                                                                      "Veuillez d'abord ajouter un document",
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'normal',
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                    )))
                                                                                : js.context.callMethod('open', [widget.contrat]);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                130,
                                                                            width:
                                                                                130,
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                "Contrat",
                                                                                style: TextStyle(fontSize: 15, fontFamily: 'bold', color: Colors.white),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            ),
                                                                            decoration: BoxDecoration(
                                                                                gradient: LinearGradient(begin: Alignment.topLeft, colors: const [
                                                                                  Colors.black54,
                                                                                  // mainColor,
                                                                                  Colors.red
                                                                                ]),
                                                                                borderRadius: BorderRadius.circular(10)),
                                                                          ),
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {},
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                130,
                                                                            width:
                                                                                130,
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                "Diplômes/Certificat",
                                                                                style: TextStyle(fontSize: 15, fontFamily: 'bold', color: Colors.white),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            ),
                                                                            decoration: BoxDecoration(
                                                                                gradient: LinearGradient(begin: Alignment.topLeft, colors: const [
                                                                                  // mainColor,
                                                                                  Colors.black54,
                                                                                  Color.fromARGB(255, 255, 128, 64)
                                                                                ]),
                                                                                borderRadius: BorderRadius.circular(10)),
                                                                          ),
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            widget.certificat == ""
                                                                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                    backgroundColor: Color.fromARGB(255, 106, 15, 15),
                                                                                    content: Text(
                                                                                      "Veuillez d'abord ajouter un document",
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'normal',
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                    )))
                                                                                : js.context.callMethod('open', [widget.certificat]);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                130,
                                                                            width:
                                                                                130,
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                "Visites médicales",
                                                                                style: TextStyle(fontSize: 15, fontFamily: 'bold', color: Colors.white),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            ),
                                                                            decoration: BoxDecoration(
                                                                                gradient: LinearGradient(begin: Alignment.topLeft, colors: const [
                                                                                  // mainColor,
                                                                                  Colors.black54,
                                                                                  Colors.purple
                                                                                ]),
                                                                                borderRadius: BorderRadius.circular(10)),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    h(20),
                                                                    Expanded(
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            550,
                                                                        padding:
                                                                            EdgeInsets.all(10),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius: BorderRadius.circular(10)),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              child: Text(
                                                                                "Demandes à Valider",
                                                                                style: TextStyle(color: mainColor, fontFamily: 'bold'),
                                                                              ),
                                                                            ),
                                                                            h(15),
                                                                            Container(
                                                                              height: 40,
                                                                              decoration: BoxDecoration(color: grey, borderRadius: BorderRadius.circular(10)),
                                                                              padding: EdgeInsets.all(10),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text("Demande de congé"),
                                                                                  Container(
                                                                                    height: 25,
                                                                                    width: 25,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.white,
                                                                                      borderRadius: BorderRadius.circular(5),
                                                                                    ),
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        "2",
                                                                                        style: TextStyle(fontFamily: 'bold', color: mainColor),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            h(15),
                                                                            Container(
                                                                              height: 40,
                                                                              decoration: BoxDecoration(color: grey, borderRadius: BorderRadius.circular(10)),
                                                                              padding: EdgeInsets.all(10),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text("Demande d'absence"),
                                                                                  Container(
                                                                                    height: 25,
                                                                                    width: 25,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.white,
                                                                                      borderRadius: BorderRadius.circular(5),
                                                                                    ),
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        "1",
                                                                                        style: TextStyle(fontFamily: 'bold', color: mainColor),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Divider(),
                                                    SizedBox(
                                                      height: 400,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Historique des absences",
                                                                style: TextStyle(
                                                                    color:
                                                                        mainColor,
                                                                    fontFamily:
                                                                        'bold',
                                                                    fontSize:
                                                                        17),
                                                              ),
                                                              SizedBox(
                                                                height: 500,
                                                                width: 500,
                                                                child: Column(
                                                                  children: [
                                                                    AspectRatio(
                                                                      aspectRatio:
                                                                          16 /
                                                                              9,
                                                                      child:
                                                                          DChartBarO(
                                                                        areaColor: (group,
                                                                            ordinalData,
                                                                            index) {
                                                                          if (ordinalData ==
                                                                              10) {
                                                                            mainColor;
                                                                          }
                                                                          return null;
                                                                        },
                                                                        groupList:
                                                                            ordinalGroup,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          w(100),
                                                          Column(
                                                            children: [
                                                              Text(
                                                                "Historique des congés",
                                                                style: TextStyle(
                                                                    color:
                                                                        mainColor,
                                                                    fontFamily:
                                                                        'bold',
                                                                    fontSize:
                                                                        17),
                                                              ),
                                                              PieChart(
                                                                dataMap:
                                                                    dataMap,
                                                                animationDuration:
                                                                    Duration(
                                                                        milliseconds:
                                                                            800),
                                                                chartLegendSpacing:
                                                                    32,
                                                                chartRadius:
                                                                    260,
                                                                colorList: [
                                                                  Color
                                                                      .fromARGB(
                                                                          219,
                                                                          185,
                                                                          28,
                                                                          28),
                                                                  mainColor2,
                                                                ],
                                                                initialAngleInDegree:
                                                                    0,
                                                                ringStrokeWidth:
                                                                    32,
                                                                legendOptions:
                                                                    LegendOptions(
                                                                  showLegendsInRow:
                                                                      false,
                                                                  legendPosition:
                                                                      LegendPosition
                                                                          .right,
                                                                  showLegends:
                                                                      true,
                                                                  legendTextStyle:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                chartValuesOptions:
                                                                    ChartValuesOptions(
                                                                  showChartValueBackground:
                                                                      true,
                                                                  showChartValues:
                                                                      true,
                                                                  showChartValuesInPercentage:
                                                                      false,
                                                                  showChartValuesOutside:
                                                                      false,
                                                                ),
                                                                // gradientList: ---To add gradient colors---
                                                                // emptyColorGradient: ---Empty Color gradient---
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
          ],
        ),
      ),
    );
  }

  MenuPrincipal() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          width: (MediaQuery.of(context).size.width * 2) / 12,
          decoration: BoxDecoration(
            color: Colors
                .white, /*  boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ] */
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                h(10),
                SizedBox(
                  width: (MediaQuery.of(context).size.width * 2) / 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "PharmaRH",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'bold',
                            fontSize: 23),
                      ),
                      w(12),
                      SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.asset("assets/images/p.png"))
                    ],
                  ),
                ),
                Divider(),
                h(5),
                Container(
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: accueil ? mainColor : mainColor4),
                  child: InkWell(
                    onTap: () => setState(() {
                      accueil = true;
                      planning = false;
                      salaire = false;
                      sanction = false;
                      presence = false;
                      rh = false;
                      actualite = false;
                      parametre = false;
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(
                                  Icons.dashboard,
                                  color: accueil
                                      ? Colors.white
                                      : const Color.fromARGB(255, 0, 0, 0),
                                )),
                            w(10),
                            Text(
                              "Tableau de Bord",
                              style: TextStyle(
                                fontFamily: 'bold',
                                fontSize: 14,
                                color: accueil ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: mainColor,
                        )
                      ],
                    ),
                  ),
                ),
                h(20),
                Container(
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: rh ? mainColor : mainColor4
                      //color: Color.fromARGB(17, 0, 0, 0)
                      ),
                  child: InkWell(
                    onTap: () => setState(() {
                      accueil = false;
                      planning = false;
                      salaire = false;
                      sanction = false;
                      presence = false;
                      rh = true;
                      actualite = false;
                      parametre = false;
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 35,
                                width: 35,
                                child: Icon(
                                  Icons.person,
                                  color: rh ? Colors.white : Colors.black,
                                )),
                            w(10),
                            Text(
                              "RH",
                              style: TextStyle(
                                fontFamily: 'bold',
                                fontSize: 14,
                                color: rh ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                h(20),
                Container(
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: planning ? mainColor : mainColor4
                      //color: Color.fromARGB(17, 0, 0, 0)
                      ),
                  child: InkWell(
                    onTap: () => setState(() {
                      accueil = false;
                      planning = true;
                      salaire = false;
                      sanction = false;
                      presence = false;
                      rh = false;
                      actualite = false;
                      parametre = false;
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(
                                  Icons.edit_calendar,
                                  color: planning ? Colors.white : Colors.black,
                                )),
                            w(10),
                            Text(
                              "Planning",
                              style: TextStyle(
                                fontFamily: 'bold',
                                fontSize: 14,
                                color: planning ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                h(20),
                Container(
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: salaire ? mainColor : mainColor4
                      //color: Color.fromARGB(17, 0, 0, 0)
                      ),
                  child: InkWell(
                    onTap: () => setState(() {
                      accueil = false;
                      planning = false;
                      salaire = true;
                      sanction = false;
                      presence = false;
                      rh = false;
                      actualite = false;
                      parametre = false;
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 35,
                                width: 35,
                                child: Icon(
                                  Icons.account_balance_wallet,
                                  color: salaire ? Colors.white : Colors.black,
                                )),
                            w(10),
                            Text(
                              "Salaire",
                              style: TextStyle(
                                fontFamily: 'bold',
                                fontSize: 14,
                                color: salaire ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                h(20),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: sanction ? mainColor : mainColor4
                      //color: Color.fromARGB(17, 0, 0, 0)
                      ),
                  child: InkWell(
                    onTap: () => setState(() {
                      accueil = false;
                      planning = false;
                      salaire = false;
                      sanction = true;
                      presence = false;
                      rh = false;
                      actualite = false;
                      parametre = false;
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 35,
                                width: 35,
                                child: Icon(
                                  Icons.add_chart_rounded,
                                  color: sanction ? Colors.white : Colors.black,
                                )),
                            w(10),
                            Text(
                              "Sanctions",
                              style: TextStyle(
                                fontFamily: 'bold',
                                fontSize: 14,
                                color: sanction ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                h(20),
                Container(
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: presence ? mainColor : mainColor4
                      //color: Color.fromARGB(17, 0, 0, 0)
                      ),
                  child: InkWell(
                    onTap: () => setState(() {
                      accueil = false;
                      planning = false;
                      salaire = false;
                      sanction = false;
                      presence = true;
                      rh = false;
                      actualite = false;
                      parametre = false;
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 35,
                                width: 35,
                                child: Icon(
                                  Icons.timelapse_sharp,
                                  color: presence ? Colors.white : Colors.black,
                                )),
                            w(10),
                            Text(
                              "Présences",
                              style: TextStyle(
                                fontFamily: 'bold',
                                fontSize: 14,
                                color: presence ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                /* h(20),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 230, 230, 230)),
                  child: InkWell(
                    onTap: () => setState(() {
                      setState(() {
                        accueil = false;
                        planning = false;
                        salaire = false;
                        sanction = false;
                        presence = false;
                        rh = false;
                        actualite = false;
                        parametre = true;
                      });
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(
                                  Icons.person_pin,
                                  color: Colors.black,
                                )),
                            w(10),
                            Text(
                              "Mon Compte",
                              style: TextStyle(
                                fontFamily: 'bold',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ), */
                h(20),
                Container(
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: mainColor4),
                  child: InkWell(
                    onTap: () => setState(() {}),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(
                                  Icons.accessibility_sharp,
                                  color: Colors.black,
                                )),
                            w(10),
                            Text(
                              "Service client",
                              style: TextStyle(
                                fontFamily: 'bold',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                h(20),
                Container(
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 255, 0, 0)),
                  child: InkWell(
                    onTap: () => setState(() async {
                      final prefs = await SharedPreferences.getInstance();
                      eya = false;
                      prefs.setBool('isConnected', eya);

                      Phoenix.rebirth(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor:
                              const Color.fromARGB(255, 11, 71, 13),
                          content: Text(
                            "Déconnexion réussie",
                            style: TextStyle(
                                fontFamily: 'normal2', color: Colors.white),
                          )));
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(
                                  Icons.power_settings_new_rounded,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                )),
                            w(10),
                            Text(
                              "Déconnexion",
                              style: TextStyle(
                                fontFamily: 'bold',
                                fontSize: 14,
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                /* h(45),
                InkWell(
                  onTap: () => setState(() {accueil=false;rh=false;planning=true;salaire=false;presence=false;}),
                  child: Column(
                    children: [
                      Container(
                          height: 40,
                          width: 40,
                          child: Image.asset("assets/images/planning_icon.png")),
                      Text(
                        "Planning",
                        style: TextStyle(
                          fontFamily: 'normal',
                          fontSize: 14,
                          color: mainColor,
                        ),
                      )
                    ],
                  ),
                ),
                h(45),
                InkWell(
                  onTap: () => setState(() {accueil=false;rh=false;planning=false;salaire=true;presence=false;}),
                  child: Column(
                    children: [
                      Container(
                          height: 40,
                          width: 40,
                          child: Image.asset("assets/images/money-icon.png")),
                      Text(
                        "Salaires",
                        style: TextStyle(
                          fontFamily: 'normal',
                          fontSize: 13,
                          color: mainColor,
                        ),
                      )
                    ],
                  ),
                ), */
                /* h(45),
                InkWell(
                  onTap: () => setState(() {accueil=false;rh=false;planning=false;salaire=false;presence=true;}),
                  child: Column(
                    children: [
                      Container(
                          height: 40,
                          width: 40,
                          child: Image.asset("assets/images/presence_icon.png")),
                      Text(
                        "Présences",
                        style: TextStyle(
                          fontFamily: 'normal',
                          fontSize: 13,
                          color: mainColor,
                        ),
                      )
                    ],
                  ),
                ),
                h(45),
                InkWell(
                  onTap: () => setState(() {accueil=false;rh=true;planning=false;}),
                  child: Column(
                    children: [
                      Container(
                          height: 40,
                          width: 40,
                          child: Image.asset("assets/images/people_icon.png")),
                      Text(
                        "RH",
                        style: TextStyle(
                          fontFamily: 'normal',
                          fontSize: 13,
                          color: mainColor,
                        ),
                      )
                    ],
                  ),
                ), */
                /* h(45),
                Column(
                  children: [
                    Container(
                        height: 40,
                        width: 40,
                        child: Image.asset("assets/images/news_icon.png")),
                    Text(
                      "Actualités",
                      style: TextStyle(
                        fontFamily: 'normal',
                        fontSize: 13,
                        color: mainColor,
                      ),
                    )
                  ],
                ), */
                /* h(45),
                Column(
                  children: [
                    Container(
                        height: 40,
                        width: 40,
                        child: Image.asset("assets/images/more_icon.png")),
                    Text(
                      "Plus",
                      style: TextStyle(
                        fontFamily: 'normal',
                        fontSize: 13,
                        color: mainColor,
                      ),
                    )
                  ],
                ), */
              ],
            ),
          ),
        ),
        Container(
          color: Colors.grey,
          height: MediaQuery.of(context).size.height,
          width: 1.3,
        )
      ],
    );
  }
}
