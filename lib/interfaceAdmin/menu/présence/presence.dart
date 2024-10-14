import 'dart:convert';
import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zth_app/interfaceAdmin/menu/pr%C3%A9sence/presence_m.dart';
import 'package:zth_app/interfaceAdmin/menu/sanctions/sanction.dart';
import 'package:zth_app/interfaceAdmin/menu/salaire/gestion_pret_avancement.dart';
import 'package:zth_app/interfaceAdmin/menu/salaire/gestion_prime.dart';
import 'package:zth_app/interfaceAdmin/menu/planning/planning_employ%C3%A9.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;

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

  getSalary() async {
    var url = "https://zoutechhub.com/pharmaRh/getCountSalary.php";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    print(response.body);
    return pub;
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height,
      width: (MediaQuery.of(context).size.width * 9.7) / 12,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Présence ", //${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year},
              style:
                  TextStyle(fontFamily: 'bold', fontSize: 20, color: mainColor),
            ),
            h(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 200,
                  width: 250,
                  decoration: BoxDecoration(
                    color: mainColor3,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.light_mode_outlined,
                            color: Colors.amber,
                            size: 50,
                          ),
                          Text(
                            "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
                            style: const TextStyle(
                                fontFamily: 'bold',
                                fontSize: 26,
                                color: Color.fromARGB(160, 0, 0, 0)),
                          )
                        ],
                      ),
                      h(40),
                      Text(
                        "Aujourd'hui : \n${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        style: const TextStyle(
                          fontFamily: 'bold',
                          color: Color.fromARGB(160, 0, 0, 0),
                          fontSize: 17,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, top: 2, bottom: 2),
                    margin: const EdgeInsets.only(left: 0),
                    width: 330,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 180,
                            width: 300,
                            child: FutureBuilder(
                              future: getSalary(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return const Center(
                                    child: Text(
                                        "Erreur de chargement. Veuillez relancer l'application"),
                                  );
                                }
                                if (snapshot.hasData) {
                                  return snapshot.data.isEmpty
                                      ? Column(
                                          children: [
                                            h(20),
                                            Icon(
                                              Icons.safety_check_rounded,
                                              size: 100,
                                              color: mainColor,
                                            ),
                                            h(20),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: const Text(
                                                "Oups, Vous n'avez aucun employé pour l'instant ",
                                                style: TextStyle(fontSize: 17),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        )
                                      : ListView.builder(
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index) {
                                            print("**********"
                                                "${snapshot.data.length}");
                                            return Counters(
                                                "${snapshot.data["total_count"]}");
                                          },
                                        );
                                }
                                return Center(
                                  child: SizedBox(
                                    height: 150,
                                    width: 150,
                                    child:
                                        Lottie.asset("assets/images/anim.json"),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                        const PopupMenuItem(
                          value: 2,
                          child: Text(
                            "Aujourd'hui",
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Text(
                            'Hier',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Text(
                            'Avant hier',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Text(
                            'Cette Semaine',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Text(
                            'La Semaine Dernière',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Text(
                            'Le mois dernier',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                        ),
                      ],
                      elevation: 8.0, // Adjust the elevation for the box shadow
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 5, bottom: 5),
                    width: 210,
                    height: 35,
                    key: _containerKey1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black26)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Trier par Date",
                          style: TextStyle(
                              fontFamily: 'normal',
                              fontSize: 13,
                              color: Color.fromARGB(154, 0, 0, 0)),
                        ),
                        Icon(
                          Icons.arrow_drop_down_rounded,
                          color: Color.fromARGB(154, 0, 0, 0),
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
                        const PopupMenuItem(
                          value: 2,
                          child: Text(
                            "Retard",
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Text(
                            'Absence',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                        ),
                      ],
                      elevation: 8.0, // Adjust the elevation for the box shadow
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 5, bottom: 5),
                    width: 210,
                    height: 35,
                    key: _containerKey2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black26)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Trier par Etat",
                          style: TextStyle(
                              fontFamily: 'normal',
                              fontSize: 13,
                              color: Color.fromARGB(154, 0, 0, 0)),
                        ),
                        Icon(
                          Icons.arrow_drop_down_rounded,
                          color: Color.fromARGB(154, 0, 0, 0),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            h(20),
            const PresenceM(),
          ],
        ),
      ),
    );
  }

  Counters(String total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [Colors.black54, mainColor2])),
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
                  "Nombre Total d'employés",
                  style: TextStyle(color: Colors.white, fontFamily: 'normal'),
                ),
                Text(
                  total,
                  style: const TextStyle(
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
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [Colors.black54, Colors.red])),
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
                  "En retard",
                  style: TextStyle(color: Colors.white, fontFamily: 'normal'),
                ),
                const Text(
                  "1",
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
                    colors: [Colors.black54, mainColor2])),
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
                  "A l'heure ",
                  style: TextStyle(color: Colors.white, fontFamily: 'normal'),
                ),
                const Text(
                  "2",
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

  BoxU(String nomPrenom, nbrJour) {
    return Container(
      height: 50,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          SizedBox(
            width: 400,
            height: 50,
            child: Center(
              child: Text(
                nomPrenom,
                style: const TextStyle(
                    fontFamily: 'normal', color: Colors.black, fontSize: 14),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 3,
            color: const Color.fromARGB(19, 0, 0, 0),
          ),
          SizedBox(
            width: 300,
            height: 50,
            child: Center(
              child: Text(
                nbrJour,
                style: const TextStyle(
                    fontFamily: 'normal', color: Colors.black, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
