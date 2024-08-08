// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'package:http/http.dart' as http;

class CreationGroupleSalarie extends StatefulWidget {
  const CreationGroupleSalarie({super.key});

  @override
  State<CreationGroupleSalarie> createState() => _CreationGroupleSalarieState();
}

class _CreationGroupleSalarieState extends State<CreationGroupleSalarie> {
  // Declare a list to store the TextEditingController instances _showMultiSelectMenu()
  List<TextEditingController> _textControllers = [];
  List<String> selectedOptions = [];
  List<GlobalKey> _itemsKey = [];
  List<String> Statuts = [];
  List<DateTime> _selectedDate = [];
  List<bool> _selectedOptions = [];

  @override
  void initState() {
    super.initState();
    // Initialize the first TextEditingController
    _selectedOptions = List.generate(30, (_) => false);

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
      _itemWid.add(Text("data"));
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
  final GlobalKey _containerKey33 = GlobalKey();
  final GlobalKey _containerKey4 = GlobalKey();
  final GlobalKey _containerKey_add_statut = GlobalKey();

  double _containerWidth = 200.0;
  double _cursorX = 0.0;
  bool _isResizing = false;

  List<String> _items = [];
  List<Widget> _itemWid = [];
  String nomPrenomSalarie = "";
  List<String> _options = [];
  int _currentIndex = 0;
  getSalary() async {
    var url = "https://zoutechhub.com/pharmaRh/getSalaryNomPrenom.php";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  List<List<String>> _selectedOptionsPerIndex = [];
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

  List<String> _selectedPersonnes = [];
    List<String> _idPersonnes = [];

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
            content: Container(
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
                                    if (value!) {
                                      _selectedPersonnes.add("${snapshot.data[index]['prenom']} ${snapshot.data[index]['nom']}");
                                      _idPersonnes.add("${snapshot.data[index]['id']}");
                                    } else {
                                      _selectedPersonnes.remove("${snapshot.data[index]['prenom']} ${snapshot.data[index]['nom']}");
                                      _idPersonnes.remove("${snapshot.data[index]['id']}");
                                    }
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

  String Statut = "Pas Commencé";
  bool show = false;
  String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String codeCommande = "";
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  inscription(String id_employe,nomPrenom, dateTravail, typeActivite,
      codeEquipe) async {
    setState(() {
      show = true;
    });
    // EncryptData(mpController.text);
    var url =
        "https://zoutechhub.com/pharmaRh/creatEquipe.php?id_employe=$id_employe&nomPrenom=$nomPrenom&dateTravail=$dateTravail&typeActivite=$typeActivite&codeEquipe=$codeEquipe";
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

  

  DateTime _selectedDate0 = DateTime.now();
  String formattedDate1 = "";
  String typeActivite = "";
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setState) => AlertDialog(
                    surfaceTintColor: Colors.white,
                    title: Text(
                      "Création d'un groupe d'employé",
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 18, color: mainColor),
                      textAlign: TextAlign.center,
                    ),
                    content: Container(
                      height: MediaQuery.of(context).size.height / 1.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(),
                          h(20),
                          Text(
                            "1- Veuillez choisir les membres de l'équipe",
                            style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          h(20),
                          Container(
                            height: 220,
                            width: MediaQuery.of(context).size.width / 2,
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
                                                  _selectedOptions[index] =
                                                      value!;
                                                  if (value!) {
                                                    _idPersonnes.add("${snapshot.data[index]['id']}");
                                                    _selectedPersonnes.add("${snapshot.data[index]['prenom']} ${snapshot.data[index]['nom']}");
                                                  } else {
                                                    _idPersonnes.remove("${snapshot.data[index]['id']}");
                                                    _selectedPersonnes.remove("${snapshot.data[index]['prenom']} ${snapshot.data[index]['nom']}");
                                                  }
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
                                    child:
                                        Lottie.asset("assets/images/anim.json"),
                                  ),
                                );
                              },
                            ),
                          ),
                          h(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "2- Date de Permanence / Garde : ",
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
                                          initialDate:
                                              _selectedDate0 ?? DateTime.now(),
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
                                      style: TextStyle(
                                          fontFamily: "normal", fontSize: 14),
                                      controller: TextEditingController(
                                          text: formattedDate1 != ""
                                              ? formattedDate1
                                              : "Cliquez ici pour choisir"),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "3- Type d'activité ",
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
                                    child: InkWell(
                                      onTap: () {
                                        final RenderBox container = _itemsKey[0]
                                            .currentContext
                                            ?.findRenderObject() as RenderBox;
                                        final Offset containerPosition =
                                            container
                                                .localToGlobal(Offset.zero);
                                        final Size containerSize =
                                            container.size;
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
                                            PopupMenuItem(
                                              onTap: () {
                                                setState(() => typeActivite =
                                                    "Permanence");
                                              },
                                              child: Text(
                                                "Permanence",
                                                style: TextStyle(
                                                    fontFamily: 'normal',
                                                    fontSize: 13),
                                              ),
                                              value: 2,
                                            ),
                                            PopupMenuItem(
                                              onTap: () {
                                                setState(() =>
                                                    typeActivite = "Garde");
                                              },
                                              child: Text(
                                                'Garde',
                                                style: TextStyle(
                                                    fontFamily: 'normal',
                                                    fontSize: 13),
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
                                            left: 5,
                                            right: 5,
                                            top: 5,
                                            bottom: 5),
                                        width: 220,
                                        height: 35,
                                        key: _itemsKey[0],
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              typeActivite == ""
                                                  ? "Choisir un type d'activité"
                                                  : typeActivite,
                                              style: TextStyle(
                                                  fontFamily: "normal",
                                                  fontSize: 14),
                                            ),
                                            Icon(
                                              Icons.arrow_drop_down_rounded,
                                              color: const Color.fromARGB(
                                                  154, 0, 0, 0),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor),
                              onPressed: () {
                                codeCommande = getRandomString(10);
                                for (int i = 0; i < _selectedPersonnes.length;i++) {
                                  print(i);
                                  setState((){
                                    inscription(
                                        _idPersonnes[i],
                                        _selectedPersonnes[i],
                                        formattedDate1,
                                        typeActivite,
                                        codeCommande);
                                  });
                                 
                                }
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Créer",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'bold'),
                              ))
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            height: 25,
            decoration: BoxDecoration(
                color: mainColor, borderRadius: BorderRadius.circular(7)),
            child: Center(
              child: Text(
                "Ajouter un groupe de Salarié",
                style: TextStyle(color: Colors.white, fontFamily: 'normal'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
