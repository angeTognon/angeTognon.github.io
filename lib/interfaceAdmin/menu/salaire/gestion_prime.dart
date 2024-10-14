// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'package:http/http.dart' as http;

class GestionPrime extends StatefulWidget {
  const GestionPrime({super.key});

  @override
  State<GestionPrime> createState() => _GestionPrimeState();
}

class _GestionPrimeState extends State<GestionPrime> {
  String currentDateString = DateFormat('dd/MM/yyyy').format(DateTime.now());
  late DateTime currentDate;
  @override
  void initState() {
    currentDate = DateFormat('dd/MM/yyyy').parse(currentDateString);
    super.initState();
  }

  getSalary() async {
    var url = "https://zoutechhub.com/pharmaRh/getSalary.php";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  void _showPopupNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 187, 64, 55),
        content: Text(
          'Veuillez Patienter la date de la prochaine prime. Nous vous notifierons 5 jours avant la dite date !',
          style: TextStyle(color: Colors.white, fontFamily: 'normal'),
        ),
        duration: Duration(seconds: 10),
        action: SnackBarAction(
          label: 'Fermer',
          onPressed: () {
            // Do something when the user dismisses the notification
          },
        ),
      ),
    );
  }

  void calculPrime1() {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: mainColor3, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Nom et Prénoms de l'employé",
                        style: TextStyle(fontFamily: 'bold', fontSize: 13),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 3,
                    color: Colors.white54,
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Date d'embauche",
                        style: TextStyle(fontFamily: 'bold', fontSize: 13),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 3,
                    color: Colors.white54,
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Salaire de Base",
                        style: TextStyle(fontFamily: 'bold', fontSize: 13),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 3,
                    color: Colors.white54,
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Salaire Brut",
                        style: TextStyle(fontFamily: 'bold', fontSize: 13),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 3,
                    color: Colors.white54,
                  ),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Date de la prochaine prime",
                        style: TextStyle(fontFamily: 'bold', fontSize: 13),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 3,
                    color: Colors.white54,
                  ),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Etat",
                        style: TextStyle(fontFamily: 'bold', fontSize: 13),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 3,
                    color: Colors.white54,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 250,
                      height: 50,
                      child: Center(
                        child: Text(
                          "Action",
                          style: TextStyle(fontFamily: 'bold', fontSize: 13),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            h(5),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              // height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: getSalary(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                          "Erreur de chargement. Veuillez relancer l'application"),
                    );
                  }
                  if (snapshot.hasData) {
                    // print(vv.text + " ddd*****dddddddddddddd");
                    return snapshot.data.isEmpty
                        ? Column(
                            children: [
                              h(20),
                              Icon(
                                Icons.safety_check_rounded,
                                size: 100,
                                color: mainColor,
                              ),
                              h(20),
                              Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  "Oups, Vous n'avez aucun employé pour l'instant ",
                                  style: TextStyle(fontSize: 17),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              DateTime dateTime =
                                  DateFormat("dd/MM/yyyy").parse("13/08/2024");
                              print(dateTime.isAfter(currentDate));

                              return Column(
                                children: [
                                  BoxUser(
                                      "${snapshot.data![index]['prenom']} ${snapshot.data![index]['nom']}",
                                      "${snapshot.data![index]['dateEmbauche']}",
                                      double.parse(
                                          "${snapshot.data![index]['salaireBase']}"),
                                      "${snapshot.data![index]['salaireBrute']}",
                                      "${snapshot.data![index]['dateEmbauche'].split('/').take(2).join('/')} /${int.parse('${snapshot.data![index]['dateEmbauche']}'.split('/').last) + 3}",
                                      currentDate.isAfter(
                                              DateFormat("dd/MM/yyyy").parse(
                                                  "${snapshot.data![index]['dateEmbauche'].split('/').take(2).join('/')}/${int.parse(snapshot.data![index]['dateEmbauche'].split('/').last) + 3}"))
                                          ? "Prêt"
                                          : "Pas Prêt"),
                                  Divider()
                                ],
                              );
                            });
                  }
                  return Center(
                      child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Lottie.asset("assets/images/anim.json")));
                },
              ),
            ),
            Divider(),
          ],
        ));
  }

  BoxUser(String nomprenom, dateEmbauche, double salaireBasic, salaireActu,
      String temprestant, etat) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 250,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: mainColor3,
                  child: Icon(
                    Icons.person,
                    color: mainColor2,
                  ),
                ),
                w(20),
                SizedBox(
                  width: 180,
                  child: Text(
                    nomprenom,
                    style: TextStyle(
                        fontFamily: 'normal',
                        color: Colors.black,
                        fontSize: 14),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            width: 3,
            color: Color.fromARGB(19, 0, 0, 0),
          ),
          SizedBox(
            width: 150,
            height: 50,
            child: Center(
              child: Text(
                dateEmbauche,
                style: TextStyle(
                    fontFamily: 'normal', color: Colors.black, fontSize: 14),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 3,
            color: Color.fromARGB(19, 0, 0, 0),
          ),
          SizedBox(
            width: 150,
            height: 50,
            child: Center(
              child: Text(
                '$salaireBasic FCFA',
                style: TextStyle(
                    fontFamily: 'normal', color: Colors.black, fontSize: 14),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 3,
            color: Color.fromARGB(19, 0, 0, 0),
          ),
          SizedBox(
            width: 150,
            height: 50,
            child: Center(
              child: Text(
                '$salaireActu FCFA',
                style: TextStyle(
                    fontFamily: 'normal', color: Colors.black, fontSize: 14),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 3,
            color: Color.fromARGB(19, 0, 0, 0),
          ),
          SizedBox(
            width: 200,
            height: 50,
            child: Center(
              child: Text(
                temprestant,
                style: TextStyle(
                    fontFamily: 'bold', color: Colors.black, fontSize: 14),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 3,
            color: Color.fromARGB(19, 0, 0, 0),
          ),
          Container(
            height: 50,
            width: 3,
            color: Colors.white54,
          ),
          Container(
            //DateTime dateTime = DateFormat("dd/MM/yyyy").parse("13/08/2024");
            color: currentDate.isAfter(DateFormat("dd/MM/yyyy").parse(
                    "${dateEmbauche.split('/').take(2).join('/')}/${int.parse(dateEmbauche.split('/').last) + 3}"))
                //etat == "Prêt"
                ? Color.fromARGB(221, 31, 178, 23)
                : const Color.fromARGB(221, 178, 23, 23),
            width: 100,
            height: 50,
            child: Center(
              child: Text(
                etat,
                style: TextStyle(
                    fontFamily: 'normal', color: Colors.white, fontSize: 14),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 3,
            color: Color.fromARGB(19, 0, 0, 0),
          ),
          Expanded(
            child: SizedBox(
                width: 150,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            padding: EdgeInsets.all(15)),
                        onPressed: () {
                          etat == "Pas Prêt"
                              ? _showPopupNotification()
                              : showDialog(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (context, setState) =>
                                          AlertDialog(
                                        backgroundColor: Colors.white,
                                        content: Container(
                                          padding: EdgeInsets.all(10),
                                          height: (MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2.6),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Calcul Automatique de la Prime",
                                                style: TextStyle(
                                                    fontFamily: 'bold',
                                                    color: Colors.black,
                                                    fontSize: 17),
                                                textAlign: TextAlign.center,
                                              ),
                                              Divider(),
                                              h(15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Date d'embauche : ",
                                                        style: TextStyle(
                                                            fontFamily: 'bold',
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      w(15),
                                                      Container(
                                                        height: 30,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15,
                                                                right: 15),
                                                        decoration: BoxDecoration(
                                                            color: mainColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Center(
                                                          child: Text(
                                                            "$dateEmbauche",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'bold',
                                                                color: const Color
                                                                    .fromARGB(
                                                                    221,
                                                                    251,
                                                                    251,
                                                                    251),
                                                                fontSize: 14),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Nombre d'année : ",
                                                        style: TextStyle(
                                                            fontFamily: 'bold',
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      Container(
                                                        height: 30,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                right: 10),
                                                        decoration: BoxDecoration(
                                                            color: mainColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Center(
                                                          child: Text(
                                                            " 3 ans",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'bold',
                                                                color: const Color
                                                                    .fromARGB(
                                                                    221,
                                                                    255,
                                                                    255,
                                                                    255),
                                                                fontSize: 14),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              h(25),
                                              Text(
                                                " Pourcentage de Prime : 3% ",
                                                style: TextStyle(
                                                    fontFamily: 'bold',
                                                    color: Colors.black87,
                                                    fontSize: 14),
                                                textAlign: TextAlign.center,
                                              ),
                                              h(25),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        " Salaire de base(Avant Prime) :",
                                                        style: TextStyle(
                                                            fontFamily: 'bold',
                                                            color: mainColor,
                                                            fontSize: 14),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      h(10),
                                                      Text(
                                                        "$salaireBasic FCFA",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'normal',
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 15),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        " Salaire Brute (Après Prime) :",
                                                        style: TextStyle(
                                                            fontFamily: 'bold',
                                                            color: mainColor,
                                                            fontSize: 14),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      h(10),
                                                      Text(
                                                        "${salaireBasic + (salaireBasic * 0.03)} FCFA",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'normal',
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 15),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              h(20),
                                              InkWell(
                                                onTap: () {
                                                  setState(
                                                    () {
                                                      salaireActu =
                                                          salaireBasic +
                                                              (salaireBasic *
                                                                  0.03);
                                                      print(salaireActu);
                                                      etat = "Pas Prêt";
                                                    },
                                                  );

                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  height: 40,
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      color: mainColor2),
                                                  child: Center(
                                                    child: Text(
                                                      "Confirmer",
                                                      style: TextStyle(
                                                          fontFamily: 'normal',
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                        },
                        child: Text(
                          "Ajouter prime",
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'normal'),
                        ))
                  ],
                )),
          ),
          Container(
            height: 50,
            width: 3,
            color: Color.fromARGB(19, 0, 0, 0),
          ),
        ],
      ),
    );
  }
}
