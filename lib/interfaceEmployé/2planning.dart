// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:zth_app/main.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'package:http/http.dart' as http;

class MonPlanning extends StatefulWidget {
  const MonPlanning({super.key});

  @override
  State<MonPlanning> createState() => _MonPlanningState();
}

class _MonPlanningState extends State<MonPlanning> {
  // Declare a list to store the TextEditingController instances _showMultiSelectMenu()
  final List<TextEditingController> _textControllers = [];
  List<String> selectedOptions = [];
  final List<GlobalKey> _itemsKey = [];
  List<String> Statuts = [];
  final List<DateTime> _selectedDate = [];

  List<bool> _selectedOptions = List.generate(5, (_) => false);

  @override
  void initState() {
    super.initState();
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
      _itemWid.add(const Text("data"));
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
  final bool _isSearching = false;
  void performSearch(String query) {
    // Ici, vous pouvez implémenter la logique de recherche en fonction de votre application
    print("Recherche pour : $query");
  }

  final GlobalKey _containerKey3 = GlobalKey();
  final GlobalKey _containerKey33 = GlobalKey();
  final GlobalKey _containerKey4 = GlobalKey();
  final GlobalKey _containerKey_add_statut = GlobalKey();

  final double _containerWidth = 200.0;
  final double _cursorX = 0.0;
  final bool _isResizing = false;

  final List<String> _items = [];
  final List<Widget> _itemWid = [
    h(2),
    h(2),
    h(2),
    h(2),
  ];
  String nomPrenomSalarie = "";
/* **************Début***************** */
  final List<String> _options = [
    'Carine ZOGNO',
    'Tania H.',
    'Jean Paul T.',
    'Damien k.',
    'Olivia S.'
  ];
  int _currentIndex = 0;
  final List<List<String>> _selectedOptionsPerIndex = [];
  bool show = false;
  updateTachee(int id, String statut) async {
    setState(() {
      show = true;
    });
    var url =
        "https://zoutechhub.com/pharmaRh/updateTacheEmploye.php?id=$id&statut=$statutSelectionne";
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
            "Envoi Réussi.",
            style: TextStyle(
              fontFamily: 'normal',
              color: Colors.white,
            ),
          )));
    } else {
      setState(() {
        show = false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: const Text(
            'Choisissez les personnes à qui\nvous souhaitez attribuer ces tâches',
            style: TextStyle(fontFamily: 'normal', fontSize: 15),
            textAlign: TextAlign.center,
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(_options.length, (index) {
                  return CheckboxListTile(
                    title: Row(
                      children: [
                        const CircleAvatar(
                          child: Center(
                            child: Icon(Icons.person),
                          ),
                        ),
                        w(20),
                        Text(_options[index]),
                      ],
                    ),
                    value: _selectedOptions[index],
                    onChanged: (value) {
                      setState(() {
                        _selectedOptions[index] = value ?? false;
                      });
                    },
                  );
                }),
              );
            },
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
              child: const Text('Save'),
            ),
          ],
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

  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  TimeOfDay _selectedTime2 = TimeOfDay.now();

  Future<void> _selectTime2() async {
    final TimeOfDay? pickedTime2 = await showTimePicker(
      context: context,
      initialTime: _selectedTime2,
    );
    if (pickedTime2 != null && pickedTime2 != _selectedTime2) {
      setState(() {
        _selectedTime2 = pickedTime2;
      });
    }
  }

  getTache() async {
    var url =
        "https://zoutechhub.com/pharmaRh/getTacheByUser.php?email=$user_email";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    print(pub);
    return pub;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
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
                    width: 30,
                    child: const Center(
                      child: Text(
                        "N°",
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
                    width: 500,
                    child: const Center(
                      child: Text(
                        "Tâches à faire",
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
                    child: const Center(
                      child: Text(
                        "DeadLine",
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
                    width: 220,
                    child: const Center(
                      child: Text(
                        "Statut",
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
                      width: 100,
                      child: const Center(
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
            h(0),
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: getTache(),
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
                                  "Oups, Vous n'avez aucune tâche pour l'instant ",
                                  style: TextStyle(fontSize: 17),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return BoxTache(
                                  int.parse("${snapshot.data[index]['id']}"),
                                  "${snapshot.data[index]['tachee']}",
                                  "${snapshot.data[index]['dateExecution']}",
                                  "${snapshot.data[index]['statu']}");
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
            )
          ],
        ),
      ),
    );
  }

  String statutSelectionne = "";

  Widget BoxTache(int index, String tache, date, statut) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.black12)),
      height: 80,
      constraints: const BoxConstraints(maxHeight: 100),
      width: (MediaQuery.of(context).size.width * 15) / 16,
      child: Row(
        children: [
          SizedBox(
            height: 40,
            width: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: 40,
                    width: 30,
                    child: Center(
                      child: Text("${index + 1}"),
                    )),
              ],
            ),
          ),
          InkWell(
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
              ),
              width: 500,
              child: Center(
                  child: Text(
                tache,
                style: const TextStyle(
                    fontFamily: 'normal', fontSize: 13, color: Colors.black),
              )),
            ),
          ),
          Container(
              height: 45,
              width: 200,
              padding: const EdgeInsets.only(left: 15, bottom: 0, right: 15),
              child: Center(
                child: Text(
                  date,
                  style: const TextStyle(fontFamily: 'normal'),
                ),
              )),
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
                          statutSelectionne = Statuts[index];
                          print(statutSelectionne);
                        });
                      },
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green),
                          child: const Center(
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
                          statutSelectionne = Statuts[index];
                          print(statutSelectionne);
                        });
                      },
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.orange),
                          child: const Center(
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
                          statutSelectionne = Statuts[index];
                          print(statutSelectionne);
                        });
                      },
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.red),
                          child: const Center(
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
                          statutSelectionne = Statuts[index];
                          print(statutSelectionne);
                        });
                      },
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey),
                          child: Center(
                              child: Text(
                            statut,
                            style: const TextStyle(
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
                key: _itemsKey[index],
                color: statut == "Fait"
                    ? Colors.green
                    : statut == "En Cours"
                        ? Colors.orange
                        : statut == "Bloqué"
                            ? Colors.red
                            : statut == "Pas Commencé"
                                ? const Color.fromARGB(106, 238, 15, 3)
                                : Colors.white,
                padding:
                    const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                width: 220,
                height: 80,
                // key: _containerKey4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // Statuts[index]==""? "Cliquez pour choisir" : Statuts[index]=="Fait"?"Fait" : Statuts[index]=="En Cours"?"En Cours" : Statuts[index]=="Bloqué"?"Bloqué" :  ,
                      statutSelectionne == "" ? statut : statutSelectionne,
                      style: TextStyle(
                          fontFamily: 'normal',
                          fontSize: 13,
                          color: Statuts[index] == ""
                              ? const Color.fromARGB(154, 0, 0, 0)
                              : Colors.white),
                    ),
                    const Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Color.fromARGB(154, 255, 255, 255),
                    )
                  ],
                ),
              )),
          Expanded(
            child: InkWell(
              onTap: () {
                updateTachee(index, statutSelectionne);
              },
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    color: mainColor),
                width: 100,
                child: Center(
                  child: show
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Valider ",
                          style: TextStyle(
                              fontFamily: 'normal',
                              fontSize: 13,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
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
      _itemWid.add(BoxTache(1, '_containerKey3', "", ""));
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
