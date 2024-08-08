// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'package:http/http.dart' as http;

class PlanningEmploye extends StatefulWidget {
  const PlanningEmploye({super.key});

  @override
  State<PlanningEmploye> createState() => _PlanningEmployeState();
}

class _PlanningEmployeState extends State<PlanningEmploye> {
  // Declare a list to store the TextEditingController instances _showMultiSelectMenu()
  List<TextEditingController> _textControllers = [];
  List<String> selectedOptions = [];
  List<GlobalKey> _itemsKey = [];
  List<String> Statuts = [];
  List<DateTime> _selectedDate = [];

  List<bool> _selectedOptions = List.generate(5, (_) => false);

  @override
  void initState() {
    super.initState();
     Timer.periodic(Duration(seconds: 3), (timer) {
    _fetchMenuItems();
    print("ok");
  });
    // Initialize the first TextEditingController
    for (var i = 0; i <= 20; i++) {
      _textControllers.add(TextEditingController());
      _itemsKey.add(GlobalKey());
      Statuts.add("Pas Commencé");
      _selectedDate.add(DateTime.now());
    }
    for (var i = 0; i <= 20; i++) {
      selectedOptions.add("");
    }
    for (var i = 0; i <= 0; i++) {
      _itemWid2.add(Text("data"));
    }
  }

  @override
  void dispose() {
    // Dispose of the TextEditingController instances when the widget is disposed
    for (final controller in _textControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  void _addTextController() {
    setState(() {
      // Add a new TextEditingController to the list
      _textControllers.add(TextEditingController());
    });
  }

  void _removeTextController(int index) {
    setState(() {
      // Remove the TextEditingController at the specified index
      _textControllers[index].dispose();
      _textControllers.removeAt(index);
    });
  }

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

  double _containerWidth = 200.0;
  double _cursorX = 0.0;
  bool _isResizing = false;

  List<String> _items = [];
  List<Widget> _itemWid2 = [];
  String nomPrenomSalarie = "";
/* **************Début***************** */
  List<String> _options = [
    'Carine ZOGNO',
    'Tania H.',
    'Jean Paul T.',
    'Damien k.',
    'Olivia S.'
  ];
  getSalary() async {
    var url = "https://zoutechhub.com/pharmaRh/getSalaryNomPrenom.php";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  int _currentIndex = 0;
  List<List<String>> _selectedOptionsPerIndex = [];
/* **************FIN***************** */
  void _showMultiSelectMenu(int index) {
    _currentIndex = index;
    _selectedOptions = index < _selectedOptionsPerIndex.length
        ? List<bool>.generate(_options.length,
            (i) => _selectedOptionsPerIndex[index].contains(_options[i]))
        : List.generate(_options.length, (_) => false);
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
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                height: 150,
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
                            : ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
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
                                        _selectedOptions[index] =
                                            value ?? false;
                                      });
                                    },
                                  );
                                },
                              );
                      }
                      return Center(
                        child: Container(
                          height: 150,
                          width: 150,
                          child: Lottie.asset("assets/images/anim.json"),
                        ),
                      );
                    }),
              )
            ]),
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
                    // Mettre à jour la liste _selectedOptionsPerIndex
                    if (index < _selectedOptionsPerIndex.length) {
                      _selectedOptionsPerIndex[index] = [
                        for (int i = 0; i < _selectedOptions.length; i++)
                          if (_selectedOptions[i]) _options[i],
                      ];
                    } else {
                      _selectedOptionsPerIndex.add([
                        for (int i = 0; i < _selectedOptions.length; i++)
                          if (_selectedOptions[i]) _options[i],
                      ]);
                    }
                    print('Selected :==> $_selectedOptionsPerIndex');
                    Navigator.of(context).pop();
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

  String Statut = "Pas Commencé";

  void _showDatePicker(int index) {
    showDatePicker(
      context: context,
      initialDate: _selectedDate[index] ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _selectedDate[index] = pickedDate;
        });
      }
    });
  }

  List<String> _menuItems = [];
String _selectedOption = '';

