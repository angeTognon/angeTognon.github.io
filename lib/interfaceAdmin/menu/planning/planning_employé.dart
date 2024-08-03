// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zth_app/widgets/wid_var.dart';

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
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: Text(
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
                        CircleAvatar(
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: (MediaQuery.of(context).size.width * 13.5) / 16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    _addItem();
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
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
                w(40),
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
                        PopupMenuItem(
                          child: Text(
                            "Aujourd'hui",
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Demain',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Hier',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Cette Semaine',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'La Semaine Dernière',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'La semaine Prochaine',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Le mois-ci',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Le mois Prochain',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Le mois précédent',
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
                    width: 210,
                    height: 35,
                    key: _containerKey3,
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
                w(20),
                InkWell(
                  onTap: () {
                    final RenderBox container = _containerKey_add_statut
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
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                    width: 200,
                    height: 35,
                    key: _containerKey_add_statut,
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
                                    hintText:
                                        "Cliquez pour ajouter une tâche",
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
                        InkWell(
                          onTap: () {
                            setState(() {
                              _showMultiSelectMenu(index);
                            });
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                            ),
                            width: 200,
                            child: Center(
                              child:
                                  _selectedOptionsPerIndex.length > index &&
                                          _selectedOptionsPerIndex[index]
                                              .isNotEmpty
                                      ? Text(
                                          "${_selectedOptionsPerIndex[index].join(' / ')}",
                                          style: TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 12),
                                        )
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
                        Container(
                          height: 45,
                          width: 160,
                          padding: EdgeInsets.only(
                              left: 15, bottom: 15, right: 15),
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
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
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
                                    color:
                                        Color.fromARGB(255, 255, 255, 255)),
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
