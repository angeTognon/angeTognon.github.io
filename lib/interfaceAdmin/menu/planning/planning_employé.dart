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
  final List<TextEditingController> _textControllers = [];
  List<String> selectedOptions = [];
  final List<GlobalKey> _itemsKey = List.generate(5, (_) => GlobalKey());
  List<String> Statuts = [];
  final List<DateTime> _selectedDate = [];

  List<bool> _selectedOptions = List.generate(5, (_) => false);

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      _fetchMenuItems();
    });
    // Initialize the first TextEditingController
    for (var i = 0; i <= 20; i++) {
      _textControllers.add(TextEditingController());
      Statuts.add("Pas Commencé");
      _selectedDate.add(DateTime.now());
    }
    for (var i = 0; i <= 20; i++) {
      selectedOptions.add("");
    }
    for (var i = 0; i <= 0; i++) {
      _itemWid2.add(const Text("data"));
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

  final List<GlobalKey> _containerKey = [];

  final double _containerWidth = 200.0;
  final double _cursorX = 0.0;
  final bool _isResizing = false;

  final List<String> _items = [];
  final List<Widget> _itemWid2 = [];
  String nomPrenomSalarie = "";
/* **************Début***************** */
  final List<String> _options = [
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

  getTache() async {
    var url = "https://zoutechhub.com/pharmaRh/getAllTache.php";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    print(pub);
    return pub;
  }

  getTacheByStatut(String statu) async {
    var url = "https://zoutechhub.com/pharmaRh/getByStatut.php?statu=$statu";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  int _currentIndex = 0;
  final List<List<String>> _selectedOptionsPerIndex = [];
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
            title: const Text(
              'Choisissez les personnes à qui\nvous souhaitez attribuer ces tâches',
              style: TextStyle(fontFamily: 'normal', fontSize: 15),
              textAlign: TextAlign.center,
            ),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(
                height: 150,
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
                                        _selectedOptions[index] =
                                            value ?? false;
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
                    }),
              )
            ]),
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
  final String _selectedOption = '';
  List<String> codeEquipee = [];
  List<String> idGroupe = [];

  Future<void> _fetchMenuItems() async {
    final response = await http
        .get(Uri.parse('https://zoutechhub.com/pharmaRh/getEquipe.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;

      final members = data.map((item) => "Groupe N° ${item['id']}").toList();
      final id = data.map((item) => "${item['id']}").toList();

      final codeEquipe = data.map((item) => "${item['codeEquipe']}").toList();
      setState(() {
        idGroupe = id;
        _menuItems = members;
        codeEquipee = codeEquipe;
      });
    } else {
      throw Exception('Failed to fetch menu items');
    }
  }

  int _selectedIndex = 0;
  bool cbon = false;

  DateTime _selectedDate0 = DateTime.now();
  bool show = false;
  String formattedDate1 = "";
  TextEditingController tacheController = TextEditingController();
  String tache = "";

  update(int id, String id_groupe, tache_, dateExecution) async {
    setState(() {
      show = true;
    });
    var url =
        "https://zoutechhub.com/pharmaRh/updateTache.php?id=$id&id_groupe=$id_groupe&tache=$tache_&dateExecution=$dateExecution";
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
            "Modification Réussie.",
            style: TextStyle(
              fontFamily: 'normal',
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
              "Erreur. Veuillez actualiser la page",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));
      });
    }
  }

  addPlanning(String tache, int id) {
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
                child: const Text('Annuler'),
              ),
              show
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: mainColor),
                      onPressed: () {
                        setState(
                          () {
                            update(id, codeEquipee[_selectedIndex],
                                tacheController.text, formattedDate1);
                          },
                        );
                      },
                      child: const Text(
                        "Modifier",
                        style:
                            TextStyle(color: Colors.white, fontFamily: 'bold'),
                      ))
            ],
            content: Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height / 1.8,
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ajouter un planning à une équipe",
                        style: TextStyle(
                            fontFamily: 'bold', color: mainColor, fontSize: 20),
                      )
                    ],
                  ),
                  h(20),
                  const Divider(),
                  h(20),
                  const Text(
                    "1- Tâches à attribuer",
                    style: TextStyle(fontFamily: 'bold', fontSize: 15),
                  ),
                  h(20),
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextFormField(
                      maxLines: 5,
                      scrollPhysics: const ClampingScrollPhysics(),
                      scrollPadding: EdgeInsets.zero,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontFamily: 'normal',
                          fontSize: 13,
                          color: Colors.black),
                      controller: tacheController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        hintText: "Cliquez pour ajouter une tâche",
                        hintStyle: const TextStyle(
                            fontFamily: 'normal',
                            fontSize: 13,
                            color: Colors.black45),
                        border: const OutlineInputBorder(),
                        labelText: tacheController.text == tache
                            ? "Tache à faire"
                            : tache,
                      ),
                      onTap: () {
                        setState(
                          () {
                            tacheController.text = tache;
                          },
                        );
                      },
                    ),
                  ),
                  h(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
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
                                _selectedIndex = _menuItems.indexOf(value);
                                cbon = true;
                                print(codeEquipee[_selectedIndex]);
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
                                    ? Text(_menuItems[_selectedIndex])
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
                                            child: const Icon(
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
                          const Text(
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
                            padding: const EdgeInsets.only(left: 10, top: 3),
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
                                labelStyle: const TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.calendar_today),
                                  onPressed: () {},
                                ),
                              ),
                              readOnly: true,
                              style: const TextStyle(
                                  fontFamily: "normal", fontSize: 14),
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

  deleteSalary(int id) async {
    setState(() {
      show = true;
    });
    var url = "https://zoutechhub.com/pharmaRh/deleteTache.php?id=$id";
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
                    width: 400,
                    child: const Center(
                      child: Text(
                        "Tâches à Accomplir",
                        style: TextStyle(
                            fontFamily: 'bold',
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
                        "Membres du Groupe",
                        style: TextStyle(
                            fontFamily: 'bold',
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
                    child: const Center(
                      child: Text(
                        "Date de la tâche",
                        style: TextStyle(
                            fontFamily: 'bold',
                            fontSize: 13,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)),
                    width: 300,
                    child: const Center(
                      child: Text(
                        "Statut",
                        style: TextStyle(
                            fontFamily: 'bold',
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
                      width: 200,
                      child: const Center(
                        child: Text(
                          "Action",
                          style: TextStyle(
                              fontFamily: 'bold',
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
                constraints: const BoxConstraints(maxHeight: 800),
                child: FutureBuilder(
                  future: statu1
                      ? getTacheByStatut("Fait")
                      : statu2
                          ? getTacheByStatut("En Cours")
                          : statu3
                              ? getTacheByStatut("Bloqué")
                              : statu4
                                  ? getTacheByStatut("Pas Commencé")
                                  : getTache(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
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
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: const Text(
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
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Colors.black12)),
                                  height: 80,
                                  width:
                                      (MediaQuery.of(context).size.width * 15) /
                                          16,
                                  child: Row(
                                    children: [
                                      //_showMultiSelectMenu(index);
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black12)),
                                        height: 80,
                                        width: 400,
                                        child: Center(
                                          child: Text(
                                            snapshot.data![index]['tachee'],
                                            style: const TextStyle(
                                                fontFamily: 'normal'),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black12)),
                                        width: 200,
                                        child: Center(
                                          child: Text(
                                              snapshot.data![index]
                                                  ['nomPrenom'],
                                              style: const TextStyle(
                                                  fontFamily: 'normal')),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black12)),
                                        height: 45,
                                        width: 160,
                                        padding: const EdgeInsets.only(
                                            left: 15, bottom: 2.5, right: 15),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 13,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            labelStyle: const TextStyle(
                                                fontFamily: 'normal',
                                                fontSize: 14,
                                                color: Colors.black45),
                                            border: InputBorder.none,
                                            suffixIcon: IconButton(
                                              icon: const Icon(
                                                  Icons.calendar_today),
                                              onPressed: () {},
                                            ),
                                          ),
                                          readOnly: true,
                                          controller: TextEditingController(
                                            text: snapshot.data![index]
                                                ['dateExecution'],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        color: snapshot.data![index]['statu'] ==
                                                "Fait"
                                            ? Colors.green
                                            : snapshot.data![index]['statu'] ==
                                                    "En Cours"
                                                ? Colors.orange
                                                : snapshot.data![index]
                                                            ['statu'] ==
                                                        "Bloqué"
                                                    ? const Color.fromARGB(
                                                        255, 0, 0, 0)
                                                    : snapshot.data![index]
                                                                ['statu'] ==
                                                            "Pas Commencé"
                                                        ? const Color.fromARGB(
                                                            201, 151, 8, 0)
                                                        : Colors.white,
                                        padding: const EdgeInsets.only(),
                                        width: 300,
                                        height: 35,
                                        // key: _containerKey4,
                                        child: Center(
                                          child: Text(
                                            // Statuts[index]==""? "Cliquez pour choisir" : Statuts[index]=="Fait"?"Fait" : Statuts[index]=="En Cours"?"En Cours" : Statuts[index]=="Bloqué"?"Bloqué" :  ,
                                            snapshot.data![index]['statu'],
                                            style: TextStyle(
                                                fontFamily: 'normal',
                                                fontSize: 13,
                                                color: Statuts[index] == ""
                                                    ? const Color.fromARGB(
                                                        154, 0, 0, 0)
                                                    : Colors.white),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          width: 200,
                                          child: SizedBox(
                                            width: 100,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          149, 255, 255, 255),
                                                  padding:
                                                      const EdgeInsets.all(15)),
                                              onPressed: () {
                                                final RenderBox container =
                                                    _itemsKey[index]
                                                            .currentContext
                                                            ?.findRenderObject()
                                                        as RenderBox;
                                                final Offset containerPosition =
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
                                                          containerSize.height,
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width -
                                                          containerPosition.dx -
                                                          containerSize.width,
                                                      0,
                                                    ),
                                                    items: [
                                                      PopupMenuItem(
                                                        onTap: () {
                                                          addPlanning(
                                                              snapshot.data![
                                                                      index]
                                                                  ['tachee'],
                                                              int.parse(snapshot
                                                                      .data![
                                                                  index]['id']));
                                                        },
                                                        value: 2,
                                                        child: Text(
                                                          "Modifier la Tâche",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'normal'),
                                                        ),
                                                      ),
                                                      PopupMenuItem(
                                                        onTap: () {
                                                          setState(() {
                                                            deleteSalary(int.parse(
                                                                snapshot.data![
                                                                        index]
                                                                    ['id']));
                                                          });
                                                        },
                                                        value: 2,
                                                        child: Text(
                                                          "Supprimer",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'normal'),
                                                        ),
                                                      ),
                                                    ]);
                                              },
                                              child: SizedBox(
                                                key: _itemsKey[index],
                                                height: 30,
                                                width: 30,
                                                child: Image.asset(
                                                    "assets/images/more_icon.png"),
                                              ),
                                            ),
                                          ),
                                        ),
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
                            child: Lottie.asset("assets/images/anim.json")));
                  },
                )),
          ],
        ),
      ),
    );
  }
}
