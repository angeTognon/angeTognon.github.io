import 'package:flutter/material.dart';
import 'package:zth_app/widgets/wid_var.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: (MediaQuery.of(context).size.width * 9.7) / 12,
      color: const Color.fromARGB(255, 255, 255, 255),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Heureux de vous revoir\nKoffi !",
                  style: TextStyle(fontFamily: 'bold', fontSize: 18),
                ),
                Icon(
                  Icons.notifications,
                  color: mainColor,
                  size: 40,
                )
              ],
            ),
            h(7),
            const Divider(),
            h(15),
            Counters(),
            h(20),
            const Text(
              "Apperçu des présences",
              style: TextStyle(fontFamily: 'bold', fontSize: 18),
            ),
            h(20),
            EnteteBoxPresence(context),
            ContenuBoxPresence(context, "Marc ADIDJI", "marcadidji@gmail.com",
                "#23454GH6J7YT6", "Développeur web", "07h38 le 01/10/2024"),
            ContenuBoxPresence(context, "Marc ADIDJI", "marcadidji@gmail.com",
                "#23454GH6J7YT6", "Développeur web", "07h38 le 01/10/2024"),
            ContenuBoxPresence(context, "Marc ADIDJI", "marcadidji@gmail.com",
                "#23454GH6J7YT6", "Développeur web", "07h38 le 01/10/2024"),
            ContenuBoxPresence(context, "Marc ADIDJI", "marcadidji@gmail.com",
                "#23454GH6J7YT6", "Développeur web", "07h38 le 01/10/2024"),
            h(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [BoxDemande(), EvenementAvenir()],
            ),
            h(20),
          ],
        ),
      ),
    );
  }

  BoxDemande() {
    return Expanded(
      child: Card(
        color: const Color.fromARGB(255, 245, 245, 245),
        child: Container(
          padding: const EdgeInsets.all(0),
          height: 250,
          width: 600,
          child: Column(
            children: [
              Container(
                width: 600,
                padding: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: const Center(
                  child: Text(
                    "Demandes en attentes",
                    style: TextStyle(fontFamily: 'bold', fontSize: 15),
                  ),
                ),
              ),
              Container(
                  width: 600,
                  padding: const EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 260,
                        child: Text(
                          "Employé",
                          style: TextStyle(fontFamily: 'normal'),
                        ),
                      ),
                      const SizedBox(
                        width: 200,
                        child: Text(
                          "Objet",
                          style: TextStyle(fontFamily: 'normal'),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: const Center(
                          child: Text(
                            "Action",
                            style: TextStyle(fontFamily: 'normal'),
                          ),
                        ),
                      ))
                    ],
                  )),
              ContenuBoxDemande(
                  "Marc ADIDJI", "marcadidji@gmail.com", "Demande de congé"),
              ContenuBoxDemande("Christelle AZAN", "azanchristelle@gmail.com",
                  "Demande de démission"),
            ],
          ),
        ),
      ),
    );
  }

  ContenuBoxDemande(String nom, email, objet) {
    return Container(
        width: 600,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, border: Border.all(color: Colors.black12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 260,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 20,
                    child: Icon(
                      Icons.person,
                      size: 20,
                    ),
                  ),
                  w(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nom,
                        style: const TextStyle(fontFamily: 'bold'),
                      ),
                      Text(
                        email,
                        style:
                            const TextStyle(fontFamily: 'normal', fontSize: 13),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              width: 200,
              child: Text(
                objet,
                style: const TextStyle(fontFamily: 'bold'),
              ),
            ),
            Expanded(
                child: Container(
              child: const Center(
                  child: Icon(
                Icons.remove_red_eye,
                color: Colors.green,
              )),
            ))
          ],
        ));
  }

  EnteteBoxPresence(
    BuildContext context,
  ) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 230, 230, 230),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: Row(
        children: [
          SizedBox(
            width: 350,
            height: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  w(30),
                  const Text(
                    "Employés",
                    style: TextStyle(fontFamily: 'normal'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 200,
            height: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "ID Employé",
                    style: TextStyle(fontFamily: 'normal'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 200,
            height: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Poste",
                    style: TextStyle(fontFamily: 'normal'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 200,
            height: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Statut",
                    style: TextStyle(fontFamily: 'normal'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 200,
            height: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Heure de pointage",
                    style: TextStyle(fontFamily: 'normal'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ContenuBoxPresence(
      BuildContext context, String name, email, id, poste, heure) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          SizedBox(
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  w(20),
                  const CircleAvatar(
                    radius: 25,
                    child: Icon(
                      Icons.person,
                      size: 25,
                    ),
                  ),
                  w(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontFamily: 'bold'),
                      ),
                      Text(
                        email,
                        style:
                            const TextStyle(fontFamily: 'normal', fontSize: 13),
                      )
                    ],
                  )
                ],
              )),
          SizedBox(
            width: 195,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 230, 230, 230),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Text(
                    id,
                    style: const TextStyle(fontFamily: 'normal'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
              width: 200,
              height: 40,
              child: Row(
                children: [
                  Text(
                    poste,
                    style: const TextStyle(fontFamily: 'normal'),
                  )
                ],
              )),
          SizedBox(
            width: 200,
            height: 40,
            child: Center(
              child: Row(
                children: [
                  Container(
                    height: 25,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFFecfdf3)),
                    child: Center(
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.green,
                          ),
                          w(10),
                          const Text(
                            "A l'heure",
                            style: TextStyle(
                                color: Colors.green, fontFamily: 'bold'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 200,
            height: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    heure,
                    style: const TextStyle(fontFamily: 'bold'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Counters() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    begin: Alignment.topLeft, colors: [mainColor, mainColor2])),
            height: 150,
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      minRadius: 35,
                      child: Icon(
                        Icons.person,
                        color: mainColor,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                h(2),
                const Text(
                  "Plaintes et Suggestions",
                  style: TextStyle(color: Colors.white, fontFamily: 'normal'),
                ),
                const Text(
                  "3",
                  style: TextStyle(
                      color: Colors.white, fontSize: 25, fontFamily: 'normal'),
                )
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    begin: Alignment.topLeft, colors: [mainColor, Colors.red])),
            height: 150,
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      minRadius: 35,
                      child: Icon(
                        Icons.wallet,
                        color: mainColor,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                h(2),
                const Text(
                  "Fiches de Paie traité",
                  style: TextStyle(color: Colors.white, fontFamily: 'normal'),
                ),
                const Text(
                  "7",
                  style: TextStyle(
                      color: Colors.white, fontSize: 25, fontFamily: 'normal'),
                )
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    begin: Alignment.topLeft, colors: [mainColor, mainColor2])),
            height: 150,
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      minRadius: 35,
                      child: Icon(
                        Icons.attach_money,
                        color: mainColor,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                h(2),
                const Text(
                  "Salaires traités",
                  style: TextStyle(color: Colors.white, fontFamily: 'normal'),
                ),
                const Text(
                  "37",
                  style: TextStyle(
                      color: Colors.white, fontSize: 25, fontFamily: 'normal'),
                )
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [mainColor, Colors.yellow])),
            height: 150,
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      minRadius: 35,
                      child: Icon(
                        Icons.person,
                        color: mainColor,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                h(2),
                const Text(
                  "Contractualisation",
                  style: TextStyle(color: Colors.white, fontFamily: 'normal'),
                ),
                const Text(
                  "24",
                  style: TextStyle(
                      color: Colors.white, fontSize: 25, fontFamily: 'normal'),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  EvenementAvenir() {
    return Expanded(
      child: Card(
        color: const Color.fromARGB(255, 245, 245, 245),
        child: Container(
          height: 250,
          padding: const EdgeInsets.all(0),
          width: 600,
          child: Column(
            children: [
              Container(
                width: 600,
                padding: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: const Center(
                  child: Text(
                    "Evènements à venir",
                    style: TextStyle(fontFamily: 'bold', fontSize: 15),
                  ),
                ),
              ),
              h(24),
              Wrap(
                runSpacing: 5,
                spacing: 30,
                children: [
                  Container(
                    height: 160,
                    width: 230,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        h(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.cake,
                              color: mainColor,
                              size: 80,
                            ),
                            Text(
                              "04/10/2024 ",
                              style: TextStyle(
                                  fontFamily: 'bold',
                                  fontSize: 16,
                                  color: mainColor),
                            ),
                          ],
                        ),
                        h(5),
                        const Text(
                          "Anniversaire de l'employé  ",
                          style: TextStyle(fontFamily: 'normal', fontSize: 14),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Marc ADIDJI ",
                              style:
                                  TextStyle(fontFamily: 'bold', fontSize: 17),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 160,
                    width: 230,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        h(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.workspace_premium,
                              color: mainColor,
                              size: 80,
                            ),
                            Text(
                              "01/01/2025 ",
                              style: TextStyle(
                                  fontFamily: 'bold',
                                  fontSize: 16,
                                  color: mainColor),
                            ),
                          ],
                        ),
                        h(5),
                        const Text(
                          "Prime de Service  ",
                          style: TextStyle(fontFamily: 'normal', fontSize: 14),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Marc ADIDJI ",
                              style:
                                  TextStyle(fontFamily: 'bold', fontSize: 17),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

/* import 'package:flutter/cupertino.dart';
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              h(20),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Gestion des plaintes et suggestions",
                                    style: TextStyle(
                                        fontFamily: 'bold',
                                        fontSize: 14,
                                        color: Colors.black),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Traitement des Fiches de Paie",
                                    style: TextStyle(
                                      fontFamily: 'bold',
                                      fontSize: 14,
                                    ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                            containerSize
                                                                .height,
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            containerPosition
                                                                .dx -
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
                                                          child:
                                                              Text('Ce mois'),
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
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color: Colors
                                                                .black26)),
                                                    child: const Row(
                                                      children: [
                                                        Text(
                                                          "Ce mois",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'normal',
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .black38),
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
                                              style: TextStyle(
                                                  fontFamily: 'normal'),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Traitement des Salaire",
                                    style: TextStyle(
                                      fontFamily: 'bold',
                                      fontSize: 14,
                                    ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                            containerSize
                                                                .height,
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            containerPosition
                                                                .dx -
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
                                                          child:
                                                              Text('Ce mois'),
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
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color: Colors
                                                                .black26)),
                                                    child: const Row(
                                                      children: [
                                                        Text(
                                                          "Ce mois",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'normal',
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .black38),
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
                                              style: TextStyle(
                                                  fontFamily: 'normal'),
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
                          width: 350,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Gestion des Présences",
                                    style: TextStyle(
                                      fontFamily: 'bold',
                                      fontSize: 14,
                                    ),
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
                              h(60),
                              Container(
                                height: 150,
                                margin: EdgeInsets.only(left: 50, right: 50),
                                child: MultiCircularSlider(
                                  size: 240,
                                  showTotalPercentage: true,
                                  progressBarType:
                                      MultiCircularSliderType.circular,
                                  values: [0.5, 0.1, 0.4],
                                  colors: [
                                    mainColor,
                                    Color.fromARGB(255, 251, 157, 26),
                                    Color.fromARGB(255, 139, 30, 30),
                                  ],
                                ),
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          backgroundColor: Color.fromARGB(
                                              255, 251, 157, 26)),
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
                                          Color.fromARGB(255, 139, 30, 30)),
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
                          width: 350,
                          height: 260,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Informations Présences",
                                    style: TextStyle(
                                      fontFamily: 'bold',
                                      fontSize: 14,
                                    ),
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
                        h(45)
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
                                    ),
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
                          height: 220,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Contractualisation ",
                                    style: TextStyle(
                                      fontFamily: 'bold',
                                      fontSize: 14,
                                    ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      h(10),
                                      Container(
                                        width: 450,
                                        child: Column(
                                          children: [
                                            const Text(
                                              "Rien pour L'instant",
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
                  ),
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
 */