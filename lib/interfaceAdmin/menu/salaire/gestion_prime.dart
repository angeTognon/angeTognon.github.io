// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zth_app/widgets/wid_var.dart';

class GestionPrime extends StatefulWidget {
  const GestionPrime({super.key});

  @override
  State<GestionPrime> createState() => _GestionPrimeState();
}

class _GestionPrimeState extends State<GestionPrime> {
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
    return Container(
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
                  Container(
                    width: 250,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Nom et Prénoms de l'employé",
                        style: TextStyle(
                            fontFamily: 'bold',
                            fontSize: 13),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 3,
                    color: Colors.white54,
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Date d'embauche",
                        style: TextStyle(
                            fontFamily: 'bold',
                            fontSize: 13),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 3,
                    color: Colors.white54,
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Salaire de Base",
                        style: TextStyle(
                            fontFamily: 'bold',
                            fontSize: 13),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 3,
                    color: Colors.white54,
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Salaire Brut",
                        style: TextStyle(
                            fontFamily: 'bold',
                            fontSize: 13),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 3,
                    color: Colors.white54,
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Date de la prochaine prime",
                        style: TextStyle(
                            fontFamily: 'bold',
                            fontSize: 13),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 3,
                    color: Colors.white54,
                  ),
                  Container(
                    width: 100,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Etat",
                        style: TextStyle(
                            fontFamily: 'bold',
                            fontSize: 13),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 3,
                    color: Colors.white54,
                  ),
                  Expanded(
                    child: Container(
                      width: 250,
                      height: 50,
                      child: Center(
                        child: Text(
                          "Action",
                          style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 13),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            h(5),
            BoxUser(
              "Aïcha TRAORÉ",
              "05/08/2022",
              120000,
              120000,
              "05/08/2025",
              "Pas Prêt",
            ),
            Divider(),
            h(5),
            BoxUser(
              "Christian ZOGBO",
              "17/08/2021",
              250000,
              250000,
              "17/08/2024",
              "Prêt",
            ),
            Divider(),
          ],
        ));
  }

  BoxUser(String nomprenom, dateEmbauche, double salaireBasic,salaireActu, String temprestant,
      etat) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
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
                Center(
                  child: Text(
                    nomprenom,
                    style: TextStyle(
                        fontFamily: 'normal',
                        color: Colors.black87,
                        fontSize: 13),
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
          Container(
            width: 150,
            height: 50,
            child: Center(
              child: Text(
                dateEmbauche,
                style: TextStyle(
                    fontFamily: 'normal', color: Colors.black87, fontSize: 13),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 3,
            color: Color.fromARGB(19, 0, 0, 0),
          ),
          Container(
            width: 150,
            height: 50,
            child: Center(
              child: Text(
                '$salaireBasic FCFA',
                style: TextStyle(
                    fontFamily: 'normal', color: Colors.black87, fontSize: 13),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 3,
            color: Color.fromARGB(19, 0, 0, 0),
          ),
          Container(
            width: 150,
            height: 50,
            child: Center(
              child: Text(
                '$salaireActu FCFA',
                style: TextStyle(
                    fontFamily: 'normal', color: Colors.black87, fontSize: 13),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 3,
            color: Color.fromARGB(19, 0, 0, 0),
          ),
          Container(
            width: 200,
            height: 50,
            child: Center(
              child: Text(
                temprestant,
                style: TextStyle(
                    fontFamily: 'bold', color: Colors.black87, fontSize: 13),
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
            color: etat=="Pas Prêt"?const Color.fromARGB(221, 178, 23, 23) :Color.fromARGB(221, 31, 178, 23) ,
            width: 100,
            height: 50,
            child: Center(
              child: Text(
                etat,
                style: TextStyle(
                    fontFamily: 'normal', color: Colors.white, fontSize: 13),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 3,
            color: Color.fromARGB(19, 0, 0, 0),
          ),
          Expanded(
            child: Container(
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
                                  barrierColor: mainColor3,
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (context, setState) =>
                                          AlertDialog(
                                        surfaceTintColor: Colors.white,
                                        content: Container(
                                          padding: EdgeInsets.all(10),
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3) +
                                              18,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Calcul de la Prime en Fonction de la date d'embauche",
                                                style: TextStyle(
                                                    fontFamily: 'bold',
                                                    color: mainColor2,
                                                    fontSize: 20),
                                                textAlign: TextAlign.center,
                                              ),
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
                                                      Text(
                                                        "$dateEmbauche",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'normal',
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14),
                                                        textAlign:
                                                            TextAlign.center,
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
                                                      Text(
                                                        " 3 ans",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'normal',
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              h(15),
                                              Text(
                                                " Pourcentage de Prime : 3% ",
                                                style: TextStyle(
                                                    fontFamily: 'normal',
                                                    color: Colors.black87,
                                                    fontSize: 14),
                                                textAlign: TextAlign.center,
                                              ),
                                              h(15),
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
                                                        " Salaire Avant Prime :",
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
                                                        " Salaire Après Prime :",
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
                                                      salaireActu = salaireBasic +(salaireBasic * 0.03);
                                                      print(salaireActu);
                                                      etat="Pas Prêt";
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
