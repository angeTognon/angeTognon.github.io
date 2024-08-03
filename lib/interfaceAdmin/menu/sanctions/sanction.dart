// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:d_chart/d_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:zth_app/widgets/wid_var.dart';

class GestionPleinBlame extends StatefulWidget {
  const GestionPleinBlame({super.key});

  @override
  State<GestionPleinBlame> createState() => _GestionPleinBlameState();
}

class _GestionPleinBlameState extends State<GestionPleinBlame> {
  final GlobalKey _containerKey = GlobalKey();
  final GlobalKey _containerKey2 = GlobalKey();
  TextEditingController montantController = TextEditingController();
  TextEditingController montantAvanceController = TextEditingController();
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
        });
      }
    });
  }

  void _showPopupNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 187, 64, 55),
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
  bool _isSearching = false;
  void performSearch(String query) {
    // Ici, vous pouvez implémenter la logique de recherche en fonction de votre application
    print("Recherche pour : $query");
  }

  final GlobalKey _containerKey3 = GlobalKey();
  final GlobalKey _containerKey4 = GlobalKey();
  final GlobalKey _containerKey_add_statut = GlobalKey();

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
                "Santions ",
                style: TextStyle(
                    fontFamily: 'bold', fontSize: 23, color: mainColor),
              ),
              h(50),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  "Gérez plus facilement les sanctions de vos clients",
                  style: TextStyle(
                      fontFamily: 'normal',
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              h(20),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 30, bottom: 13),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(73, 42, 116, 100),
                        borderRadius: BorderRadius.circular(15)),
                    height: 35,
                    width: 300,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {
                                _isSearching = value.isNotEmpty;
                              });
                            },
                            style: TextStyle(
                                fontFamily: 'normal',
                                fontSize: 14,
                                color: Colors.black54),
                            decoration: InputDecoration(
                              hintText: "Trier par personne",
                              hintStyle:
                                  TextStyle(fontFamily: 'normal', fontSize: 14),
                              border: InputBorder.none,
                              suffixIcon: _isSearching
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        _searchController.clear();
                                        setState(() {
                                          _isSearching = false;
                                        });
                                      },
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        if (_isSearching)
                          IconButton(
                            icon: Icon(Icons.search, color: Colors.white),
                            onPressed: () {
                              // Exécuter la recherche avec la valeur du champ de texte
                              String searchQuery = _searchController.text;
                              performSearch(searchQuery);
                            },
                          ),
                      ],
                    ),
                  ),
                  w(30),
                InkWell(
                  onTap: () {
                    final RenderBox container = _containerKey3.currentContext
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
                          child: Text(
                            "Avertissement Verbal",
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Blâme',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'La mise à pied de 1 à 8 jours avec privation de salaire',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'licenciement avec préavis',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'licenciement sans préavis',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
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
                    width: 220,
                    height: 35,
                    key: _containerKey3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black26)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Trier par type de Sanction",
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
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: mainColor3, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Container(
                      width: 300,
                      height: 50,
                      child: Center(
                        child: Text(
                          "Nom et Prénoms de l'employé",
                          style: TextStyle(fontFamily: 'bold', fontSize: 13),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 3,
                      color: Colors.white54,
                    ),
                    Container(
                      width: 120,
                      height: 50,
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          "Nombre de Sanctions reçues",
                          style: TextStyle(fontFamily: 'bold', fontSize: 13),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 3,
                      color: Colors.white54,
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      child: Center(
                        child: Text(
                          "Type de Sanction",
                          style: TextStyle(fontFamily: 'bold', fontSize: 13),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 3,
                      color: Colors.white54,
                    ),
                    Container(
                      width: 150,
                      height: 50,
                      child: Center(
                        child: Text(
                          "Date de Sanction",
                          style: TextStyle(fontFamily: 'bold', fontSize: 13),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 3,
                      color: Colors.white54,
                    ),
                    Container(
                      width: 250,
                      height: 50,
                      child: Center(
                        child: Text(
                          "Motif de Sanction",
                          style: TextStyle(fontFamily: 'bold', fontSize: 13),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 3,
                      color: Colors.white54,
                    ),
                    Expanded(
                      child: Container(
                        width: 200,
                        height: 50,
                        child: Center(
                          child: Text(
                            "Action",
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              h(5),
              BoxUser("Aïcha TRAORÉ", 5, "Sanction 1", "10/07/2024", "Retard",
                  _containerKey),
              Divider(),
              h(5),
              BoxUser("Christian ZOGBO", 0, "-", "-", "-", _containerKey2),
              Divider(),
              h(20),
              Text(
                "Détails des sanctions de l'année ",
                style: TextStyle(
                    fontFamily: 'bold', fontSize: 20, color: mainColor),
              ),
              h(20),
              Container(
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
                        },
                        groupList: ordinalGroup,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  BoxUser(String nomprenom, double nbrSanction, String typeSanction,
      dateSanction, motifSanction, GlobalKey key) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
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
                Center(
                  child: Text(
                    nomprenom,
                    style: TextStyle(
                        fontFamily: 'normal',
                        color: Colors.black87,
                        fontSize: 13),
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
          Container(
            width: 120,
            height: 50,
            child: Center(
              child: Text(
                '$nbrSanction',
                style: TextStyle(
                    fontFamily: 'normal', color: Colors.black87, fontSize: 13),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 3,
            color: Color.fromARGB(19, 0, 0, 0),
          ),
          Container(
            width: 200,
            height: 50,
            child: Center(
              child: Text(
                '$typeSanction ',
                style: TextStyle(
                    fontFamily: 'normal', color: Colors.black87, fontSize: 13),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 3,
            color: Color.fromARGB(19, 0, 0, 0),
          ),
          Container(
            width: 150,
            height: 50,
            child: Center(
              child: Text(
                dateSanction,
                style: TextStyle(
                    fontFamily: 'normal', color: Colors.black87, fontSize: 13),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 3,
            color: Color.fromARGB(19, 0, 0, 0),
          ),
          Container(
            width: 250,
            height: 50,
            child: Center(
              child: Text(
                motifSanction,
                style: TextStyle(
                    fontFamily: 'normal', color: Colors.black87, fontSize: 13),
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
            child: Container(
                width: 30,
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(149, 255, 255, 255),
                          padding: EdgeInsets.all(15)),
                      onPressed: () {
                        final RenderBox container = _containerKey.currentContext
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
                                child: Text(
                                  "Enregister la sanction",
                                  style: TextStyle(fontFamily: 'normal'),
                                ),
                                value: 2,
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  pleinteMethode(
                                    nomprenom,
                                  );
                                },
                                child: Text(
                                  "Ajouter une sanction à l'employé",
                                  style: TextStyle(fontFamily: 'normal'),
                                ),
                                value: 2,
                              ),
                              PopupMenuItem(
                                onTap: () {},
                                child: Text(
                                  "Télécharger la fiche de sanction de l'employé",
                                  style: TextStyle(fontFamily: 'normal'),
                                ),
                                value: 2,
                              ),
                            ]);
                      },
                      child: Container(
                        key: key,
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
    );
  }

  pleinteMethode(String nomprenom) {
    showDialog(
      barrierColor: mainColor3,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            surfaceTintColor: Colors.white,
            content: Container(
              padding: EdgeInsets.all(10),
              height: (MediaQuery.of(context).size.height / 2.2),
              width: MediaQuery.of(context).size.width / 2,
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    "Sanction à l'employé $nomprenom",
                    style: TextStyle(
                        fontFamily: 'bold', color: mainColor2, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  h(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Type de Sanction : ",
                            style: TextStyle(
                                fontFamily: 'bold',
                                color: Colors.black87,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          Container(
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
                          Container(
                            height: 150,
                            width: 350,
                            child: TextFormField(
                              //controller: montantController,
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
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              onTap: _showDatePicker,
                              decoration: InputDecoration(
                                labelText: 'Date de la sanction',
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: _showDatePicker,
                                ),
                              ),
                              readOnly: true,
                              controller: TextEditingController(
                                text: _selectedDate != null
                                    ? DateFormat('dd/MM/yyyy')
                                        .format(_selectedDate)
                                    : '',
                              ),
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
                          Container(
                            height: 40,
                            width: 300,
                            child: TextFormField(
                              //controller: montantController,
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
                          InkWell(
                            onTap: () {
                              setState(
                                () {},
                              );

                              Navigator.pop(context);
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
