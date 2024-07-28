import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:zth_app/menu/pr%C3%A9sence/presence_m.dart';
import 'package:zth_app/menu/salaire/gestion_plein_blame.dart';
import 'package:zth_app/menu/salaire/gestion_pret_avancement.dart';
import 'package:zth_app/menu/salaire/gestion_prime.dart';
import 'package:zth_app/menu/planning/planning_employ%C3%A9.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'dart:html' as html;

class Presence extends StatefulWidget {
  const Presence({super.key});

  @override
  State<Presence> createState() => _PresenceState();
}

class _PresenceState extends State<Presence>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey _containerKey1 = GlobalKey();
  final GlobalKey _containerKey2 = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height,
      width: (MediaQuery.of(context).size.width * 13.5) / 16,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Présence ",//${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year},
              style: TextStyle(
                  fontFamily: 'bold',
                  fontSize: 20,
                  color: mainColor),
            ),
            h(20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(padding: EdgeInsets.all(20),
                  height: 200,width: 250,
                  decoration: BoxDecoration(color: mainColor,borderRadius: BorderRadius.circular(15),),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.light_mode_outlined,color: Colors.amber,size: 50,),
                          Text("${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",style: TextStyle(fontFamily: 'bold',fontSize: 26  ,color: Colors.white),)
                        ],
                      ),
                      h(40),
                      Text("Aujourd'hui : \n${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",style: TextStyle(fontFamily: 'normal',color: Colors.white),)
                    ],
                  ),
                ),
                Container(padding: EdgeInsets.all(20),
                  width: 250,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),border: Border.all(color: Colors.black54)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("20",style: TextStyle(fontFamily: 'bold',fontSize: 40  ,color: mainColor),),
                          CircleAvatar(
                            backgroundColor: mainColor,
                            child: Center(child: Icon(Icons.person,color: Colors.white,size: 25,))),
                        ],
                      ),
                      h(10),
                      Text("Employés au Total",style: TextStyle(fontFamily: 'normal',color: Colors.black),)
        
                    ],
                  ),
                ),
                Container(padding: EdgeInsets.all(20),
                  width: 250,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),border: Border.all(color: Colors.black54)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("12",style: TextStyle(fontFamily: 'bold',fontSize: 40  ,color: Color.fromARGB(223, 178, 23, 23) ),),
                          CircleAvatar(
                            backgroundColor: Color.fromARGB(223, 178, 23, 23) ,
                            child: Center(child: Icon(Icons.person,color: Colors.white,size: 25,))),
                        ],
                      ),
                      h(10),
                      Text("En reatard ",style: TextStyle(fontFamily: 'normal',color: Colors.black),)
                    ],
                  ),
                ),
                Container(padding: EdgeInsets.all(20),
                  width: 250,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),border: Border.all(color: Colors.black54)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("8",style: TextStyle(fontFamily: 'bold',fontSize: 40  ,color: mainColor2),),
                          CircleAvatar(
                            backgroundColor: mainColor2,
                            child: Center(child: Icon(Icons.person,color: Colors.white,size: 25,))),
                        ],
                      ),
                      h(10),
                      Text("A l'heure",style: TextStyle(fontFamily: 'normal',color: Colors.black),)
                    ],
                  ),
                )
              ],
            ),
            h(20),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    final RenderBox container = _containerKey1.currentContext
                        ?.findRenderObject() as RenderBox;
                    final Offset containerPosition =
                        container.localToGlobal(Offset.zero);
                    final Size containerSize = container.size;
                    showMenu(
                      surfaceTintColor: Colors.white,
                      context: context,
                      position: RelativeRect.fromLTRB(
                        containerPosition.dx,
                        containerPosition.dy + containerSize.height,
                        MediaQuery.of(context).size.width -
                            containerPosition.dx -
                            containerSize.width,
                        0,
                      ),
                      items: [
                        PopupMenuItem(
                          child: Text(
                            "Aujourd'hui",
                            style: TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Hier',
                            style: TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Avant hier',
                            style: TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Cette Semaine',
                            style: TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'La Semaine Dernière',
                            style: TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Le mois dernier',
                            style: TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                      ],
                      elevation: 8.0, // Adjust the elevation for the box shadow
                    );
                  },
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                    width: 210,
                    height: 35,
                    key: _containerKey1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black26)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Trier par Date",
                          style: TextStyle(
                              fontFamily: 'normal',
                              fontSize: 13,
                              color: const Color.fromARGB(154, 0, 0, 0)),
                        ),
                        Icon(
                          Icons.arrow_drop_down_rounded,
                          color: const Color.fromARGB(154, 0, 0, 0),
                        )
                      ],
                    ),
                  ),
                ),
                w(40),
                InkWell(
                  onTap: () {
                    final RenderBox container = _containerKey2.currentContext
                        ?.findRenderObject() as RenderBox;
                    final Offset containerPosition =
                        container.localToGlobal(Offset.zero);
                    final Size containerSize = container.size;
                    showMenu(
                      surfaceTintColor: Colors.white,
                      context: context,
                      position: RelativeRect.fromLTRB(
                        containerPosition.dx,
                        containerPosition.dy + containerSize.height,
                        MediaQuery.of(context).size.width -
                            containerPosition.dx -
                            containerSize.width,
                        0,
                      ),
                      items: [
                        PopupMenuItem(
                          child: Text(
                            "Retard",
                            style: TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Absence',
                            style: TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                      ],
                      elevation: 8.0, // Adjust the elevation for the box shadow
                    );
                  },
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                    width: 210,
                    height: 35,
                    key: _containerKey2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black26)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Trier par Etat",
                          style: TextStyle(
                              fontFamily: 'normal',
                              fontSize: 13,
                              color: const Color.fromARGB(154, 0, 0, 0)),
                        ),
                        Icon(
                          Icons.arrow_drop_down_rounded,
                          color: const Color.fromARGB(154, 0, 0, 0),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            h(20),
            PresenceM(),
            h(20),
            Text(
              "Gestion des congés",
              style: TextStyle(
                  fontFamily: 'bold',
                  fontSize: 23,
                  color: Color.fromARGB(216, 42, 116, 100)),
            ),
            h(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  surfaceTintColor: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    color: mainColor,
                    ),
                    height: 150,
                    width: 400,
                    child: Center(
                      child: Text(
                        "0 Personnes actuellement en congés",
                        style: TextStyle(fontFamily: 'normal', fontSize: 14,color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: mainColor3, borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Container(
                            width: 400,
                            height: 50,
                            child: Center(
                              child: Text(
                                "Nom et Prénoms de l'employé",
                                style: TextStyle(
                                    fontFamily: 'bold',
                                    color: Colors.black,
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
                            width: 300,
                            height: 50,
                            child: Center(
                              child: Text(
                                "Nombre de Jour de Congés Restant ",
                                style: TextStyle(
                                    fontFamily: 'bold',
                                    color: Colors.black,
                                    fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                     BoxU('TOGNON K. ANGE', "31"),
                     BoxU('TOGNON K. ANGE', "20"),
        
                  ],
                ),
              ],
            ),
           
          ],
        ),
      ),
    );
  }

  BoxU(String nomPrenom, nbrJour) {
    return
    Container(
      height: 50,
      decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            width: 400,
            height: 50,
            child: Center(
              child: Text(
                nomPrenom,
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
          Container(
            width: 300,
            height: 50,
            child: Center(
              child: Text(
                nbrJour,
                style: TextStyle(
                    fontFamily: 'normal', color: Colors.black, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
