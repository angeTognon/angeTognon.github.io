// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zth_app/widgets/wid_var.dart';

class PresenceM extends StatefulWidget {
  const PresenceM({super.key});

  @override
  State<PresenceM> createState() => _PresenceMState();
}

class _PresenceMState extends State<PresenceM> {
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
                    width: 160,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Date ",
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
                    width: 240,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Heure d'arrivé",
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
                    width: 240,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Heure de Sortie",
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
                      width: 240,
                      height: 50,
                      child: Center(
                        child: Text(
                          "Status de la présence",
                          style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            h(5),
            BoxUser(
              "Aïcha TRAORÉ",
              "25/07/2024",
              "8 h 05",
              "18 h 00",
              "Retard",
            ),
            Divider(),
            h(5),
            BoxUser(
              "Christian ZOGBO",
              "25/07/2024",
              "07 h 45",
              "18 h 00",
              "Présent",
            ),
            Divider(),
          ],
        ));
  }

  BoxUser(String nomprenom, date, hA,hS,etat) {
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
          Container(
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
          Container(
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
          
          Expanded(
            child: Container(
            
              height: 50,
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Container(width: 10,
                  decoration: BoxDecoration(
              color: etat=="Retard"?Color.fromARGB(223, 178, 23, 23) :mainColor2 ,
              borderRadius: BorderRadius.circular(15)
              ),
                child: Center(
                  child: Text(
                    etat,
                    style: TextStyle(
                        fontFamily: 'normal', color: Colors.white, fontSize: 13),
                  ),
                ),
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
            color: Color.fromARGB(19, 0, 0, 0),
          ),
        ],
      ),
    );
  }
}