Future<void> _fetchMenuItems() async {
  final response = await http.get(Uri.parse('https://zoutechhub.com/pharmaRh/getEquipe.php'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body) as List<dynamic>;

    final members = data.map((item) => "Groupe N° ${item['id']}").toList();
    setState(() {
      _menuItems = members;
      print(_menuItems);
    });
  } else {
    throw Exception('Failed to fetch menu items');
  }
}

  int _selectedIndex = 0;
  bool cbon=false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: (MediaQuery.of(context).size.width * 13.5) / 16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            h(20),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black12)),
              height: 40,
              width: (MediaQuery.of(context).size.width * 13.5) / 16,
              child: Row(
                children: [
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)),
                    width: 250,
                    child: Center(
                      child: Text(
                        "Tâches à Accomplir",
                        style: TextStyle(
                            fontFamily: 'normal',
                            fontSize: 13,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)),
                    width: 200,
                    child: Center(
                      child: Text(
                        "Groupe",
                        style: TextStyle(
                            fontFamily: 'normal',
                            fontSize: 13,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)),
                    width: 160,
                    child: Center(
                      child: Text(
                        "Date",
                        style: TextStyle(
                            fontFamily: 'normal',
                            fontSize: 13,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)),
                    width: 200,
                    child: Center(
                      child: Text(
                        "Statut",
                        style: TextStyle(
                            fontFamily: 'normal',
                            fontSize: 13,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)),
                    width: 200,
                    child: Center(
                      child: Text(
                        "Informations Sup",
                        style: TextStyle(
                            fontFamily: 'normal',
                            fontSize: 13,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      width: 170,
                      child: Center(
                        child: Text(
                          "Action",
                          style: TextStyle(
                              fontFamily: 'normal',
                              fontSize: 13,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            h(15),
            Container(
              height: 300,
              constraints: BoxConstraints(maxHeight: 800),
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: _itemWid2.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12)),
                    height: 40,
                    width: (MediaQuery.of(context).size.width * 15) / 16,
                    child: Row(
                      children: [
                        //_showMultiSelectMenu(index);
                        Container(
                          height: 40,
                          width: 250,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40,
                                width: 200,
                                child: TextFormField(
                                  maxLines: 1, // Limiter à une seule ligne
                                  scrollPhysics:
                                      ClampingScrollPhysics(), // Empêcher le défilement vertical
                                  scrollPadding: EdgeInsets
                                      .zero, // SuPermet au champ de se développer et de faire défiler le contenu
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontFamily: 'normal',
                                      fontSize: 13,
                                      color: Colors.black),
                                  controller: _textControllers[index],
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(bottom: 10, left: 20),
                                    hintText: "Cliquez pour ajouter une tâche",
                                    hintStyle: TextStyle(
                                        fontFamily: 'normal',
                                        fontSize: 13,
                                        color: Colors.black45),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez entrer votre nom';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                      builder: (context, setState) =>
                                          AlertDialog(
                                              content: Container(
                                        height: 50,
                                        width: 200,
                                        child: Center(
                                          child: Text(
                                            _textControllers[index].text,
                                            style: TextStyle(
                                              fontFamily: 'normal',
                                            ),
                                          ),
                                        ),
                                      )),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.black12)),
                                  height: 45,
                                  width: 45,
                                  child: Center(
                                    child: Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: mainColor2,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
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
                             cbon=true;
                            });
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                            ),
                            width: 200,
                            child: Center(
                              child: cbon? Text('${_menuItems[_selectedIndex]}'):
                                  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                        Container(
                          height: 45,
                          width: 160,
                          padding:
                              EdgeInsets.only(left: 15, bottom: 2.5, right: 15),
                          child: TextFormField(
                            onTap: () {
                              _showDatePicker(index);
                            },
                            style: TextStyle(
                                fontFamily: 'normal',
                                fontSize: 13,
                                color: Colors.black),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  fontFamily: 'normal',
                                  fontSize: 14,
                                  color: Colors.black45),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed: () {
                                  _showDatePicker(index);
                                },
                              ),
                            ),
                            readOnly: true,
                            controller: TextEditingController(
                              text: _selectedDate != null
                                  ? DateFormat('dd/MM/yyyy')
                                      .format(_selectedDate[index])
                                  : '',
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            final RenderBox container = _itemsKey[index]
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
                                  onTap: () {
                                    setState(() {
                                      Statuts[index] = "Fait";
                                      print(Statuts[index]);
                                    });
                                  },
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
                                  onTap: () {
                                    setState(() {
                                      Statuts[index] = "En Cours";
                                      print(Statuts[index]);
                                    });
                                  },
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
                                  onTap: () {
                                    setState(() {
                                      Statuts[index] = "Bloqué";
                                      print(Statuts[index]);
                                    });
                                  },
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
                                  onTap: () {
                                    setState(() {
                                      Statuts[index] = "Pas Commencé";
                                      print(Statuts[index]);
                                    });
                                  },
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
                            key: _itemsKey[index],
                            color: Statuts[index] == "Fait"
                                ? Colors.green
                                : Statuts[index] == "En Cours"
                                    ? Colors.orange
                                    : Statuts[index] == "Bloqué"
                                        ? Colors.red
                                        : Statuts[index] == "Pas Commencé"
                                            ? Color.fromARGB(106, 238, 15, 3)
                                            : Colors.white,
                            padding: EdgeInsets.only(
                                left: 5, right: 5, top: 5, bottom: 5),
                            width: 200,
                            height: 35,
                            // key: _containerKey4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  // Statuts[index]==""? "Cliquez pour choisir" : Statuts[index]=="Fait"?"Fait" : Statuts[index]=="En Cours"?"En Cours" : Statuts[index]=="Bloqué"?"Bloqué" :  ,
                                  Statuts[index] == ""
                                      ? "Cliquez pour choisir"
                                      : Statuts[index],
                                  style: TextStyle(
                                      fontFamily: 'normal',
                                      fontSize: 13,
                                      color: Statuts[index] == ""
                                          ? const Color.fromARGB(154, 0, 0, 0)
                                          : Colors.white),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Color.fromARGB(154, 255, 255, 255),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 200,
                          child: TextFormField(
                            maxLines: 1, // Limiter à une seule ligne
                            scrollPhysics:
                                ClampingScrollPhysics(), // Empêcher le défilement vertical
                            scrollPadding: EdgeInsets
                                .zero, // SuPermet au champ de se développer et de faire défiler le contenu
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'normal',
                                fontSize: 13,
                                color: Colors.black),
                            //controller: tache1,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(bottom: 10, left: 20),
                              hintText: "Cliquez pour ajouter une tâche",
                              hintStyle: TextStyle(
                                  fontFamily: 'normal',
                                  fontSize: 13,
                                  color: Colors.black45),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre nom';
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                                color: mainColor2),
                            width: 170,
                            child: Center(
                              child: Text(
                                "Envoyer Planning",
                                style: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget BoxTache(
      TextEditingController controller, GlobalKey key, String Statut_x) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.black12)),
      height: 40,
      width: (MediaQuery.of(context).size.width * 15) / 16,
      child: Row(
        children: [
          Container(
            height: 40,
            width: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 350,
                  child: TextFormField(
                    maxLines: 1, // Limiter à une seule ligne
                    scrollPhysics:
                        ClampingScrollPhysics(), // Empêcher le défilement vertical
                    scrollPadding: EdgeInsets
                        .zero, // SuPermet au champ de se développer et de faire défiler le contenu
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: 'normal',
                        fontSize: 13,
                        color: Colors.black),
                    controller: controller,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 10, left: 20),
                      hintText: "Cliquez pour ajouter une tâche",
                      hintStyle: TextStyle(
                          fontFamily: 'normal',
                          fontSize: 13,
                          color: Colors.black45),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre nom';
                      }
                      return null;
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => StatefulBuilder(
                        builder: (context, setState) => AlertDialog(
                            content: Text(
                          controller.text,
                          style: TextStyle(
                            fontFamily: 'normal',
                          ),
                        )),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)),
                    height: 45,
                    width: 45,
                    child: Center(
                      child: Icon(
                        Icons.remove_red_eye_outlined,
                        color: mainColor2,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _showMultiSelectMenu(0);
              });
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
              ),
              width: 200,
              child: Center(
                  child: selectedOptions.isEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                        )
                      : Text(
                          "d",
                          style: TextStyle(fontFamily: 'normal', fontSize: 12),
                        )),
            ),
          ),
          Container(
            height: 45,
            width: 200,
            child: TextFormField(
              onTap: () {
                _showDatePicker(1);
              },
              style: TextStyle(
                  fontFamily: 'normal', fontSize: 13, color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Date',
                labelStyle: TextStyle(
                    fontFamily: 'normal', fontSize: 14, color: Colors.black45),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    _showDatePicker(1);
                  },
                ),
              ),
              readOnly: true,
              controller: TextEditingController(
                text: _selectedDate != null
                    ? DateFormat('dd/MM/yyyy').format(_selectedDate[1])
                    : '',
              ),
            ),
          ),
          InkWell(
            onTap: () {
              final RenderBox container =
                  key.currentContext?.findRenderObject() as RenderBox;
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
                    onTap: () {
                      setState(() {
                        Statut_x = "Fait";
                        print(Statut_x);
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
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
                    onTap: () {
                      setState(() {
                        Statut_x = "En Cours";
                        print(Statut_x);
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
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
                    onTap: () {
                      setState(() {
                        Statut_x = "Bloqué";
                        print(Statut_x);
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
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
                    onTap: () {
                      setState(() {
                        Statut_x = "Pas Commencé";
                        print(Statut_x);
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
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
                elevation: 8.0, // Adjust the elevation for the box shadow
              );
            },
            child: Container(
              key: key,
              color: Statut_x == "Fait"
                  ? Colors.green
                  : Statut_x == "En Cours"
                      ? Colors.orange
                      : Statut_x == "Bloqué"
                          ? Colors.red
                          : Statut_x == "Pas Commencé"
                              ? Color.fromARGB(106, 238, 15, 3)
                              : Colors.white,
              padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
              width: 200,
              height: 35,
              // key: _containerKey4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // Statut_x==""? "Cliquez pour choisir" : Statut_x=="Fait"?"Fait" : Statut_x=="En Cours"?"En Cours" : Statut_x=="Bloqué"?"Bloqué" :  ,
                    Statut_x == "" ? "Cliquez pour choisir" : Statut_x,
                    style: TextStyle(
                        fontFamily: 'normal',
                        fontSize: 13,
                        color: Statut_x == ""
                            ? const Color.fromARGB(154, 0, 0, 0)
                            : Colors.white),
                  ),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Color.fromARGB(154, 255, 255, 255),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 40,
            width: 200,
            child: TextFormField(
              maxLines: 1, // Limiter à une seule ligne
              scrollPhysics:
                  ClampingScrollPhysics(), // Empêcher le défilement vertical
              scrollPadding: EdgeInsets
                  .zero, // SuPermet au champ de se développer et de faire défiler le contenu
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: 'normal', fontSize: 13, color: Colors.black),
              //controller: tache1,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 10, left: 20),
                hintText: "Cliquez pour ajouter une tâche",
                hintStyle: TextStyle(
                    fontFamily: 'normal', fontSize: 13, color: Colors.black45),
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre nom';
                }
                return null;
              },
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12), color: mainColor2),
              width: 170,
              child: Center(
                child: Text(
                  "Envoyer Planning",
                  style: TextStyle(
                      fontFamily: 'normal',
                      fontSize: 13,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addItem() {
    setState(() {
      _itemWid2.add(BoxTache(tache1, _containerKey3, ""));
      // _items.add('Item ${_items.length + 1}');
    });
  }

  void _getSelectedOptionsText() {
    for (int i = 0; i < _selectedOptions.length; i++) {
      if (_selectedOptions[i]) {
        selectedOptions.add(_options[i]);
      }
    }
  }
}
