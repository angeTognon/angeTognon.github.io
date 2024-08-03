import 'package:d_chart/d_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_circular_slider/multi_circular_slider.dart';
import 'package:zth_app/widgets/wid_var.dart';

class DashboardEmploye extends StatefulWidget {
  const DashboardEmploye({super.key});

  @override
  State<DashboardEmploye> createState() => _DashboardEmployeState();
}

class _DashboardEmployeState extends State<DashboardEmploye> {
  final GlobalKey _containerKey = GlobalKey();
  final GlobalKey _containerKey2 = GlobalKey();
  final GlobalKey _containerKey3 = GlobalKey();
  bool _isHovered = false;
  bool anniversaire = true;
  bool travail = false;

  final ordinalGroup = [
    OrdinalGroup(
      color: mainColor,
      id: '1',
      data: [
        OrdinalData(domain: 'Mai', measure: 6),
        OrdinalData(domain: 'Juin', measure: 2),
        OrdinalData(domain: 'Juillet', measure: 1),
      ],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: (MediaQuery.of(context).size.width * 13.5) / 16,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 40, right: 30, top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(left: 0),
                width: (MediaQuery.of(context).size.width * 15) / 16,
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                              image: AssetImage("assets/images/ange.jpg"),
                              fit: BoxFit.cover)),
                    ),
                    w(30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Bonjour M. Charle Kokou",
                          style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 18,
                              color: Color.fromARGB(182, 0, 0, 0)),
                        ),
                        Text(
                          "Bienvenue sur PharmaRH",
                          style: TextStyle(
                              fontFamily: 'normal',
                              fontSize: 13,
                              color: txtDesc),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              h(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width * 6) / 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color.fromARGB(75, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(15),
                          width: (MediaQuery.of(context).size.width * 6) / 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Permanance / Garde",
                                    style: TextStyle(
                                        fontFamily: 'bold',
                                        fontSize: 14,
                                        color: mainColor),
                                  ),
                                  //Icon
                                  Container(
                                      height: 20,
                                      width: 20,
                                      child: Image.asset(
                                          "assets/images/reload_icon.png"))
                                ],
                              ),
                              h(10),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                      style: TextStyle(
                                          fontFamily: 'bold',
                                          fontSize: 14,
                                          color: Colors.white),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      final RenderBox container = _containerKey
                                          .currentContext
                                          ?.findRenderObject() as RenderBox;
                                      final Offset containerPosition =
                                          container.localToGlobal(Offset.zero);
                                      final Size containerSize = container.size;
                                      showMenu(
                                        surfaceTintColor: Colors.white,
                                        context: context,
                                        position: RelativeRect.fromLTRB(
                                          containerPosition.dx,
                                          containerPosition.dy +
                                              containerSize.height,
                                          MediaQuery.of(context).size.width -
                                              containerPosition.dx -
                                              containerSize.width,
                                          0,
                                        ),
                                        items: [
                                          const PopupMenuItem(
                                            child: Text('Lundi'),
                                            value: 1,
                                          ),
                                          const PopupMenuItem(
                                            child: Text('Mardi'),
                                            value: 2,
                                          ),
                                          const PopupMenuItem(
                                            child: Text('Mercredi'),
                                            value: 3,
                                          ),
                                          const PopupMenuItem(
                                            child: Text('Jeudi'),
                                            value: 1,
                                          ),
                                          const PopupMenuItem(
                                            child: Text('Vendredi'),
                                            value: 2,
                                          ),
                                          const PopupMenuItem(
                                            child: Text('Samedi'),
                                            value: 3,
                                          ),
                                          const PopupMenuItem(
                                            child: Text('Dimanche'),
                                            value: 3,
                                          ),
                                        ],
                                        elevation:
                                            8.0, // Adjust the elevation for the box shadow
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      key: _containerKey,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.black26)),
                                      child: const Row(
                                        children: [
                                          Text(
                                            "Jours de la semaine",
                                            style: TextStyle(
                                                fontFamily: 'normal',
                                                fontSize: 12,
                                                color: Colors.black38),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              h(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Vous êtes de Permanance avec :   ",
                                    style: TextStyle(fontFamily: 'normal'),
                                  ),
                                ],
                              ),
                              h(20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/ange.jpg"),
                                                fit: BoxFit.cover)),
                                      ),
                                      h(10),
                                      Text(
                                        "Clarisse A.",
                                        style: TextStyle(fontFamily: 'bold'),
                                      )
                                    ],
                                  ),
                                  w(20),
                                  Column(
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/ange.jpg"),
                                                fit: BoxFit.cover)),
                                      ),
                                      h(10),
                                      Text(
                                        "Jacob K.",
                                        style: TextStyle(fontFamily: 'bold'),
                                      )
                                    ],
                                  ),
                                  w(20),
                                  Column(
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/ange.jpg"),
                                                fit: BoxFit.cover)),
                                      ),
                                      h(10),
                                      Text(
                                        "Malick C.",
                                        style: TextStyle(fontFamily: 'bold'),
                                      )
                                    ],
                                  ),
                                  w(20),
                                  Column(
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/ange.jpg"),
                                                fit: BoxFit.cover)),
                                      ),
                                      h(10),
                                      Text(
                                        "Stephanie D.",
                                        style: TextStyle(fontFamily: 'bold'),
                                      )
                                    ],
                                  ),
                                  w(20),
                                ],
                              ),
                              h(20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                
                                ],
                              ),
                              h(20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    Text(
                                    "Plage Horaire :   ",
                                    style: TextStyle(fontFamily: 'bold'),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      "08h00 - 17h30",
                                      style: TextStyle(
                                          fontFamily: 'bold',
                                          fontSize: 14,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        h(30),
                        /* Boite 1 */ Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color.fromARGB(75, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          width: (MediaQuery.of(context).size.width * 6) / 16,
                          height: 220,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      w(20),
                                      Text(
                                        "Mes Sanctions",
                                        style: TextStyle(
                                            fontFamily: 'bold',
                                            fontSize: 14,
                                            color: mainColor),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Container(
                                          height: 20,
                                          width: 20,
                                          child: Image.asset(
                                              "assets/images/reload_icon.png")),
                                      w(20),
                                    ],
                                  )

                                  //Icon
                                ],
                              ),
                              h(10),
                              Divider(),
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(color: mainColor),
                                height: 40,
                                width: (MediaQuery.of(context).size.width * 6) /
                                    16,
                                child: Row(
                                  children: [
                                    Container(
                                        width: 40,
                                        child: Center(
                                            child: Text(
                                          "N°",
                                          style: TextStyle(
                                              fontFamily: 'bold',
                                              color: Colors.white),
                                        ))),
                                    Container(
                                        margin:
                                            EdgeInsets.only(left: 5, right: 5),
                                        height: 40,
                                        width: 3),
                                    Container(
                                        width: 140,
                                        child: Center(
                                            child: Text(
                                          "Type de sanction",
                                          style: TextStyle(
                                              fontFamily: 'bold',
                                              color: Colors.white,
                                              fontSize: 12),
                                        ))),
                                    Container(
                                        margin:
                                            EdgeInsets.only(left: 5, right: 5),
                                        height: 40,
                                        width: 3),
                                    Container(
                                        width: 80,
                                        child: Center(
                                            child: Text(
                                          "Date",
                                          style: TextStyle(
                                              fontFamily: 'bold',
                                              color: Colors.white,
                                              fontSize: 12),
                                        ))),
                                    Container(
                                        margin:
                                            EdgeInsets.only(left: 5, right: 5),
                                        height: 40,
                                        width: 3),
                                    Expanded(
                                      child: Container(
                                          width: 140,
                                          child: Center(
                                              child: Text(
                                            "Motif",
                                            style: TextStyle(
                                                fontFamily: 'bold',
                                                color: Colors.white,
                                                fontSize: 12),
                                          ))),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                height: 40,
                                width: (MediaQuery.of(context).size.width * 6) /
                                    16,
                                child: Row(
                                  children: [
                                    Container(
                                        width: 40,
                                        child: Center(
                                            child: Text(
                                          "1",
                                          style: TextStyle(fontFamily: 'bold'),
                                        ))),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 5, right: 5),
                                      height: 40,
                                      width: 3,
                                      color: mainColor2,
                                    ),
                                    Container(
                                        width: 140,
                                        child: Center(
                                            child: Text(
                                          "Blâme",
                                          style: TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 12),
                                        ))),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 5, right: 5),
                                      height: 40,
                                      width: 3,
                                      color: mainColor2,
                                    ),
                                    Container(
                                        width: 80,
                                        child: Center(
                                            child: Text(
                                          "07/05/2024",
                                          style: TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 12),
                                        ))),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 5, right: 5),
                                      height: 40,
                                      width: 3,
                                      color: mainColor2,
                                    ),
                                    Expanded(
                                      child: Container(
                                          width: 140,
                                          child: Center(
                                              child: Text(
                                            "Lorem ipsum dolor sit amet, consectetur",
                                            style: TextStyle(
                                                fontFamily: 'normal',
                                                fontSize: 12),
                                          ))),
                                    ),
                                  ],
                                ),
                              ),
                              Divider()
                            ],
                          ),
                        ),
                        h(30),
                        
                      ],
                    ),
                  ),
                  
                  /* Container(
                    width: (MediaQuery.of(context).size.width * 3) / 16,
                  ), */
                  Container(
                    width: (MediaQuery.of(context).size.width * 6) / 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        h(10),
                        /* Boite 2 */ Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color.fromARGB(75, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(15),
                          width: (MediaQuery.of(context).size.width * 6) / 16,
                          height: 180,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Mes Fiches de Paie",
                                    style: TextStyle(
                                        fontFamily: 'bold',
                                        fontSize: 14,
                                        color: mainColor),
                                  ),
                                  //Icon
                                  Container(
                                      height: 20,
                                      width: 20,
                                      child: Image.asset(
                                          "assets/images/reload_icon.png"))
                                ],
                              ),
                              h(10),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      final RenderBox container = _containerKey2
                                          .currentContext
                                          ?.findRenderObject() as RenderBox;
                                      final Offset containerPosition =
                                          container.localToGlobal(Offset.zero);
                                      final Size containerSize = container.size;
                                      showMenu(
                                        surfaceTintColor: Colors.white,
                                        context: context,
                                        position: RelativeRect.fromLTRB(
                                          containerPosition.dx,
                                          containerPosition.dy +
                                              containerSize.height,
                                          MediaQuery.of(context).size.width -
                                              containerPosition.dx -
                                              containerSize.width,
                                          0,
                                        ),
                                        items: [
                                          const PopupMenuItem(
                                            child: Text('Mois précédent'),
                                            value: 1,
                                          ),
                                          const PopupMenuItem(
                                            child: Text('Ce mois'),
                                            value: 2,
                                          ),
                                          const PopupMenuItem(
                                            child: Text('Mois Prochain'),
                                            value: 3,
                                          ),
                                        ],
                                        elevation:
                                            8.0, // Adjust the elevation for the box shadow
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      width: 110,
                                      key: _containerKey2,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.black26)),
                                      child: const Row(
                                        children: [
                                          Text(
                                            "Ce mois",
                                            style: TextStyle(
                                                fontFamily: 'normal',
                                                fontSize: 12,
                                                color: Colors.black38),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              h(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "FICHE TOGNON ANGE KOFFI.pdf",
                                        style: TextStyle(fontFamily: 'bold'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Télécharger",
                                        style: TextStyle(
                                            color: mainColor,
                                            fontFamily: 'bold'),
                                      ),
                                      w(20),
                                      Icon(
                                        Icons.download,
                                        size: 30,
                                        color: mainColor,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              h(15),
                            ],
                          ),
                        ),
                        h(20),
                        /* Boite 1 */ Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color.fromARGB(75, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(15),
                          width: (MediaQuery.of(context).size.width * 6) / 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Mes demandes en attente",
                                    style: TextStyle(
                                        fontFamily: 'bold',
                                        fontSize: 14,
                                        color: mainColor),
                                  ),
                                  //Icon
                                  Container(
                                      height: 20,
                                      width: 20,
                                      child: Image.asset(
                                          "assets/images/reload_icon.png"))
                                ],
                              ),
                              h(10),
                              Divider(),
                              Column(
                                children: [
                                  const Text(
                                    "Aucune demande émise pour l'instant",
                                    style: TextStyle(fontFamily: 'normal'),
                                  ),
                                  h(8),
                                ],
                              ),
                              h(50),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: mainColor),
                                      onPressed: () {},
                                      child: Text(
                                        "Faire une demande",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'normal'),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                        h(20),
                        Text(
                          "Etat des absences durant les 3 dernirs mois",
                          style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 14,
                              color: mainColor),
                        ),
                        Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 3.3,
                              child: DChartBarO(
                                areaColor: (group, ordinalData, index) {
                                  if (ordinalData == 10) {
                                    mainColor;
                                  }
                                },
                                groupList: ordinalGroup,
                              ),
                            ),
                          ],
                        ),
                        
                        h(30),
                      ],
                    ),
                  ),

                  /* *********************************3eme*************************************************** */

                  /* Container(
                    width: (MediaQuery.of(context).size.width * 5) / 16,
                    child: Column(
                      children: [
                        /* Boite 1 */ Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color.fromARGB(75, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(15),
                          width: 320,
                          height: 220,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Demandes en Attente",
                                    style: TextStyle(
                                        fontFamily: 'bold',
                                        fontSize: 14,
                                        color: mainColor),
                                  ),
                                ],
                              ),
                              h(10),
                              Divider(),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                height: 130,
                                width: 320,
                                child: Center(
                                  child: Column(
                                    children: [
                                      h(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: mainColor,
                                                minRadius: 20,
                                                child: Center(
                                                    child: Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                )),
                                              ),
                                              w(10),
                                              Text(
                                                "TOGNON Jean Paul",
                                                style: TextStyle(
                                                    fontFamily: 'bold',
                                                    fontSize: 13),
                                              )
                                            ],
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 225, 244, 54),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: 40,
                                            width: 100,
                                            child: Center(
                                                child: Text(
                                              "Demande de congé",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'normal',
                                                  fontSize: 11),
                                              textAlign: TextAlign.center,
                                            )),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        h(10),
                        /* Boite 2 */ 
                        h(10),
                        /* Boite 2 */ Container(
                          decoration: BoxDecoration(
                              color: mainColor,
                              border: Border.all(
                                  color: const Color.fromARGB(75, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(15),
                          width: 320,
                          height: 220,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Notification ",
                                    style: TextStyle(
                                        fontFamily: 'bold',
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                  //Icon
                                  Container(
                                      height: 20,
                                      width: 20,
                                      child: Icon(
                                        Icons.restart_alt,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                              h(10),
                              Divider(),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                height: 120,
                                width: 320,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      h(10),
                                      Container(
                                        width: 450,
                                        child: Column(
                                          children: [
                                            h(10),
                                            Icon(
                                              Icons.notifications,
                                              color: mainColor,
                                              size: 50,
                                            ),
                                            h(10),
                                            const Text(
                                              "Aucune notification pour l'instant",
                                              style: TextStyle(
                                                  fontFamily: 'normal'),
                                            ),
                                            h(8),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ), */
                ],
              ),
              h(100),
            ],
          ),
        ),
      ),
    );
  }
}
