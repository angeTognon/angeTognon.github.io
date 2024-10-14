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
import 'package:zth_app/interfaceEmploy%C3%A9/dashboard_employe.dart';
import 'package:zth_app/interfaceEmploy%C3%A9/planning_employe.dart';
import 'package:zth_app/interfaceEmploy%C3%A9/presences.dart';
import 'package:zth_app/interfaceEmploy%C3%A9/user_profile.dart';
import 'package:zth_app/main.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'package:http/http.dart' as http;
import 'package:zth_app/zero.dart';

TextEditingController _textController = TextEditingController();

class HomeEmploye extends StatefulWidget {
  const HomeEmploye({super.key});

  @override
  State<HomeEmploye> createState() => _HomeEmployeState();
}

class _HomeEmployeState extends State<HomeEmploye> {
  /* , */
  bool accueil = true;
  bool planning = false;
  bool salaire = false;
  bool sanction = false;
  bool presence = false;
  bool rh = false;
  bool actualite = false;
  bool parametre = false;

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  Future<void> _getUserName() async {
    final salary = await getSalary();
    if (salary.isNotEmpty) {
      setState(() {
        user_name = "${salary[0]['prenom']} ${salary[0]['nom']}";
      });
    }
  }

  getSalary() async {
    var url = "https://zoutechhub.com/pharmaRh/getU.php?email=$user_email";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  inscription() async {
    var url =
        "https://zoutechhub.com/pharmaRh/addMessage.php?nomPrenomE=$user_name&nomPrenomR=$receveur&msg=${_textController.text}&codee=$codee";
    var response = await http.post(Uri.parse(url));
    var pub = await json.decode(response.body);
    print("**********************************************");
    print(pub);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: MAB(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: actualite
          ? Container(
              margin: const EdgeInsets.only(left: 600),
              child: Card(
                elevation: 10,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  height: 60,
                  width: (MediaQuery.of(context).size.width * 9.8) / 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20, top: 0),
                        decoration: BoxDecoration(
                          color: mainColor__,
                        ),
                        height: 40,
                        width: (MediaQuery.of(context).size.width * 9) / 16,
                        child: TextFormField(
                          onFieldSubmitted: (newValue) {
                            inscription();
                            setState(() {
                              _textController.text = "";
                            });
                          },
                          controller: _textController,
                          decoration: const InputDecoration(
                              labelStyle:
                                  TextStyle(fontFamily: 'normal', fontSize: 13),
                              border: InputBorder.none),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          inscription();
                          setState(() {
                            _textController.text = "";
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: mainColor,
                          child: const Center(
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
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
        decoration: const BoxDecoration(color: Colors.white),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              /* */
              Row(
                children: [
                  MenuPrincipal(),
                  accueil
                      ? const DashboardEmploye()
                      : planning
                          ? const PlanningE()
                          : salaire
                              ? const Salaire()
                              : sanction
                                  ? const GestionPleinBlame()
                                  : presence
                                      ? CameraPage()
                                      : rh
                                          ? const RH()
                                          : actualite
                                              ? const ChatScreen()
                                              : parametre
                                                  ? UserProfiles()
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
          padding: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          width: (MediaQuery.of(context).size.width * 2) / 12,
          decoration: const BoxDecoration(
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
                      const Text(
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
                const Divider(),
                h(5),
                Container(
                  padding: const EdgeInsets.all(13),
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
                  padding: const EdgeInsets.all(13),
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
                  padding: const EdgeInsets.all(13),
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
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: actualite ? mainColor : mainColor4
                      //color: Color.fromARGB(17, 0, 0, 0)
                      ),
                  child: InkWell(
                    onTap: () => setState(() {
                      accueil = false;
                      planning = false;
                      salaire = false;
                      sanction = false;
                      presence = false;
                      rh = false;
                      actualite = true;
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
                                  Icons.chat,
                                  color:
                                      actualite ? Colors.white : Colors.black,
                                )),
                            w(10),
                            Text(
                              "Message",
                              style: TextStyle(
                                fontFamily: 'bold',
                                fontSize: 14,
                                color: actualite ? Colors.white : Colors.black,
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
                  padding: const EdgeInsets.all(13),
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
                            const SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(
                                  Icons.accessibility_sharp,
                                  color: Colors.black,
                                )),
                            w(10),
                            const Text(
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
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: parametre ? mainColor : mainColor4),
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
                                  color:
                                      parametre ? Colors.white : Colors.black,
                                )),
                            w(10),
                            Text(
                              "Mon Compte",
                              style: TextStyle(
                                fontFamily: 'bold',
                                fontSize: 14,
                                color: parametre ? Colors.white : Colors.black,
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
                  padding: const EdgeInsets.all(13),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor:
                                    Color.fromARGB(255, 11, 71, 13),
                                content: Text(
                                  "Déconnexion réussie",
                                  style: TextStyle(
                                      fontFamily: 'normal2',
                                      color: Colors.white),
                                )));
                        print("object*****");
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(
                                  Icons.power_settings_new_rounded,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                )),
                            w(10),
                            const Text(
                              "Déconnexion",
                              style: TextStyle(
                                fontFamily: 'bold',
                                fontSize: 14,
                                color: Color.fromARGB(255, 255, 255, 255),
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
