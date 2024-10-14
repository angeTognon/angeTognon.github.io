// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PresenceM extends StatefulWidget {
  const PresenceM({super.key});

  @override
  State<PresenceM> createState() => _PresenceMState();
}

class _PresenceMState extends State<PresenceM> {
  final now = DateTime.now();
  @override
  void initState() {
    super.initState();

    /*   String comparisonResult;
    if (myTime.isAfter(now)) {
      comparisonResult = "Il est avant 8h01";
      print(comparisonResult);
    } else if (myTime.isBefore(now)) {
      comparisonResult = "Il est après 8h01";
      print(comparisonResult);
    } else {
      comparisonResult = "Il est exactement 8h01";
      print(comparisonResult);
    } */
  }

  String inputTime = "";
  DateTime currentTime = DateTime.now();

  getSalary() async {
    var url =
        "https://zoutechhub.com/pharmaRh/getPresence.php?dd=${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: (MediaQuery.of(context).size.width * 9.7) / 12,
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
                    width: 160,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Date ",
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
                    width: 240,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Heure d'arrivé",
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
                    width: 240,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Heure de Sortie",
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
                        "Status de la présence",
                        style: TextStyle(fontFamily: 'bold', fontSize: 13),
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
                      width: 200,
                      height: 50,
                      child: Center(
                        child: Text("Action",
                            style: TextStyle(fontFamily: 'bold', fontSize: 13)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            h(5),
            SizedBox(
              height: MediaQuery.of(context).size.height,
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
                                color: Colors.red,
                              ),
                              h(20),
                              Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  "Oups, Aucune donnée pour l'instant ",
                                  style: TextStyle(fontSize: 17),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  BoxUser(
                                    "${snapshot.data![index]['nomPrenom']}",
                                    "${snapshot.data![index]['datePresence']}",
                                    "${snapshot.data![index]['heureArrive']}",
                                    "${snapshot.data![index]['heureFin']}",
                                    "}",
                                    "${snapshot.data![index]['linkPhoto']}",
                                  ),
                                  Divider(),
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
          ],
        ));
  }

  BoxUser(String nomprenom, date, hA, hS, etat, link) {
    // Séparer les heures et les minutes
    List<String> hAMinutes = hA.split(':');
    int hour = int.parse(hAMinutes[0]);
    int minute = int.parse(hAMinutes[1]);

    // Définir un seuil horaire et minuté (ici, 8 heures 1 minute)
    int thresholdHour = 8;
    int thresholdMinute = 1;

    bool isAfter = hour > thresholdHour ||
        (hour == thresholdHour && minute >= thresholdMinute);
// Extract hour from hA
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
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
          SizedBox(
            width: 160,
            height: 50,
            child: Center(
              child: Text(
                date,
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
          SizedBox(
            width: 240,
            height: 50,
            child: Center(
              child: Text(
                hA,
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
          SizedBox(
            width: 240,
            height: 50,
            child: Center(
              child: Text(
                hS,
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

          /*  // Séparer les heures et les minutes de l'entrée
    */
          Container(
            height: 50,
            width: 200,
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Container(
              width: 10,
              decoration: BoxDecoration(
                  color: isAfter
                      ? Color.fromARGB(223, 178, 23, 23)
                      : const Color.fromARGB(255, 40, 101, 42),
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Text(
                  isAfter ? "En Retard" : "A l'heure",
                  style: TextStyle(
                      fontFamily: 'normal', color: Colors.white, fontSize: 13),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 3,
            color: Color.fromARGB(19, 0, 0, 0),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                launchUrl(Uri.parse(link));
              },
              child: SizedBox(
                width: 200,
                height: 50,
                child: Center(
                  child: Text("Voir Photo",
                      style: TextStyle(fontFamily: 'bold', fontSize: 13)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
