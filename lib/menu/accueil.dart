import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_circular_slider/multi_circular_slider.dart';
import 'package:zth_app/widgets/wid_var.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  final GlobalKey _containerKey = GlobalKey();
  final GlobalKey _containerKey2 = GlobalKey();
  final GlobalKey _containerKey3 = GlobalKey();
  bool _isHovered = false;
  bool anniversaire = true;
  bool travail = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: (MediaQuery.of(context).size.width * 13.5) / 16,
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
                    height: 40,width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(image: AssetImage("assets/images/ange.jpg"),fit: BoxFit.cover)
                    ),
                  ),
                 
                  w(30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Bonjour M. Koffi Ange",
                        style: TextStyle(
                            fontFamily: 'bold',
                            fontSize: 18,
                            color: Color.fromARGB(182, 0, 0, 0)),
                      ),
                      Text(
                        "Bienvenue sur PharmaRH",
                        style: TextStyle(
                            fontFamily: 'normal', fontSize: 13, color: txtDesc),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width * 4) / 16,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Gestion des plaintes et suggestions",
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
                                    h(20),
                                    Container(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset(
                                          "assets/images/chat_icon.png"),
                                    ),
                                    h(20),
                                    const Text(
                                      "Aucune plainte ou Suggestion Pour l'instant",
                                      style: TextStyle(fontFamily: 'normal'),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      h(10),
                      /* Boite 2 */ Container(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Traitement des Fiches de Paie",
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
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              height: 130,
                              width: 320,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    h(10),
                                    Container(
                                      width: 450,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  final RenderBox container =
                                                      _containerKey2
                                                              .currentContext
                                                              ?.findRenderObject()
                                                          as RenderBox;
                                                  final Offset
                                                      containerPosition =
                                                      container.localToGlobal(
                                                          Offset.zero);
                                                  final Size containerSize =
                                                      container.size;
                                                  showMenu(
                                                    surfaceTintColor:
                                                        Colors.white,
                                                    context: context,
                                                    position:
                                                        RelativeRect.fromLTRB(
                                                      containerPosition.dx,
                                                      containerPosition.dy +
                                                          containerSize.height,
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width -
                                                          containerPosition.dx -
                                                          containerSize.width,
                                                      0,
                                                    ),
                                                    items: [
                                                      const PopupMenuItem(
                                                        child: Text(
                                                            'Mois précédent'),
                                                        value: 1,
                                                      ),
                                                      const PopupMenuItem(
                                                        child: Text('Ce mois'),
                                                        value: 2,
                                                      ),
                                                      const PopupMenuItem(
                                                        child: Text(
                                                            'Mois Prochain'),
                                                        value: 3,
                                                      ),
                                                    ],
                                                    elevation:
                                                        8.0, // Adjust the elevation for the box shadow
                                                  );
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  width: 110,
                                                  key: _containerKey2,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          color:
                                                              Colors.black26)),
                                                  child: const Row(
                                                    children: [
                                                      Text(
                                                        "Ce mois",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'normal',
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black38),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          h(40),
                                          const Text(
                                            "Rien pour L'instant",
                                            style:
                                                TextStyle(fontFamily: 'normal'),
                                          ),
                                          h(15),
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
                      h(10),
                      /* Boite 3*/ Container(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Traitement des Salaire",
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
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              height: 130,
                              width: 320,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    h(10),
                                    Container(
                                      width: 450,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  final RenderBox container =
                                                      _containerKey2
                                                              .currentContext
                                                              ?.findRenderObject()
                                                          as RenderBox;
                                                  final Offset
                                                      containerPosition =
                                                      container.localToGlobal(
                                                          Offset.zero);
                                                  final Size containerSize =
                                                      container.size;
                                                  showMenu(
                                                    surfaceTintColor:
                                                        Colors.white,
                                                    context: context,
                                                    position:
                                                        RelativeRect.fromLTRB(
                                                      containerPosition.dx,
                                                      containerPosition.dy +
                                                          containerSize.height,
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width -
                                                          containerPosition.dx -
                                                          containerSize.width,
                                                      0,
                                                    ),
                                                    items: [
                                                      const PopupMenuItem(
                                                        child: Text(
                                                            'Mois précédent'),
                                                        value: 1,
                                                      ),
                                                      const PopupMenuItem(
                                                        child: Text('Ce mois'),
                                                        value: 2,
                                                      ),
                                                      const PopupMenuItem(
                                                        child: Text(
                                                            'Mois Prochain'),
                                                        value: 3,
                                                      ),
                                                    ],
                                                    elevation:
                                                        8.0, // Adjust the elevation for the box shadow
                                                  );
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  width: 110,
                                                  // key: _containerKey2,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          color:
                                                              Colors.black26)),
                                                  child: const Row(
                                                    children: [
                                                      Text(
                                                        "Ce mois",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'normal',
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black38),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          h(40),
                                          const Text(
                                            "Rien pour L'instant",
                                            style:
                                                TextStyle(fontFamily: 'normal'),
                                          ),
                                          h(15),
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
                ),

                /* **********************************2eme Colonne************************************** */
                Container(
                  width: (MediaQuery.of(context).size.width * 4.5) / 16,
                  child: Column(
                    children: [
                      /* Boite 1 */ Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: const Color.fromARGB(75, 0, 0, 0)),
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.all(15),
                        width: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Gestion des Présences",
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
                            Container(
                              height: 200,
                              margin: EdgeInsets.all(50),
                              child: MultiCircularSlider(
                                size: 260,
                                showTotalPercentage: true,
                                progressBarType:
                                    MultiCircularSliderType.circular,
                                values: [0.7, 0.1, 0.2],
                                colors: [
                                  mainColor,
                                  Color.fromARGB(255, 238, 255, 0),
                                  Color.fromARGB(255, 252, 0, 8),
                                ],
                              ),
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                        minRadius: 10,
                                        backgroundColor: mainColor),
                                    w(20),
                                    Text(
                                      "7 Présents",
                                      style: TextStyle(fontFamily: 'normal'),
                                    )
                                  ],
                                ),
                                h(20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                        minRadius: 10,
                                        backgroundColor:
                                            Color.fromARGB(255, 238, 255, 0)),
                                    w(20),
                                    Text(
                                      "1 En Congés",
                                      style: TextStyle(fontFamily: 'normal'),
                                    )
                                  ],
                                )
                              ],
                            ),
                            h(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                    minRadius: 10,
                                    backgroundColor:
                                        Color.fromARGB(255, 252, 0, 8)),
                                w(20),
                                Text(
                                  "2 Absent ",
                                  style: TextStyle(fontFamily: 'normal'),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      h(20),
                      Container(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Informations Présences",
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
                            Text(
                              "Absence",
                              style: TextStyle(
                                  color: mainColor, fontFamily: 'bold'),
                            ),
                            h(4),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                width: 320,
                                child: Column(
                                  children: [
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
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          height: 30,
                                          width: 100,
                                          child: Center(
                                              child: Text(
                                            "Sans Motif",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'normal',
                                                fontSize: 13),
                                          )),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                            Divider(),
                            Text(
                              "Congés",
                              style: TextStyle(
                                  color: mainColor, fontFamily: 'bold'),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                width: 320,
                                child: Column(
                                  children: [
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
                                              "Carlos AMOUSSOU",
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
                                          height: 30,
                                          width: 100,
                                          child: Center(
                                              child: Text(
                                            "Avec Motif",
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontFamily: 'normal',
                                                fontSize: 13),
                                          )),
                                        )
                                      ],
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /* *********************************3eme*************************************************** */

                Container(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      /* Boite 2 */ Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: const Color.fromARGB(75, 0, 0, 0)),
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.all(15),
                        width: 320,
                        height: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Contractualisation ",
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
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              height: 120,
                              width: 320,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    h(10),
                                    Container(
                                      width: 450,
                                      child: Column(
                                        children: [
                                          const Text(
                                            "Rien pour L'instant",
                                            style:
                                                TextStyle(fontFamily: 'normal'),
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
                      h(10),
                      /* Boite 2 */ Container(
                        decoration: BoxDecoration(
                            color: mainColor,
                            border: Border.all(
                                color: const Color.fromARGB(75, 0, 0, 0)),
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.all(15),
                        width: 320,
                        height: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            style:
                                                TextStyle(fontFamily: 'normal'),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
