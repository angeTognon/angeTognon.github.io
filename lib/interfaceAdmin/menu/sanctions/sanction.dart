// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'package:http/http.dart' as http;

class GestionPleinBlame extends StatefulWidget {
  const GestionPleinBlame({super.key});

  @override
  State<GestionPleinBlame> createState() => _GestionPleinBlameState();
}

class _GestionPleinBlameState extends State<GestionPleinBlame>
    with SingleTickerProviderStateMixin {
  TextEditingController montantController = TextEditingController();
  TextEditingController montantAvanceController = TextEditingController();
  late TabController _tabController;
  int count = 0;
  final ordinalGroup = [
    OrdinalGroup(
      color: Color.fromARGB(142, 255, 17, 0),
      id: '1',
      data: [
        OrdinalData(
          domain: 'Janvier',
          measure: 3,
        ),
        OrdinalData(domain: 'Février', measure: 10),
        OrdinalData(domain: 'Mars', measure: 3),
        OrdinalData(domain: 'Avril', measure: 8),
        OrdinalData(domain: 'Mai', measure: 4.5),
        OrdinalData(domain: 'Juin', measure: 6.5),
        OrdinalData(domain: 'Juillet', measure: 6.5),
      ],
    ),
  ];
  final List<GlobalKey<State>> _containerKeys = [];
  String formattedDate1 = "";
  DateTime _selectedDate = DateTime.now();
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
          print(_selectedDate);
        });
      }
    });
  }

  void _showPopupNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: mainColor2,
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

  @override
  void initState() {
    // TODO: implement initState
    montantController.text = "0";
    for (int i = 0; i < 100; i++) {
      _containerKeys.add(GlobalKey<State>());
    }
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  var data = [
    {'category': 'Shirts', 'sales': 5},
    {'category': 'Cardigans', 'sales': 20},
    {'category': 'Chiffons', 'sales': 36},
    {'category': 'Pants', 'sales': 10},
    {'category': 'Heels', 'sales': 10},
    {'category': 'Socks', 'sales': 20},
  ];

  void calculPrime1() {}
  String _selectedValue = 'Cliquez ici pour choisir';
  final List<String> _options = [
    'Cliquez ici pour choisir',
    'Avertissement Verbal',
    'Blâme',
    'La mise à pied de 1 à 8 jours avec privation de salaire',
    'licenciement avec préavis',
    'licenciement sans préavis'
  ];

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController tache1 = TextEditingController();
  final bool _isSearching = false;
  void performSearch(String query) {
    // Ici, vous pouvez implémenter la logique de recherche en fonction de votre application
    print("Recherche pour : $query");
  }

  final GlobalKey _containerKey3 = GlobalKey();
  final GlobalKey _containerKey4 = GlobalKey();
  final GlobalKey _containerKey_add_statut = GlobalKey();
  bool show = false;
  ajouterTache(
      String typeSanction, motifSanction, dateSanction, infoSup) async {
    setState(() {
      show = true;
    });
    var url =
        "https://zoutechhub.com/pharmaRh/ajouterSanction.php?type_sanction=$typeSanction&motif_sanction=$motifSanction&date_sanction=$dateSanction&info_sup=$infoSup";
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

  getSanction() async {
    var url = "https://zoutechhub.com/pharmaRh/getAllSanctions.php";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  getSanctionByType(String typee) async {
    var url =
        "https://zoutechhub.com/pharmaRh/getSanctionByType.php?typee=$typee";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  deleteSanction(int id) async {
    setState(() {
      show = true;
    });
    var url = "https://zoutechhub.com/pharmaRh/deleteSanction.php?id=$id";
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
            "Supression Réussie.",
            style: TextStyle(
              fontFamily: 'normal',
              color: Colors.white,
            ),
          )));
      //Navigator.pop(context);
    } else {
      setState(() {
        show = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Erreur. Veuillez actualiser la page",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));
      });
    }
  }

  bool ok1 = false;
  bool ok2 = false;
  bool ok3 = false;
  bool ok4 = false;
  bool ok5 = false;
  int index = 0;
  String type = "";
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(30),
        height: MediaQuery.of(context).size.height,
        width: (MediaQuery.of(context).size.width * 9.7) / 12,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Santions ",
                        style: TextStyle(
                            fontFamily: 'bold', fontSize: 23, color: mainColor),
                      ),
                      h(30),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          "Gérez plus facilement les sanctions de vos clients",
                          style: TextStyle(
                              fontFamily: 'normal',
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
                              padding: EdgeInsets.all(20)),
                          onPressed: () => {pleinteMethode("")},
                          child: Text(
                            "Ajouter une sanction",
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'bold'),
                          ))
                    ],
                  )
                ],
              ),
              h(30),
              TabBar(
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                indicatorColor: mainColor,
                onTap: (value) {
                  setState(() {
                    index = value;
                  });
                },
                controller: _tabController,
                tabs: [
                  Tab(
                    child: Row(
                      children: [
                        Icon(Icons.attach_money_rounded,
                            color: index == 0 ? mainColor : Colors.grey,
                            size: 25),
                        w(20),
                        Text(
                          "Gestion des Sanctions",
                          style: TextStyle(
                              fontFamily: 'bold',
                              color: index == 0 ? mainColor : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_pin,
                          color: index == 1 ? mainColor2 : Colors.grey,
                          size: 25,
                        ),
                        w(20),
                        Text(
                          "Statistiques des Sanctions",
                          style: TextStyle(
                              fontFamily: 'bold',
                              color: index == 1 ? mainColor : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              h(20),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                final RenderBox container = _containerKey3
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
                                    containerPosition.dy + containerSize.height,
                                    MediaQuery.of(context).size.width -
                                        containerPosition.dx -
                                        containerSize.width,
                                    0,
                                  ),
                                  items: [
                                    /*     '',
                        '',
                        '',
                        '',
                        '' */
                                    PopupMenuItem(
                                      onTap: () {
                                        setState(() {
                                          ok1 = true;
                                          ok2 = false;
                                          ok3 = false;
                                          ok4 = false;
                                          ok5 = false;
                                        });
                                      },
                                      value: 2,
                                      child: Text(
                                        "Avertissement Verbal",
                                        style: TextStyle(
                                            fontFamily: 'normal', fontSize: 13),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        setState(() {
                                          ok1 = false;
                                          ok2 = true;
                                          ok3 = false;
                                          ok4 = false;
                                          ok5 = false;
                                        });
                                      },
                                      value: 2,
                                      child: Text(
                                        'Blâme',
                                        style: TextStyle(
                                            fontFamily: 'normal', fontSize: 13),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        setState(() {
                                          ok1 = false;
                                          ok2 = false;
                                          ok3 = true;
                                          ok4 = false;
                                          ok5 = false;
                                        });
                                      },
                                      value: 2,
                                      child: Text(
                                        'La mise à pied de 1 à 8 jours avec privation de salaire',
                                        style: TextStyle(
                                            fontFamily: 'normal', fontSize: 13),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        setState(() {
                                          ok1 = false;
                                          ok2 = false;
                                          ok3 = false;
                                          ok4 = true;
                                          ok5 = false;
                                        });
                                      },
                                      value: 2,
                                      child: Text(
                                        'licenciement avec préavis',
                                        style: TextStyle(
                                            fontFamily: 'normal', fontSize: 13),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        setState(() {
                                          ok1 = false;
                                          ok2 = false;
                                          ok3 = false;
                                          ok4 = false;
                                          ok5 = true;
                                        });
                                      },
                                      value: 2,
                                      child: Text(
                                        'licenciement sans préavis',
                                        style: TextStyle(
                                            fontFamily: 'normal', fontSize: 13),
                                      ),
                                    ),
                                  ],

                                  elevation:
                                      8.0, // Adjust the elevation for the box shadow
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 5, right: 5, top: 5, bottom: 5),
                                width: 220,
                                height: 35,
                                key: _containerKey3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black26)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Trier par type de Sanction",
                                      style: TextStyle(
                                          fontFamily: 'normal',
                                          fontSize: 13,
                                          color: const Color.fromARGB(
                                              154, 0, 0, 0)),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down_rounded,
                                      color: const Color.fromARGB(154, 0, 0, 0),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            w(20),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  ok1 = false;
                                  ok2 = false;
                                  ok3 = false;
                                  ok4 = false;
                                  ok5 = false;
                                });
                              },
                              child: SizedBox(
                                height: 25,
                                width: 25,
                                child: Image.asset(
                                    "assets/images/reload_icon.png"),
                              ),
                            )
                          ],
                        ),
                        h(20),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: mainColor3,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 300,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "Nom et Prénoms de l'employé",
                                    style: TextStyle(
                                        fontFamily: 'bold', fontSize: 13),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 3,
                                color: Colors.white54,
                              ),
                              Container(
                                height: 50,
                                width: 3,
                                color: Colors.white54,
                              ),
                              SizedBox(
                                width: 200,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "Type de Sanction",
                                    style: TextStyle(
                                        fontFamily: 'bold', fontSize: 13),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 3,
                                color: Colors.white54,
                              ),
                              SizedBox(
                                width: 150,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "Date de Sanction",
                                    style: TextStyle(
                                        fontFamily: 'bold', fontSize: 13),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 3,
                                color: Colors.white54,
                              ),
                              SizedBox(
                                width: 400,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "Motif de Sanction",
                                    style: TextStyle(
                                        fontFamily: 'bold', fontSize: 13),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 3,
                                color: Colors.white54,
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      "Action",
                                      style: TextStyle(
                                          fontFamily: 'bold', fontSize: 13),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        h(5),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width,
                          child: FutureBuilder(
                            future: ok1
                                ? getSanctionByType("Avertissement Verbal")
                                : ok2
                                    ? getSanctionByType("Blâme")
                                    : ok3
                                        ? getSanctionByType(
                                            "La mise à pied de 1 à 8 jours avec privation de salaire")
                                        : ok4
                                            ? getSanctionByType(
                                                "licenciement avec préavis")
                                            : ok5
                                                ? getSanctionByType(
                                                    "licenciement sans préavis")
                                                : getSanction(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
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
                                            size: 100,
                                            color: mainColor,
                                          ),
                                          h(20),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Text(
                                              "Oups, Aucun employé Archivé pour l'instant ",
                                              style: TextStyle(fontSize: 17),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      )
                                    : ListView.builder(
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) {
                                          return BoxUser(
                                              "${snapshot.data![index]['personne']}",
                                              0,
                                              "${snapshot.data![index]['type_sanction']}",
                                              "${snapshot.data![index]['date_sanction']}",
                                              "${snapshot.data![index]['motif_sanction']}",
                                              index,
                                              int.parse(
                                                  "${snapshot.data![index]['id']}"));
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
                        h(20),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Détails des sanctions de l'année ",
                          style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 17,
                              color: mainColor),
                        ),
                        h(20),
                        SizedBox(
                          height: 500,
                          width: 500,
                          child: Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: DChartBarO(
                                  areaColor: (group, ordinalData, index) {
                                    if (ordinalData == 10) {
                                      mainColor2;
                                    }
                                    return null;
                                  },
                                  groupList: ordinalGroup,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  BoxUser(String nomprenom, double nbrSanction, String typeSanction,
      dateSanction, motifSanction, int index, u) {
    return Column(
      children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              SizedBox(
                width: 300,
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
                    SizedBox(
                      width: 200,
                      child: Text(
                        nomprenom,
                        style: TextStyle(
                            fontFamily: 'normal',
                            color: Colors.black,
                            fontSize: 14),
                        textAlign: TextAlign.start,
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
              SizedBox(
                width: 200,
                height: 50,
                child: Center(
                  child: Text(
                    '$typeSanction ',
                    style: TextStyle(
                        fontFamily: 'normal',
                        color: Colors.black,
                        fontSize: 13),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 3,
                color: Color.fromARGB(19, 0, 0, 0),
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: Center(
                  child: Text(
                    dateSanction,
                    style: TextStyle(
                        fontFamily: 'normal',
                        color: Colors.black,
                        fontSize: 14),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 3,
                color: Color.fromARGB(19, 0, 0, 0),
              ),
              SizedBox(
                width: 400,
                height: 50,
                child: Center(
                  child: Text(
                    motifSanction,
                    style: TextStyle(
                        fontFamily: 'normal',
                        color: Colors.black,
                        fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 3,
                color: Color.fromARGB(19, 0, 0, 0),
              ),
              Expanded(
                child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(149, 255, 255, 255),
                              padding: EdgeInsets.all(15)),
                          onPressed: () {
                            final RenderBox container = _containerKeys[index]
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
                                  containerPosition.dy + containerSize.height,
                                  MediaQuery.of(context).size.width -
                                      containerPosition.dx -
                                      containerSize.width,
                                  0,
                                ),
                                items: [
                                  PopupMenuItem(
                                    onTap: () {},
                                    value: 2,
                                    child: Text(
                                      "Télécharger la fiche de sanction de l'employé",
                                      style: TextStyle(fontFamily: 'normal'),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      deleteSanction(u);
                                    },
                                    value: 2,
                                    child: Text(
                                      "Supprimer la Sanction",
                                      style: TextStyle(fontFamily: 'normal'),
                                    ),
                                  ),
                                ]);
                          },
                          child: SizedBox(
                            key: _containerKeys[index],
                            height: 30,
                            width: 30,
                            child: Image.asset("assets/images/more_icon.png"),
                          ),
                        )
                      ],
                    )),
              ),
              Container(
                height: 50,
                width: 3,
                color: Color.fromARGB(19, 0, 0, 0),
              ),
            ],
          ),
        ),
        Divider()
      ],
    );
  }

  TextEditingController infoSupController = TextEditingController();
  TextEditingController motifController = TextEditingController();
  addSanction(BuildContext context, String idPersonne, personne, typeSanction,
      motifSanction, dateSanction, infoSup) async {
    setState(() {
      show = true;
    });
    var url =
        "https://zoutechhub.com/pharmaRh/ajouterSanction.php?id_personne=$idPersonne&personne=$personne&type_sanction=$typeSanction&motif_sanction=$motifSanction&date_sanction=$dateSanction&info_sup=$infoSup";
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
            "Ajout Réussie.",
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
              "Erreur. Veuillez actualiser la page",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));
      });
    }
  }

  getSalary() async {
    var url = "https://zoutechhub.com/pharmaRh/getSalaryNomPrenom.php";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  final List<List<String>> _selectedOptionsPerIndex = [];
  void updateSelectedOptions(int index) {
    if (index < _selectedOptionsPerIndex.length &&
        _selectedOptionsPerIndex.isNotEmpty) {
      for (int i = 0; i < _options.length; i++) {
        if (i < _selectedOptions.length) {
          _selectedOptions[i] =
              _selectedOptionsPerIndex[index].contains(_options[i]);
        } else {
          _selectedOptions
              .add(_selectedOptionsPerIndex[index].contains(_options[i]));
        }
      }
    } else {
      // Si l'index est en dehors de la plage de _selectedOptionsPerIndex,
      // ou si _selectedOptionsPerIndex est vide, on réinitialise _selectedOptions à false
      while (_selectedOptions.length < _options.length) {
        _selectedOptions.add(false);
      }
    }
  }

  final List<String> _selectedPersonnes = [];
  final List<String> _idPersonnes = [];

  bool isOK = false;

  void _showMultiSelectMenu(int index) {
    setState(() {
      if (_selectedOptionsPerIndex.isNotEmpty &&
          index < _selectedOptionsPerIndex.length) {
        updateSelectedOptions(index);
      } else {
        // Si _selectedOptionsPerIndex est vide ou si l'index est en dehors de la plage,
        // on réinitialise _selectedOptions à false
        while (_selectedOptions.length < _options.length) {
          _selectedOptions.add(false);
        }
      }
    });

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            surfaceTintColor: Colors.white,
            title: Text(
              'Choisissez les personnes à qui\nvous souhaitez attribuer ces tâches',
              style: TextStyle(fontFamily: 'normal', fontSize: 15),
              textAlign: TextAlign.center,
            ),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 2.5,
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
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: Text(
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
                              updateSelectedOptions(index);
                              return CheckboxListTile(
                                title: Row(
                                  children: [
                                    CircleAvatar(
                                      child: Center(
                                        child: Icon(Icons.person),
                                      ),
                                    ),
                                    w(20),
                                    Text(
                                        "${snapshot.data[index]['prenom']} ${snapshot.data[index]['nom']}"),
                                  ],
                                ),
                                value: _selectedOptions[index],
                                onChanged: (value) {
                                  setState(() {
                                    /* _idPersonnes */
                                    _selectedOptions[index] = value!;
                                    if (value) {
                                      _selectedPersonnes.add(
                                          "${snapshot.data[index]['prenom']} ${snapshot.data[index]['nom']}");
                                      _idPersonnes
                                          .add("${snapshot.data[index]['id']}");
                                    } else {
                                      _selectedPersonnes.remove(
                                          "${snapshot.data[index]['prenom']} ${snapshot.data[index]['nom']}");
                                      _idPersonnes.remove(
                                          "${snapshot.data[index]['id']}");
                                    }
                                  });
                                },
                              );
                            },
                          );
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
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isOK = true;
                    print("**************");
                    print(_selectedPersonnes);
                    Navigator.pop(context);
                  });
                },
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }

  final List<bool> _selectedOptions = [];

  pleinteMethode(String nomprenom) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            backgroundColor: Colors.white,
            content: Container(
              padding: EdgeInsets.all(10),
              height: (MediaQuery.of(context).size.height) / 1.33,
              width: MediaQuery.of(context).size.width / 2,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ajout d'une Sanction à l'employé $nomprenom",
                        style: TextStyle(
                            fontFamily: 'bold',
                            color: Colors.black,
                            fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  h(07),
                  Divider(),
                  h(07),
                  Text(
                    "1- Nom & Prénom des Employés : ",
                    style: TextStyle(
                        fontFamily: 'bold',
                        color: Colors.black87,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  h(15),
                  SizedBox(
                    height: 180,
                    width: MediaQuery.of(context).size.width / 2,
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
                                      margin:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: Text(
                                        "Oups, Vous n'avez aucun employé pour l'instant ",
                                        style: TextStyle(fontSize: 17),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                )
                              : Wrap(
                                  spacing:
                                      10.0, // Espace horizontal entre les éléments
                                  runSpacing:
                                      10.0, // Espace vertical entre les lignes
                                  children: List.generate(
                                    snapshot.data.length,
                                    (index) {
                                      updateSelectedOptions(index);
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset:
                                                  Offset(0, 3), // Ombre en bas
                                            ),
                                          ],
                                        ),
                                        padding: EdgeInsets.all(0),
                                        height: 50,
                                        width: 240,
                                        child: CheckboxListTile(
                                          dense: true,
                                          activeColor: mainColor,
                                          title: Row(
                                            children: [
                                              CircleAvatar(
                                                child: Center(
                                                  child: Icon(Icons.person),
                                                ),
                                              ),
                                              w(20),
                                              Expanded(
                                                child: Text(
                                                  "${snapshot.data[index]['prenom']} ${snapshot.data[index]['nom']}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'normal'), // Gère le débordement si le texte est trop long
                                                ),
                                              ),
                                            ],
                                          ),
                                          value: _selectedOptions[index],
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedOptions[index] = value!;
                                              if (value) {
                                                _idPersonnes.add(
                                                    "${snapshot.data[index]['salaireBase']}");
                                                _selectedPersonnes.add(
                                                    "${snapshot.data[index]['prenom']} ${snapshot.data[index]['nom']}");
                                              } else {
                                                _idPersonnes.remove(
                                                    "${snapshot.data[index]['id']}");
                                                _selectedPersonnes.remove(
                                                    "${snapshot.data[index]['prenom']} ${snapshot.data[index]['nom']}");
                                              }
                                            });
                                          },
                                        ),
                                      );
                                    },
                                  ));
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
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "2- Type de Sanction : ",
                            style: TextStyle(
                                fontFamily: 'bold',
                                color: Colors.black87,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            width: 350,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _selectedValue,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedValue = newValue!;
                                });
                              },
                              items: _options.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          h(15),
                          Text(
                            "Motif de la Sanction",
                            style: TextStyle(
                                fontFamily: 'bold',
                                color: Colors.black87,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          h(10),
                          SizedBox(
                            height: 150,
                            width: 350,
                            child: TextFormField(
                              controller: motifController,
                              maxLines: 8,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                labelText: 'Motif de la sanction',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: _selectedDate ?? DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                ).then((pickedDate) {
                                  if (pickedDate != null) {
                                    setState(() {
                                      _selectedDate = pickedDate;
                                      formattedDate1 =
                                          "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year.toString()}";
                                      print(formattedDate1);
                                    });
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Date de la sanction',
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () {},
                                ),
                              ),
                              readOnly: true,
                              controller: TextEditingController(
                                  text: formattedDate1 != ""
                                      ? formattedDate1
                                      : "Cliquez ici pour choisir"),
                            ),
                          ),
                          h(30),
                          Text(
                            "Information Suplémentaire",
                            style: TextStyle(
                                fontFamily: 'bold',
                                color: Colors.black87,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          h(10),
                          SizedBox(
                            height: 40,
                            width: 300,
                            child: TextFormField(
                              controller: infoSupController,
                              maxLines: 8,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                labelText: 'Information Suplémentaire',
                              ),
                            ),
                          ),
                          h(30),
                          show
                              ? CircularProgressIndicator()
                              : InkWell(
                                  onTap: () {
                                    setState(
                                      () {
                                        for (int i = 0;
                                            i < _selectedPersonnes.length;
                                            i++) {
                                          print(i);
                                          setState(() {
                                            addSanction(
                                                context,
                                                _idPersonnes[i],
                                                _selectedPersonnes[i],
                                                _selectedValue,
                                                motifController.text,
                                                formattedDate1,
                                                "");
                                          });
                                        }
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    height: 40,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: mainColor2),
                                    child: Center(
                                      child: Text(
                                        "Confirmer",
                                        style: TextStyle(
                                            fontFamily: 'normal',
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
