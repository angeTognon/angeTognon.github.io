// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zth_app/interfaceAdmin/menu/accueil.dart';
import 'package:zth_app/interfaceAdmin/menu/message/chat.dart';
import 'package:zth_app/interfaceAdmin/menu/planning/planning.dart';
import 'package:zth_app/interfaceAdmin/menu/pr%C3%A9sence/presence.dart';
import 'package:zth_app/interfaceAdmin/menu/rh.dart';
import 'package:zth_app/interfaceAdmin/menu/sanctions/sanction.dart';
import 'package:zth_app/interfaceAdmin/menu/salaire/salaire.dart';
import 'package:zth_app/interfaceAdmin/menu/salaire/settings.dart';
import 'package:zth_app/interfaceEmploy%C3%A9/presences.dart';
import 'package:zth_app/main.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  getSalary() async {
    var url = "https://zoutechhub.com/pharmaRh/getU.php?email=$user_email";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  getPresence() async {
    var url =
        "https://zoutechhub.com/pharmaRh/getPresence.php?dd=${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  /* , */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: MAB(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: actualite
          ? Container(
              margin: EdgeInsets.only(left: 600),
              child: Card(
                elevation: 10,
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  height: 60,
                  width: (MediaQuery.of(context).size.width * 9.8) / 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 0),
                        decoration: BoxDecoration(
                            color: mainColor__,
                            borderRadius: BorderRadius.circular(20)),
                        height: 40,
                        width: (MediaQuery.of(context).size.width * 9) / 16,
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelStyle:
                                  TextStyle(fontFamily: 'normal', fontSize: 13),
                              label: Text("Ecrivez un message ici"),
                              border: InputBorder.none),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: mainColor,
                        child: Center(
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          : null,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              /* Container(
                color: mainColor,
                padding: const EdgeInsets.only(left: 20, top: 3, bottom: 3),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: AssetImage("assets/images/ange.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                        w(15),
                        Container(
                          height: 50,
                          width: 300,
                          child: FutureBuilder(
                            future: getSalary(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                      "Erreur de chargement. Veuillez relancer l'application"),
                                );
                              }
                              if (snapshot.hasData) {
                                if (snapshot.data.isEmpty) {
                                  return Column(
                                    children: [
                                      h(20),
                                      Icon(
                                        Icons.safety_check_rounded,
                                        size: 100,
                                        color: mainColor,
                                      ),
                                      h(20),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Text(
                                          "Oups, Vous n'avez aucun employé pour l'instant ",
                                          style: TextStyle(fontSize: 17),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${snapshot.data[index]['prenom']} ${snapshot.data[index]['nom']}",
                                            style: TextStyle(
                                              fontFamily: 'bold',
                                              fontSize: 18,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                          ),
                                          Text(
                                            "Bienvenue sur PharmaRH",
                                            style: TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 13,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                              return Center(
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  child:
                                      Lottie.asset("assets/images/anim.json"),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              accueil = false;
                              planning = false;
                              salaire = false;
                              sanction = false;
                              presence = false;
                              rh = false;
                              actualite = true;
                              parametre = false;
                            });
                          },
                          child: Icon(
                            Icons.chat,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        w(15),
                        InkWell(
                          onTap: () {
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
                          },
                          child: Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    )
                  ],
                ),
              ), */
              Row(
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
                                                  : Container(),
                ],
              ),
            ],
          ),
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
                    onTap: () {
                      setState(() async {
                        final prefs = await SharedPreferences.getInstance();
                        final prefs2 = await SharedPreferences.getInstance();
                        eya = false;
                        eyaEmploye = false;
                        prefs.setBool('isConnected', eya);
                        prefs2.setBool('isConnected2', eyaEmploye);
                        print(eya);
                        Phoenix.rebirth(context);
                        print("object");
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor:
                                const Color.fromARGB(255, 11, 71, 13),
                            content: Text(
                              "Déconnexion réussie",
                              style: TextStyle(
                                  fontFamily: 'normal2', color: Colors.white),
                            )));
                        print("object*****");
                      });
                    },
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
