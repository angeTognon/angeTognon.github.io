// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_circular_slider/multi_circular_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zth_app/main.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DashboardEmploye extends StatefulWidget {
  const DashboardEmploye({super.key});

  @override
  State<DashboardEmploye> createState() => _DashboardEmployeState();
}

class _DashboardEmployeState extends State<DashboardEmploye> {
  final GlobalKey _containerKey = GlobalKey();
  final GlobalKey _containerKey2 = GlobalKey();
  final GlobalKey _containerKey3 = GlobalKey();
  final bool _isHovered = false;
  bool anniversaire = true;
  DateTime _selectedDate = DateTime.now();
  TextEditingController descriptionController = TextEditingController();

  bool ok = false;
  @override
  void initState() {
    // TODO: implement initState
    Timer.periodic(Duration(seconds: 3), (timer) {
      getPermanenceGarde();
      getSanctions();

      if (dateSelectione == "") {
        setState(() {
          dateSelectione = DateFormat('dd/MM/yyyy').format(_selectedDate);
        });
      }
    });
    super.initState();
  }

  String dateSelectione = "";
  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        dateSelectione = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  getSalary() async {
    var url = "https://zoutechhub.com/pharmaRh/getU.php?email=$user_email";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  getPermanenceGarde() async {
    var url =
        "https://zoutechhub.com/pharmaRh/getEquipePermanenceGarde.php?email=$user_email&dateTravail=$dateSelectione";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  getSanctions() async {
    var url =
        "https://zoutechhub.com/pharmaRh/getSanctionByUser.php?email=$user_email";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  getDemande() async {
    var url =
        "https://zoutechhub.com/pharmaRh/getDemandeSalary.php?email=$user_email";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  bool travail = false;
  late String nomPrenomm = "";
  late String typee = "";

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
  String dropdownvalue = 'Cliquez ici pour choisir';

  // List of items in our dropdown menu
  var items = [
    'Cliquez ici pour choisir',
    'Demande de Congé',
    'Plainte',
    'Suggestion',
  ];
  bool show = false;
  ajouterDemande() async {
    setState(() {
      show = true;
    });
    var url =
        "https://zoutechhub.com/pharmaRh/addDemande.php?email=$user_email&typeDemande=$dropdownvalue&description=${descriptionController.text}";
    var response = await http.post(Uri.parse(url));
    print(response.body);
    print(response.statusCode);
    if (response.body == "OK") {
      setState(() {
        show = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 18, 133, 22),
          content: Text(
            "Création Réussie.",
            style: TextStyle(
              fontFamily: 'bold',
              color: Colors.white,
            ),
          )));
      Navigator.pop(context);
    } else {
      setState(() {
        show = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Erreur. Veuillez réessayer ",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: (MediaQuery.of(context).size.width * 9.7) / 12,
        // width: (MediaQuery.of(context).size.width * 13.5) / 16,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                    width: 300,
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
                                  margin: EdgeInsets.only(left: 20, right: 20),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Heureux de vous revoir ${snapshot.data[index]['prenom']} ${snapshot.data[index]['nom']} !",
                                      style: TextStyle(
                                        fontFamily: 'bold',
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                        return Center(
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: Lottie.asset("assets/images/anim.json"),
                          ),
                        );
                      },
                    ),
                  ),
                  Icon(
                    Icons.notifications,
                    color: mainColor,
                    size: 40,
                  )
                ],
              ),
              Divider(),
              h(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width * 6) / 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 350,
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
                                    ),
                                  ),
                                  //Icon
                                  SizedBox(
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
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _selectDate();
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: mainColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        DateFormat('dd/MM/yyyy')
                                            .format(_selectedDate),
                                        style: TextStyle(
                                            fontFamily: 'bold',
                                            fontSize: 14,
                                            color: Colors.white),
                                      ),
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
                                            value: 1,
                                            child: Text('Lundi'),
                                          ),
                                          const PopupMenuItem(
                                            value: 2,
                                            child: Text('Mardi'),
                                          ),
                                          const PopupMenuItem(
                                            value: 3,
                                            child: Text('Mercredi'),
                                          ),
                                          const PopupMenuItem(
                                            value: 1,
                                            child: Text('Jeudi'),
                                          ),
                                          const PopupMenuItem(
                                            value: 2,
                                            child: Text('Vendredi'),
                                          ),
                                          const PopupMenuItem(
                                            value: 3,
                                            child: Text('Samedi'),
                                          ),
                                          const PopupMenuItem(
                                            value: 3,
                                            child: Text('Dimanche'),
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
                              /* *********************** */

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: (MediaQuery.of(context).size.width *
                                            5.5) /
                                        16,
                                    child: FutureBuilder(
                                      future: ok
                                          ? getPermanenceGarde()
                                          : getPermanenceGarde(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.data.isNotEmpty) {
                                          print(
                                              snapshot.data[0]['typeActivite']);
                                          return SizedBox(
                                            height: 10,
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    5.5) /
                                                16,
                                            child: ListView.builder(
                                              itemCount: 1,
                                              itemBuilder: (context, index) =>
                                                  Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Vous êtes de ",
                                                    style: TextStyle(
                                                        fontFamily: 'normal'),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        " ${snapshot.data[index]['typeActivite']}",
                                                        style: TextStyle(
                                                            fontFamily: 'bold'),
                                                      ),
                                                      Text(
                                                        " avec ",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'normal'),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        } else {
                                          return w(2);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              h(20),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 120,
                                    width: (MediaQuery.of(context).size.width *
                                            5.5) /
                                        16,
                                    child: FutureBuilder(
                                      future: ok
                                          ? getPermanenceGarde()
                                          : getPermanenceGarde(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasError) {
                                          return Center(
                                            child: Text(
                                                "Erreur de chargement. Veuillez relancer l'application"),
                                          );
                                        }
                                        if (snapshot.hasData) {
                                          return snapshot.data.isEmpty
                                              ? Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .safety_check_rounded,
                                                            size: 50,
                                                            color: mainColor,
                                                          ),
                                                          h(5),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 20,
                                                                    right: 20),
                                                            child: Text(
                                                              "Oups, Vous n'êtes pas de garde/permanance à cette date.",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      'normal'),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : GridView.builder(
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    crossAxisSpacing: 10,
                                                    mainAxisSpacing: 10,
                                                  ),
                                                  itemCount:
                                                      snapshot.data.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Center(
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            height: 70,
                                                            width: 70,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      "assets/images/ange.jpg"),
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                          ),
                                                          h(10),
                                                          Text(
                                                            "${snapshot.data[index]['nomPrenom']}",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'bold'),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                        }
                                        return Center(
                                          child: SizedBox(
                                            height: 150,
                                            width: 150,
                                            child: Lottie.asset(
                                                "assets/images/anim.json"),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              h(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                        /* Mes fiches de paie */ Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color.fromARGB(75, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(15),
                          width: (MediaQuery.of(context).size.width * 6) / 16,
                          height: 350,
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
                                    ),
                                  ),
                                  //Icon
                                  SizedBox(
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
                                            value: 1,
                                            child: Text('Mois précédent'),
                                          ),
                                          const PopupMenuItem(
                                            value: 2,
                                            child: Text('Ce mois'),
                                          ),
                                          const PopupMenuItem(
                                            value: 3,
                                            child: Text('Mois Prochain'),
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
                              SizedBox(
                                height: 30,
                                width: 400,
                                child: FutureBuilder(
                                  future: getSalary(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
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
                                                  size: 50,
                                                  color: mainColor,
                                                ),
                                                h(20),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 20, right: 20),
                                                  child: Text(
                                                    "Oups, Vous n'avez aucun employé pour l'instant ",
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : ListView.builder(
                                              itemCount: 1,
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: const [
                                                        Text(
                                                          "FICHE TOGNON ANGE KOFFI.pdf",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'bold'),
                                                        ),
                                                      ],
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        launchUrl(Uri.parse(
                                                            "${snapshot.data![index]['fiche']}"));
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "Télécharger",
                                                            style: TextStyle(
                                                                color:
                                                                    mainColor,
                                                                fontFamily:
                                                                    'bold'),
                                                          ),
                                                          w(20),
                                                          Icon(
                                                            Icons.download,
                                                            size: 30,
                                                            color: mainColor,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                );
                                              });
                                    }
                                    return Center(
                                        child: SizedBox(
                                            height: 150,
                                            width: 150,
                                            child: Lottie.asset(
                                                "assets/images/anim.json")));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /* Container(
                    width: (MediaQuery.of(context).size.width * 3) / 16,
                  ), */
                  SizedBox(
                    width: (MediaQuery.of(context).size.width * 6) / 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /* MES SANCTIONS */ Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color.fromARGB(75, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.only(top: 15, bottom: 0),
                          width: (MediaQuery.of(context).size.width * 6) / 16,
                          height: 350,
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
                                        ),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      SizedBox(
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
                                    SizedBox(
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
                                        color: Colors.white,
                                        width: 3),
                                    SizedBox(
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
                                        color: Colors.white,
                                        width: 3),
                                    SizedBox(
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
                                        color: Colors.white,
                                        height: 40,
                                        width: 3),
                                    Expanded(
                                      child: SizedBox(
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
                              Divider(),
                              Expanded(
                                child: Container(
                                  child: FutureBuilder(
                                    future: getSanctions(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
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
                                                    size: 50,
                                                    color: mainColor,
                                                  ),
                                                  h(20),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20, right: 20),
                                                    child: Text(
                                                      "Oups, Vous n'avez aucun sanction pour l'instant ",
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : ListView.builder(
                                                itemCount: snapshot.data.length,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                right: 10),
                                                        width: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                6) /
                                                            16,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                                width: 40,
                                                                child: Center(
                                                                    child: Text(
                                                                  "${index + 1}",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'bold'),
                                                                ))),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              height: 40,
                                                              width: 3,
                                                              color: grey,
                                                            ),
                                                            SizedBox(
                                                                width: 140,
                                                                child: Center(
                                                                    child: Text(
                                                                  "${snapshot.data![index]['type_sanction']}",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'normal',
                                                                      fontSize:
                                                                          12),
                                                                ))),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              height: 40,
                                                              width: 3,
                                                              color: grey,
                                                            ),
                                                            SizedBox(
                                                                width: 80,
                                                                child: Center(
                                                                    child: Text(
                                                                  "${snapshot.data![index]['date_sanction']}",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'normal',
                                                                      fontSize:
                                                                          12),
                                                                ))),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              height: 40,
                                                              width: 3,
                                                              color: grey,
                                                            ),
                                                            Expanded(
                                                              child: SizedBox(
                                                                  width: 140,
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    "${snapshot.data![index]['motif_sanction']}",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'normal',
                                                                        fontSize:
                                                                            12),
                                                                  ))),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Divider()
                                                    ],
                                                  );
                                                });
                                      }
                                      return Center(
                                          child: SizedBox(
                                              height: 150,
                                              width: 150,
                                              child: Lottie.asset(
                                                  "assets/images/anim.json")));
                                    },
                                  ),
                                ),
                              ),
                              Divider()
                            ],
                          ),
                        ),
                        /* Boite 1 */
                        h(30),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color.fromARGB(75, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(5),
                          height: 350,
                          width: (MediaQuery.of(context).size.width * 6) / 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Mes demandes en attente",
                                      style: TextStyle(
                                        fontFamily: 'bold',
                                        fontSize: 14,
                                      ),
                                    ),
                                    //Icon
                                    SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Image.asset(
                                            "assets/images/reload_icon.png"))
                                  ],
                                ),
                              ),
                              h(10),
                              Divider(),
                              Container(
                                decoration: BoxDecoration(color: mainColor),
                                height: 40,
                                width: (MediaQuery.of(context).size.width * 6) /
                                    16,
                                child: Row(
                                  children: [
                                    SizedBox(
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
                                        color: Colors.white,
                                        width: 3),
                                    SizedBox(
                                        width: 140,
                                        child: Center(
                                            child: Text(
                                          "Type de demande",
                                          style: TextStyle(
                                              fontFamily: 'bold',
                                              color: Colors.white,
                                              fontSize: 12),
                                        ))),
                                    Container(
                                        margin:
                                            EdgeInsets.only(left: 5, right: 5),
                                        height: 40,
                                        color: Colors.white,
                                        width: 3),
                                    Expanded(
                                      child: SizedBox(
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
                                    Container(
                                        margin:
                                            EdgeInsets.only(left: 5, right: 5),
                                        color: Colors.white,
                                        height: 40,
                                        width: 3),
                                    SizedBox(
                                        width: 80,
                                        child: Center(
                                            child: Text(
                                          "Etat",
                                          style: TextStyle(
                                              fontFamily: 'bold',
                                              color: Colors.white,
                                              fontSize: 12),
                                        ))),
                                  ],
                                ),
                              ),
                              Divider(),
                              Expanded(
                                child: SizedBox(
                                  height: 300,
                                  child: FutureBuilder(
                                    future: getDemande(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
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
                                                    size: 50,
                                                    color: mainColor,
                                                  ),
                                                  h(20),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20, right: 20),
                                                    child: Text(
                                                      "Oups, Vous n'avez aucun sanction pour l'instant ",
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : ListView.builder(
                                                itemCount: snapshot.data.length,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 0,
                                                                right: 0),
                                                        width: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                6) /
                                                            16,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                                width: 40,
                                                                child: Center(
                                                                    child: Text(
                                                                  "${index + 1}",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'bold'),
                                                                ))),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              height: 40,
                                                              width: 3,
                                                              color: grey,
                                                            ),
                                                            SizedBox(
                                                                width: 140,
                                                                child: Center(
                                                                    child: Text(
                                                                  "${snapshot.data![index]['typeDemande']}",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'normal',
                                                                      fontSize:
                                                                          12),
                                                                ))),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              height: 40,
                                                              width: 3,
                                                              color: grey,
                                                            ),
                                                            Expanded(
                                                              child: SizedBox(
                                                                  width: 140,
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    "${snapshot.data![index]['description']}",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'normal',
                                                                        fontSize:
                                                                            12),
                                                                  ))),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              height: 40,
                                                              width: 3,
                                                              color: grey,
                                                            ),
                                                            Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    color: snapshot.data![index]['etat'] ==
                                                                            "Non Validé"
                                                                        ? Colors
                                                                            .red
                                                                        : mainColor),
                                                                width: 80,
                                                                child: Center(
                                                                    child: Text(
                                                                  "${snapshot.data![index]['etat']}",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'normal',
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12),
                                                                ))),
                                                          ],
                                                        ),
                                                      ),
                                                      Divider()
                                                    ],
                                                  );
                                                });
                                      }
                                      return Center(
                                          child: SizedBox(
                                              height: 150,
                                              width: 150,
                                              child: Lottie.asset(
                                                  "assets/images/anim.json")));
                                    },
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: mainColor),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(
                                              builder: (context, setState) {
                                                return AlertDialog(
                                                  actions: [
                                                    show
                                                        ? CircularProgressIndicator()
                                                        : ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        mainColor),
                                                            onPressed: () {
                                                              ajouterDemande();
                                                            },
                                                            child: Text(
                                                              "Valider",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "bold",
                                                                  color: Colors
                                                                      .white),
                                                            ))
                                                  ],
                                                  backgroundColor: Colors.white,
                                                  content: SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            2,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.6,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Faites une demande à votre employé",
                                                              style: TextStyle(
                                                                  color:
                                                                      mainColor,
                                                                  fontSize: 18,
                                                                  fontFamily:
                                                                      'bold'),
                                                            ),
                                                          ],
                                                        ),
                                                        h(10),
                                                        Divider(),
                                                        h(10),
                                                        Column(
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "1- Type de demande",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'bold',
                                                                  ),
                                                                ),
                                                                h(20),
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      2.6,
                                                                  height: 30,
                                                                  child:
                                                                      DropdownButton(
                                                                    isExpanded:
                                                                        true,
                                                                    isDense:
                                                                        true,
                                                                    value:
                                                                        dropdownvalue,
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .keyboard_arrow_down),
                                                                    items: items
                                                                        .map((String
                                                                            items) {
                                                                      return DropdownMenuItem(
                                                                        value:
                                                                            items,
                                                                        child: Text(
                                                                            items),
                                                                      );
                                                                    }).toList(),
                                                                    onChanged:
                                                                        (String?
                                                                            newValue) {
                                                                      setState(
                                                                          () {
                                                                        dropdownvalue =
                                                                            newValue!;
                                                                      });
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            h(20),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "2- Description de la demande",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'bold',
                                                                  ),
                                                                ),
                                                                h(20),
                                                                SizedBox(
                                                                  height: 190,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      2.6,
                                                                  child:
                                                                      TextFormField(
                                                                    maxLines: 7,
                                                                    controller:
                                                                        descriptionController,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelStyle: TextStyle(
                                                                          fontFamily:
                                                                              'normal',
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black45),
                                                                      border:
                                                                          OutlineInputBorder(),
                                                                      labelText:
                                                                          'Description',
                                                                    ),
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                              null ||
                                                                          value
                                                                              .isEmpty) {
                                                                        return 'Description';
                                                                      }
                                                                      return null;
                                                                    },
                                                                    onSaved:
                                                                        (value) {
                                                                      //_firstName = value!;
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
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
                        /* h(20),
                        Text(
                          "Etat des absences durant les 3 dernirs mois",
                          style: TextStyle(
                            fontFamily: 'bold',
                            fontSize: 14,
                          ),
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
                        h(30), */
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
