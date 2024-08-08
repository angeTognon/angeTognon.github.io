import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zth_app/interfaceAdmin/menu/planning/creat_group_salary.dart';
import 'package:zth_app/interfaceAdmin/menu/sanctions/sanction.dart';
import 'package:zth_app/interfaceAdmin/menu/salaire/gestion_pret_avancement.dart';
import 'package:zth_app/interfaceAdmin/menu/salaire/gestion_prime.dart';
import 'package:zth_app/interfaceAdmin/menu/planning/planning_employ%C3%A9.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;

class Planning extends StatefulWidget {
  const Planning({super.key});

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning>
    with SingleTickerProviderStateMixin {
  getEquipe() async {
    var url = "https://zoutechhub.com/pharmaRh/getEquipe.php";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (timer) {
      _fetchMenuItems();
      print("ok");
    });
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int index = 0;
  bool reload = false;
  bool show = false;
  GlobalKey _containerKey0 = GlobalKey();
  GlobalKey _containerKey1 = GlobalKey();
  TextEditingController tacheController = TextEditingController();
  List<String> _menuItems = [];
  String _selectedOption = '';
  List<String>  idGroupe = [];

  Future<void> _fetchMenuItems() async {
    final response = await http
        .get(Uri.parse('https://zoutechhub.com/pharmaRh/getEquipe.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;

      final members = data.map((item) => "Groupe N° ${item['id']}").toList();
      final id = data.map((item) => "${item['id']}").toList();
      setState(() {
        idGroupe=id;
        _menuItems = members;
        print(_menuItems);
      });
    } else {
      throw Exception('Failed to fetch menu items');
    }
  }

  int _selectedIndex = 0;
  bool cbon = false;
  DateTime _selectedDate0 = DateTime.now();
  String formattedDate1 = "";

   ajouterTache(String id_groupe,tache_, dateExecution) async {
    setState(() {
      show = true;
    });
    var url = "https://zoutechhub.com/pharmaRh/ajouterTache.php?id_groupe=$id_groupe&tache_=$tache_&dateExecution=$dateExecution";
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
                fontFamily: 'normal',
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )));
      //Navigator.pop(context);
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

 
  addPlanning() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Annuler'),
              ),
              show
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: mainColor),
                      onPressed: () {
                        setState(() {
                          ajouterTache(idGroupe[index],_selectedIndex,tacheController.text);
                        },);
                      },
                      child: Text(
                        "Créer",
                        style:
                            TextStyle(color: Colors.white, fontFamily: 'bold'),
                      ))
            ],
            content: Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height / 1.8,
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ajouter un planning à un groupe d'employé",
                        style: TextStyle(
                            fontFamily: 'bold', color: mainColor, fontSize: 20),
                      )
                    ],
                  ),
                  h(20),
                  Divider(),
                  h(20),
                  Text(
                    "1- Tâches à attribuer",
                    style: TextStyle(fontFamily: 'bold', fontSize: 15),
                  ),
                  h(20),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextFormField(
                      maxLines: 5,
                      scrollPhysics: ClampingScrollPhysics(),
                      scrollPadding: EdgeInsets.zero,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: 'normal',
                          fontSize: 13,
                          color: Colors.black),
                      controller: tacheController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: "Cliquez pour ajouter une tâche",
                        hintStyle: TextStyle(
                            fontFamily: 'normal',
                            fontSize: 13,
                            color: Colors.black45),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre nom';
                        }
                        return null;
                      },
                    ),
                  ),
                  h(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "2- Groupes / Équipes ",
                            style: TextStyle(fontFamily: 'bold', fontSize: 15),
                          ),
                          h(20),
                          PopupMenuButton(
                            itemBuilder: (BuildContext context) => _menuItems
                                .map((item) => PopupMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    ))
                                .toList(),
                            onSelected: (value) {
                              setState(() {
                                _selectedIndex =
                                    _menuItems.indexOf(value as String);
                                cbon = true;
                              });
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                              ),
                              width: 300,
                              child: Center(
                                child: cbon
                                    ? Text('${_menuItems[_selectedIndex]}')
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_circle_outline_sharp,
                                            color: mainColor2,
                                          ),
                                          w(20),
                                          CircleAvatar(
                                            backgroundColor: mainColor,
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "3- Date d'exécution de la tâche : ",
                            style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          h(20),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: mainColor)),
                            height: 45,
                            width: 300,
                            padding: EdgeInsets.only(left: 10, top: 3),
                            child: TextFormField(
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: _selectedDate0 ?? DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                ).then((pickedDate) {
                                  if (pickedDate != null) {
                                    setState(() {
                                      _selectedDate0 = pickedDate;
                                      formattedDate1 =
                                          "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year.toString()}";
                                      print(formattedDate1);
                                    });
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () {},
                                ),
                              ),
                              readOnly: true,
                              style:
                                  TextStyle(fontFamily: "normal", fontSize: 14),
                              controller: TextEditingController(
                                  text: formattedDate1 != ""
                                      ? formattedDate1
                                      : "Cliquez ici pour choisir"),
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
      ),
    );
  }

  deleteSalary(String codeEquipe) async {
    setState(() {
      show = true;
    });
    var url =
        "https://zoutechhub.com/pharmaRh/deleteGroupe.php?codeEquipe=$codeEquipe";
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Planning ",
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 23, color: mainColor),
                    ),
                    h(20),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        "Créer des plannings pour des groupes d'employés ; Gérer les salaires et les avantages sociaux ; Suivre les augmentations de salaire et des primes ",
                        style: TextStyle(
                            fontFamily: 'normal',
                            fontSize: 16,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                    h(50),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            addPlanning();
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 35,
                            decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(7)),
                            child: Center(
                              child: Text(
                                "Ajouter une Tâche à un groupe de Salarié",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'normal'),
                              ),
                            ),
                          ),
                        ),
                        w(30),
                        InkWell(
                          onTap: () {
                            final RenderBox container = _containerKey0
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
                                  child: Text(
                                    "Aujourd'hui",
                                    style: TextStyle(
                                        fontFamily: 'normal', fontSize: 13),
                                  ),
                                  value: 2,
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    'Demain',
                                    style: TextStyle(
                                        fontFamily: 'normal', fontSize: 13),
                                  ),
                                  value: 2,
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    'Hier',
                                    style: TextStyle(
                                        fontFamily: 'normal', fontSize: 13),
                                  ),
                                  value: 2,
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    'Cette Semaine',
                                    style: TextStyle(
                                        fontFamily: 'normal', fontSize: 13),
                                  ),
                                  value: 2,
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    'La Semaine Dernière',
                                    style: TextStyle(
                                        fontFamily: 'normal', fontSize: 13),
                                  ),
                                  value: 2,
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    'La semaine Prochaine',
                                    style: TextStyle(
                                        fontFamily: 'normal', fontSize: 13),
                                  ),
                                  value: 2,
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    'Le mois-ci',
                                    style: TextStyle(
                                        fontFamily: 'normal', fontSize: 13),
                                  ),
                                  value: 2,
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    'Le mois Prochain',
                                    style: TextStyle(
                                        fontFamily: 'normal', fontSize: 13),
                                  ),
                                  value: 2,
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    'Le mois précédent',
                                    style: TextStyle(
                                        fontFamily: 'normal', fontSize: 13),
                                  ),
                                  value: 2,
                                ),
                              ],

                              elevation:
                                  8.0, // Adjust the elevation for the box shadow
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 5, right: 5, top: 5, bottom: 5),
                            width: 210,
                            height: 35,
                            key: _containerKey0,
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
                                      color:
                                          const Color.fromARGB(154, 0, 0, 0)),
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
                            final RenderBox container = _containerKey1
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
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.green),
                                      child: Center(
                                          child: Text(
                                        'Fait',
                                        style: TextStyle(
                                          fontFamily: 'normal',
                                          color: Colors.white,
                                        ),
                                      ))),
                                ),
                                PopupMenuItem(
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.orange),
                                      child: Center(
                                          child: Text(
                                        'En Cours',
                                        style: TextStyle(
                                          fontFamily: 'normal',
                                          color: Colors.white,
                                        ),
                                      ))),
                                ),
                                PopupMenuItem(
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.red),
                                      child: Center(
                                          child: Text(
                                        'Bloqué',
                                        style: TextStyle(
                                          fontFamily: 'normal',
                                          color: Colors.white,
                                        ),
                                      ))),
                                ),
                                PopupMenuItem(
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.grey),
                                      child: Center(
                                          child: Text(
                                        'Pas Commencé',
                                        style: TextStyle(
                                          fontFamily: 'normal',
                                          color: Colors.white,
                                        ),
                                      ))),
                                ),
                              ],
                              elevation:
                                  8.0, // Adjust the elevation for the box shadow
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 5, right: 5, top: 5, bottom: 5),
                            width: 200,
                            height: 35,
                            key: _containerKey1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black26)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Trier par titre de Statut",
                                  style: TextStyle(
                                      fontFamily: 'normal',
                                      fontSize: 13,
                                      color:
                                          const Color.fromARGB(154, 0, 0, 0)),
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
                    h(50),
                    Text(
                      "Liste des tâches attribuées ",
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 18, color: mainColor),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 240,
                      width: 400,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(13)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Vue d'ensemble des groupes",
                                style:
                                    TextStyle(fontFamily: 'bold', fontSize: 13),
                              ),
                              InkWell(
                                onTap: () {
                                  getEquipe();
                                  setState(() {
                                    Future.delayed(Duration(seconds: 3), () {});
                                    reload = true;
                                  });
                                },
                                child: Container(
                                    height: 25,
                                    width: 25,
                                    child: Image.asset(
                                        "assets/images/reload_icon.png")),
                              )
                            ],
                          ),
                          h(5),
                          Divider(),
                          h(5),
                          Container(
                            height: 110,
                            width: 400,
                            child: FutureBuilder(
                              future: reload ? getEquipe() : getEquipe(),
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
                                                style: TextStyle(fontSize: 14),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        )
                                      : ListView.builder(
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              mainColor,
                                                          minRadius: 20,
                                                          child: Center(
                                                              child: Icon(
                                                            Icons.person,
                                                            color: Colors.white,
                                                          )),
                                                        ),
                                                        w(10),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Groupe ${snapshot.data![index]['id']}",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'bold',
                                                                  fontSize: 13),
                                                            ),
                                                            Container(
                                                              width: 220,
                                                              child: Text(
                                                                "${snapshot.data![index]['membres']}",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'normal',
                                                                    fontSize:
                                                                        11),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          deleteSalary(
                                                              "${snapshot.data![index]['codeEquipe']}");
                                                        });
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            color: mainColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Center(
                                                            child: Text(
                                                          "Supprimer",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'normal',
                                                              fontSize: 11),
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Divider()
                                              ],
                                            );
                                          });
                                }
                                return Center(
                                    child: Container(
                                        height: 150,
                                        width: 150,
                                        child: Lottie.asset(
                                            "assets/images/anim.json")));
                              },
                            ),
                          ),
                          h(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CreationGroupleSalarie(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            h(20),
            Container(
              height: 500,
              child: PlanningEmploye(),
            )
          ],
        ),
      ),
    );
  }
}
