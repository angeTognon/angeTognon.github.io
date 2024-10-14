import 'dart:convert';
import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:zth_app/interfaceAdmin/menu/sanctions/sanction.dart';
import 'package:zth_app/interfaceAdmin/menu/salaire/gestion_pret_avancement.dart';
import 'package:zth_app/interfaceAdmin/menu/salaire/gestion_prime.dart';
import 'package:zth_app/interfaceAdmin/menu/planning/planning_employ%C3%A9.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'dart:html' as html;
import 'package:pie_chart/pie_chart.dart';
import 'package:d_chart/d_chart.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'dart:html' as html;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as uh;

class Salaire extends StatefulWidget {
  const Salaire({super.key});

  @override
  State<Salaire> createState() => _SalaireState();
}

class _SalaireState extends State<Salaire> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey _containerKey = GlobalKey();
  final GlobalKey _containerKey2 = GlobalKey();
  TextEditingController montantController = TextEditingController();
  TextEditingController periodePaiementController = TextEditingController();
  TextEditingController montantAPreleverController = TextEditingController();
  TextEditingController montantAvanceController = TextEditingController();
  int count = 0;

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDate2 = DateTime.now();
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
        });
      }
    });
  }

  void _showPopupNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 187, 64, 55),
        content: const Text(
          'Veuillez Patienter la date de la prochaine prime. Nous vous notifierons 5 jours avant la dite date !',
          style: TextStyle(color: Colors.white, fontFamily: 'normal'),
        ),
        duration: const Duration(seconds: 10),
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
    super.initState();
    montantController.text = "0";
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int index = 0;

  Map<String, double> dataMap = {
    "Prêt en Cours": 8.0,
    "Prêt en retard": 3,
  };
  Map<String, double> dataMap2 = {
    "Salaire Non Emis": 9.0,
    "Salaire Emis": 1.0,
  };

  final ordinalGroup = [
    OrdinalGroup(
      color: mainColor,
      id: '1',
      data: [
        OrdinalData(
          domain: 'Janvier',
          measure: 3,
        ),
        OrdinalData(domain: 'Février', measure: 0),
        OrdinalData(domain: 'Mars', measure: 0),
        OrdinalData(domain: 'Avril', measure: 2),
        OrdinalData(domain: 'Mai', measure: 0),
        OrdinalData(domain: 'Juin', measure: 8),
        OrdinalData(domain: 'Juillet', measure: 6.5),
      ],
    ),
  ];

  /* PDF */

  Future<void> generatePDF(
    String name,
    String email,
    String phone,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Formulaire'),
            pw.SizedBox(height: 20),
            pw.Text('Nom: $name'),
            pw.SizedBox(height: 10),
            pw.Text('Email: $email'),
            pw.SizedBox(height: 10),
            pw.Text('Téléphone: $phone'),
          ],
        ),
      ),
    );

    final bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = uh.AnchorElement(href: url)
      ..setAttribute('download', 'formulaire.pdf')
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  bool show = false;
  String dateAvance = "";
  String dateEcheancee = "";
  inscription(String nomPrenom, salaireBase, salaireBrute, salaireNette, pret,
      periodePaiement, montantAPrelever) async {
    setState(() {
      show = true;
    });
    var url =
        "https://zoutechhub.com/pharmaRh/ajouterPretAvancement.php?nomPrenom=$nomPrenom&salaireBase=$salaireBase&salaireBrute=$salaireBrute&salaireNette=$salaireNette&pret=$pret&dateAvance=$dateAvance&dateEcheance=$dateEcheancee&periodePaiement=$periodePaiement&montantAPrelever=$montantAPrelever";
    var response = await http.post(Uri.parse(url));
    print(response.body);
    print(response.statusCode);
    if (response.body == "OK") {
      setState(() {
        show = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height,
      width: (MediaQuery.of(context).size.width * 9.9) / 12,
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
                      "Salaire ",
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 23, color: mainColor),
                    ),
                    h(20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: const Text(
                        "Gérer les salaires et les avantages sociaux ; Suivre les augmentations de salaire et des primes.",
                        style: TextStyle(
                            fontFamily: 'normal',
                            fontSize: 16,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    /*  ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor),
                        onPressed: () async {
                          generatePDF("d", "jkjkjk", "hkjhkjhk");
                        },
                        child: Text(
                          "Générer une fiche de Paie",
                          style: TextStyle(
                              fontFamily: 'normal', color: Colors.white),
                        )),
                    h(20), */
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor),
                        onPressed: () {
                          pretMethode();
                          print('dfdkfjdkfdj');
                          // generatePDF("d", "jkjkjk", "hkjhkjhk");
                        },
                        child: const Text(
                          "Ajouter un Prêt/Avancement",
                          style: TextStyle(
                              fontFamily: 'normal', color: Colors.white),
                        )),
                  ],
                )
              ],
            ),
            h(10),
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
                        "Gestion des Primes",
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
                        "Prêt et Avancement",
                        style: TextStyle(
                            fontFamily: 'bold',
                            color: index == 1 ? mainColor : Colors.grey),
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
                        "Statistiques",
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
              child: TabBarView(controller: _tabController, children: [
                const GestionPrime(),
                const GestionPretAvancement(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Statistiques Des Prêts effecués durant les 7 derniers mois",
                              style: TextStyle(
                                  fontFamily: 'bold',
                                  fontSize: 15,
                                  color: mainColor),
                            ),
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
                                          mainColor;
                                        }
                                        return null;
                                      },
                                      groupList: ordinalGroup,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Statistiques Des Prêts En Cours / En Retard",
                              style: TextStyle(
                                  fontFamily: 'bold',
                                  fontSize: 15,
                                  color: mainColor),
                            ),
                            PieChart(
                              dataMap: dataMap,
                              animationDuration:
                                  const Duration(milliseconds: 800),
                              chartLegendSpacing: 32,
                              chartRadius: 300,
                              colorList: [
                                mainColor2,
                                const Color.fromARGB(219, 185, 28, 28),
                              ],
                              initialAngleInDegree: 0,
                              ringStrokeWidth: 32,
                              legendOptions: const LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.right,
                                showLegends: true,
                                legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValueBackground: true,
                                showChartValues: true,
                                showChartValuesInPercentage: false,
                                showChartValuesOutside: false,
                              ),
                              // gradientList: ---To add gradient colors---
                              // emptyColorGradient: ---Empty Color gradient---
                            ),
                            h(180)
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ]),
            ),
            h(10),
            h(15),
          ],
        ),
      ),
    );
  }

  getSalary() async {
    var url = "https://zoutechhub.com/pharmaRh/getSalaryNomPrenom.php";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  final List<String> _options = [
    'Cliquez ici pour choisir',
    'Avertissement Verbal',
    'Blâme',
    'La mise à pied de 1 à 8 jours avec privation de salaire',
    'licenciement avec préavis',
    'licenciement sans préavis'
  ];
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
            title: const Text(
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
                                margin:
                                    const EdgeInsets.only(left: 20, right: 20),
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
                              updateSelectedOptions(index);
                              return CheckboxListTile(
                                title: Row(
                                  children: [
                                    const CircleAvatar(
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
                child: const Text('Cancel'),
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
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }

  final List<bool> _selectedOptions = [];

  pretMethode() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            backgroundColor: Colors.white,
            content: Container(
              padding: const EdgeInsets.all(10),
              height: (MediaQuery.of(context).size.height) / 1.2,
              width: MediaQuery.of(context).size.width / 2,
              color: Colors.white,
              child: Column(
                children: [
                  const Text(
                    "Octroie de Prêt",
                    style: TextStyle(
                        fontFamily: 'bold', color: Colors.black, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      const Text(
                        "Liste des employés",
                        style: TextStyle(
                            fontFamily: 'bold',
                            color: Colors.black87,
                            fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      h(20),
                      SizedBox(
                        height: 180,
                        width: MediaQuery.of(context).size.width / 2,
                        child: FutureBuilder(
                          future: getSalary(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
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
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: const Offset(
                                                      0, 3), // Ombre en bas
                                                ),
                                              ],
                                            ),
                                            padding: const EdgeInsets.all(0),
                                            height: 50,
                                            width: 240,
                                            child: CheckboxListTile(
                                              dense: true,
                                              activeColor: mainColor,
                                              title: Row(
                                                children: [
                                                  const CircleAvatar(
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
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'normal'), // Gère le débordement si le texte est trop long
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              value: _selectedOptions[index],
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedOptions[index] =
                                                      value!;
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
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 45,
                        width: 300,
                        child: TextFormField(
                          controller: montantAvanceController,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(
                                fontFamily: 'normal',
                                fontSize: 14,
                                color: Colors.black45),
                            border: OutlineInputBorder(),
                            labelText: "Montant du prêt",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre prénom';
                            }
                            setState(
                              () {},
                            );
                            return null;
                          },
                        ),
                      ),
                      h(50),
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
                                  dateAvance =
                                      "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}";
                                  print(dateAvance);
                                });
                              }
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: "Date de l'avance",
                            labelStyle: TextStyle(
                                fontFamily: 'normal',
                                fontSize: 14,
                                color: Colors.black45),
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                          controller: TextEditingController(
                            text: dateAvance != ""
                                ? dateAvance
                                : "Cliquez ici pour choisir",
                          ),
                        ),
                      ),
                    ],
                  ),
                  h(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Période de Paiement",
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
                              controller: periodePaiementController,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                labelText: 'Période de Paiement',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Date d'échéance",
                            style: TextStyle(
                                fontFamily: 'bold',
                                color: Colors.black87,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          h(10),
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
                                      _selectedDate2 = pickedDate;
                                      dateEcheancee =
                                          "${_selectedDate2.day}/${_selectedDate2.month}/${_selectedDate2.year}";
                                      print(dateEcheancee);
                                    });
                                  }
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: "Date d'échéance",
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                              ),
                              readOnly: true,
                              controller: TextEditingController(
                                text: dateEcheancee != ""
                                    ? dateEcheancee
                                    : 'Cliquez ici pour choisir',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  h(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Montant à prélever du Salaire",
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
                              controller: montantAPreleverController,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                labelText: 'Montant à prélever du Salaire',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          h(25),
                          const Text(
                            "Salaire Avant le Prêt : 70.000FCFA",
                            style: TextStyle(
                                fontFamily: 'normal',
                                color: Colors.black87,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          h(10),
                          const Text(
                            "Salaire Après le Prêt : 50.000FCFA",
                            style: TextStyle(
                                fontFamily: 'normal',
                                color: Colors.black87,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          h(10),
                        ],
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      h(30),
                      show
                          ? const CircularProgressIndicator()
                          : InkWell(
                              onTap: () {
                                setState(
                                  () {
                                    inscription(
                                        _selectedPersonnes[index],
                                        _idPersonnes[index],
                                        _idPersonnes[index],
                                        _idPersonnes[index],
                                        "${montantAvanceController.text} FCFA le $dateAvance",
                                        periodePaiementController.text,
                                        montantAPreleverController.text);
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                height: 40,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: mainColor2),
                                child: const Center(
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
            ),
          ),
        );
      },
    );
  }

  avancement_Methode(String nomprenom, double salaireActu, montantController) {
    showDialog(
      barrierColor: mainColor3,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            surfaceTintColor: Colors.white,
            content: Container(
              padding: const EdgeInsets.all(10),
              height: (MediaQuery.of(context).size.height / 2.9),
              width: MediaQuery.of(context).size.width / 2,
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    "Faire un Avancement à $nomprenom",
                    style: TextStyle(
                        fontFamily: 'bold', color: mainColor2, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  h(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 45,
                        width: 300,
                        child: TextFormField(
                          controller: montantAvanceController,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(
                                fontFamily: 'normal',
                                fontSize: 14,
                                color: Colors.black45),
                            border: OutlineInputBorder(),
                            labelText: "Montant de l'avance",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre prénom';
                            }
                            setState(
                              () {},
                            );
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        width: 300,
                        child: TextFormField(
                          onTap: _showDatePicker,
                          decoration: InputDecoration(
                            labelText: "Date de l'avance",
                            labelStyle: const TextStyle(
                                fontFamily: 'normal',
                                fontSize: 14,
                                color: Colors.black45),
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: _showDatePicker,
                            ),
                          ),
                          readOnly: true,
                          controller: TextEditingController(
                            text: _selectedDate != null
                                ? DateFormat('dd/MM/yyyy').format(_selectedDate)
                                : '',
                          ),
                        ),
                      ),
                    ],
                  ),
                  h(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            " Salaire Avant Prêt :",
                            style: TextStyle(
                                fontFamily: 'bold',
                                color: mainColor,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          h(10),
                          Text(
                            "$salaireActu FCFA",
                            style: const TextStyle(
                                fontFamily: 'normal',
                                color: Colors.black87,
                                fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            " Salaire Après Prêt :",
                            style: TextStyle(
                                fontFamily: 'bold',
                                color: mainColor,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          h(10),
                          Text(
                            "${salaireActu - montantController} FCFA",
                            style: const TextStyle(
                                fontFamily: 'normal',
                                color: Colors.black87,
                                fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    ],
                  ),
                  h(20),
                  InkWell(
                    onTap: () {
                      setState(
                        () {
                          salaireActu = montantController;
                        },
                      );

                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: mainColor2),
                      child: const Center(
                        child: Text(
                          "Confirmer",
                          style: TextStyle(
                              fontFamily: 'normal', color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
