import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:zth_app/widgets/wid_var.dart';

class HomeEmploye extends StatefulWidget {
  const HomeEmploye({super.key});

  @override
  State<HomeEmploye> createState() => _HomeEmployeState();
}

class _HomeEmployeState extends State<HomeEmploye> {
  /* , */
  bool accueil = false;
  bool planning = false;
  bool salaire = false;
  bool sanction = false;
  bool presence = true;
  bool rh = false;
  bool actualite = false;
  bool parametre = false;
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
                  padding: EdgeInsets.only(left: 10,right: 10),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  height: 60,
                  width: (MediaQuery.of(context).size.width * 9.8) / 16,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20,top: 0),
                        decoration: BoxDecoration(
                          color: mainColor__,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        height: 40,
                        width: (MediaQuery.of(context).size.width * 9) / 16,
                        child: TextFormField(
                          decoration: InputDecoration(labelStyle: TextStyle(fontFamily: 'normal',fontSize: 13),label: Text("Ecrivez un message ici"),border: InputBorder.none),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: mainColor,
                        child: Center(
                          child: Icon(Icons.send,color: Colors.white,),
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
        child: Row(
          children: [
            MenuPrincipal(),
            accueil
                ? DashboardEmploye()
                : planning
                    ? PlanningE()
                    : salaire
                        ? Salaire()
                        : sanction
                            ? GestionPleinBlame()
                            : presence
                                ? PresencesEmploye()
                                : rh
                                    ? RH()
                                    : actualite
                                        ? ChatScreen()
                                        : parametre
                                            ? Settings()
                                            : Container(),
          ],
        ),
      ),
    );
  }

  MenuPrincipal() {
    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height,
      width: (MediaQuery.of(context).size.width * 2.5) / 16,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ]),
      child: Column(
        children: [
          h(15),
          Container(
            width: (MediaQuery.of(context).size.width * 2.5) / 16,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: mainColor5,
                  minRadius: 20,
                  child: Center(child: Icon(Icons.local_pharmacy,color: Colors.white,)),
                ),
                w(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "PharmaRH",
                      style: TextStyle(color: Colors.black, fontFamily: 'bold'),
                    ),
                    h(4),
                    Text(
                      "Employé",
                      style: TextStyle(
                          color: const Color.fromARGB(166, 0, 0, 0),
                          fontFamily: 'normal',
                          fontSize: 13),
                    ),
                  ],
                )
              ],
            ),
          ),
          h(15),
          Divider(),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: accueil ? Color.fromARGB(17, 0, 0, 0) : Colors.white),
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
                      Container(
                          height: 30,
                          width: 30,
                          child: Icon(
                            Icons.dashboard,
                            color: mainColor5,
                          )),
                      w(10),
                      Text(
                        "Tableau de Bord",
                        style: TextStyle(
                          fontFamily: 'bold',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: mainColor5,
                  )
                ],
              ),
            ),
          ),
          h(10),
          Divider(),
          h(10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: planning ? Color.fromARGB(17, 0, 0, 0) : Colors.white
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
                      Container(
                          height: 30,
                          width: 30,
                          child: Icon(
                            Icons.edit_calendar,
                            color: mainColor5,
                          )),
                      w(10),
                      Text(
                        "Planning",
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
          Divider(),
          h(10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: presence ? Color.fromARGB(17, 0, 0, 0) : Colors.white
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
                      Container(
                          height: 35,
                          width: 35,
                          child: Icon(
                            Icons.timelapse_sharp,
                            color: mainColor5,
                          )),
                      w(10),
                      Text(
                        "Présences",
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
          h(10),
          Divider(),
          h(5),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: actualite ? Color.fromARGB(17, 0, 0, 0) : Colors.white
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
                      Container(
                          height: 35,
                          width: 35,
                          child: Icon(
                            Icons.chat,
                            color: mainColor5,
                          )),
                      w(10),
                      Text(
                        "Message",
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
          h(5),
          Divider(),
          h(5),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: parametre ? Color.fromARGB(17, 0, 0, 0) : Colors.white
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
                actualite = false;
                parametre = true;
              }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          height: 35,
                          width: 35,
                          child: Icon(
                            Icons.settings,
                            color: mainColor5,
                          )),
                      w(10),
                      Text(
                        "Paramètre",
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
    );
  }
}
