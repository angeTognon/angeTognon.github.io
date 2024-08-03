import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'dart:html' as html;

class RH extends StatefulWidget {
  const RH({super.key});

  @override
  State<RH> createState() => _RHState();
}

class _RHState extends State<RH> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';

  String _selectedValue = 'Type de Document';
  List<String> _options = [
    'Type de Document',
    'CV',
    'Contrats',
    'Certiﬁcats',
    'Fiches d’évaluation finale'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final GlobalKey _containerKey = GlobalKey();
  final GlobalKey _containerKey2 = GlobalKey();
  final GlobalKey _containerKey3 = GlobalKey();
  final GlobalKey _containerKey4 = GlobalKey();
  final GlobalKey _containerKey5 = GlobalKey();
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  void performSearch(String query) {
    // Ici, vous pouvez implémenter la logique de recherche en fonction de votre application
    print("Recherche pour : $query");
  }

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

  TextEditingController prenomController = TextEditingController();

  io.File? _selectedFile;
  String _fileInfo = '';

  void _pickFile() {
    // Ouvrir le sélecteur de fichiers
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    // Écouter l'événement de sélection de fichier
    uploadInput.onChange.listen((event) {
      // Récupérer le fichier sélectionné
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        final file = files.first;
        setState(() {
          _selectedFile = io.File(file.name);
          _fileInfo = ' ${file.name} ( ${file.size} )';
        });
        _selectedFile == null ? print("null") : print(_fileInfo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height,
      width: (MediaQuery.of(context).size.width * 13.5) / 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Liste des Salariés",
                style: TextStyle(
                    fontFamily: 'bold',
                    fontSize: 23,
                    color: mainColor),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(30),
                      backgroundColor: mainColor),
                  onPressed: () {
                    addSalarie();
                  },
                  child: Text(
                    "Créer un Salarié",
                    style: TextStyle(color: Colors.white, fontFamily: 'bold'),
                  ))
            ],
          ),
          h(40),
          TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            indicatorColor: mainColor,
            controller: _tabController,
            tabs: [
              Tab(
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: mainColor,
                      size: 35,
                    ),
                    w(20),
                    Text(
                      "Utilisateurs (1)",
                      style: TextStyle(fontFamily: 'bold', color: mainColor),
                    )
                  ],
                ),
              ),
              Tab(
                child: Row(
                  children: [
                    Icon(Icons.mail, color: Colors.grey, size: 25),
                    w(20),
                    Text(
                      "Invitations (0)",
                      style: TextStyle(fontFamily: 'bold', color: Colors.grey),
                    )
                  ],
                ),
              ),
              Tab(
                child: Row(
                  children: [
                    Icon(
                      Icons.archive,
                      color: Colors.grey,
                      size: 25,
                    ),
                    w(20),
                    Text(
                      "Archivés (0)",
                      style: TextStyle(fontFamily: 'bold', color: Colors.grey),
                    )
                  ],
                ),
              ),
            ],
          ),
          h(20),
          Row(
            children: [
              InkWell(
                onTap: () {
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
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: mainColor, width: 2.0),
                            ),
                          ),
                          child: Text("Tous les niveaux hiérarchiques"),
                        ),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text('Salarié'),
                        value: 2,
                      ),
                      PopupMenuItem(
                        child: Text('Superviseur'),
                        value: 3,
                      ),
                      PopupMenuItem(
                        child: Text('Gestionnaire'),
                        value: 3,
                      ),
                      PopupMenuItem(
                        child: Text('Administrateur'),
                        value: 3,
                      ),
                    ],
                    elevation: 8.0, // Adjust the elevation for the box shadow
                  );
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                  width: 225,
                  key: _containerKey,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black26)),
                  child: Row(
                    children: [
                      Text(
                        "Tous les niveaux hiérachiques",
                        style: TextStyle(
                            fontFamily: 'normal',
                            fontSize: 12,
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
              w(50),
              InkWell(
                onTap: () {
                  final RenderBox container = _containerKey2.currentContext
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
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: mainColor, width: 2.0),
                            ),
                          ),
                          child: Text("Moins Ancien"),
                        ),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text('Plus Ancien'),
                        value: 2,
                      ),
                    ],
                    elevation: 8.0, // Adjust the elevation for the box shadow
                  );
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                  width: 185,
                  key: _containerKey2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black26)),
                  child: Row(
                    children: [
                      Text(
                        "Trier par Ancienneté",
                        style: TextStyle(
                            fontFamily: 'normal',
                            fontSize: 12,
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
              w(50),
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
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: mainColor, width: 2.0),
                            ),
                          ),
                          child: Text("Trier par ordre Croissant"),
                        ),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text('Trier par ordre DéCroissant'),
                        value: 2,
                      ),
                    ],
                    elevation: 8.0, // Adjust the elevation for the box shadow
                  );
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                  width: 220,
                  key: _containerKey3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black26)),
                  child: Row(
                    children: [
                      Text(
                        "Trier par Ordre Alphabétique",
                        style: TextStyle(
                            fontFamily: 'normal',
                            fontSize: 12,
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
              w(50),
              Container(
                padding: EdgeInsets.only(left: 30, bottom: 0),
                decoration: BoxDecoration(
                    color: Color.fromARGB(73, 42, 116, 100),
                    borderRadius: BorderRadius.circular(15)),
                height: 45,
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
                          hintText: "Rechercher...",
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
            ],
          ),
          h(40),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: mainColor3, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Container(
                  width: 250,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Nom et Prénoms",
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
                  width: 150,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Niveau Hiérachique",
                      style: TextStyle(
                          fontFamily: 'bold',fontSize: 13),
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
                      "Email",
                      style: TextStyle(
                          fontFamily: 'bold',fontSize: 13),
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
                      "Numéro de Tel",
                      style: TextStyle(
                          fontFamily: 'bold',fontSize: 13),
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
                      "Date de Naissance",
                      style: TextStyle(
                          fontFamily: 'bold',fontSize: 13),
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
                      "Identifiant du Salarié",
                      style: TextStyle(
                          fontFamily: 'bold',fontSize: 13),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 3,
                  color: Colors.white54,
                ),
                Container(
                  width: 110,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Action",
                      style: TextStyle(
                          fontFamily: 'bold',fontSize: 13),
                    ),
                  ),
                )
              ],
            ),
          ),
          h(10),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Container(
                  width: 250,
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
                          "TOGNON Koffi Ange",
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
                  color: Colors.white54,
                ),
                Container(
                  width: 150,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Administrateur",
                      style: TextStyle(
                          fontFamily: 'normal',
                          color: Colors.black87,
                          fontSize: 13),
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
                      "tognonange.koffi@gmail.com",
                      style: TextStyle(
                          fontFamily: 'normal',
                          color: Colors.black87,
                          fontSize: 13),
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
                      "57 88 74 11",
                      style: TextStyle(
                          fontFamily: 'normal',
                          color: Colors.black87,
                          fontSize: 13),
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
                      "04/10/2002",
                      style: TextStyle(
                          fontFamily: 'normal',
                          color: Colors.black87,
                          fontSize: 13),
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
                      "#F87DJS92",
                      style: TextStyle(
                          fontFamily: 'normal',
                          color: Colors.black87,
                          fontSize: 13),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 3,
                  color: Colors.white54,
                ),
                Container(
                  key: _containerKey5,
                  width: 110,
                  height: 50,
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        final RenderBox container =
                            _containerKey5.currentContext?.findRenderObject()
                                as RenderBox;
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
                                modifySalarie(
                                    "TOGNON",
                                    "Koffi Ange",
                                    'administrateur',
                                    "tognonange.koffi@gmail.com",
                                    "55887411",
                                    "04/01/2002",
                                    "04/01/2007",
                                    "cotonou",
                                    "Zongo",
                                    "#dsjklj87");
                              },
                              child: Text('Modifier le profile'),
                              value: 2,
                            ),
                            PopupMenuItem(
                              child: Text('Voir le profil'),
                              value: 3,
                            ),
                             PopupMenuItem(
                              child: Text('Supprimer le profil'),
                              value: 3,
                            ),
                            PopupMenuItem(
                              onTap: () {
                                showDialog(
                                  barrierColor: mainColor3,
                                  context: context,
                                  builder: (context) => StatefulBuilder(
                                    builder: (context, setState) => AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        content: Container(
                                          padding: EdgeInsets.all(20),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Ajouter une pièce jointe",
                                                    style: TextStyle(
                                                        fontFamily: 'bold',
                                                        color: mainColor2,
                                                        fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                              
                                              h(20),
                                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                   Text(
                                                    "Type de document : ",
                                                    style: TextStyle(
                                                        fontFamily: 'bold',
                                                        color: mainColor2,),
                                                  ),
                                              h(20),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 20, right: 20),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                6),
                                                        border: Border.all(
                                                            color: mainColor3)),
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        2.4,
                                                    child: DropdownButton<String>(
                                                      underline: Text(""),
                                                      borderRadius:
                                                          BorderRadius.circular(20),
                                                      isExpanded: true,
                                                      value: _selectedValue,
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          _selectedValue =
                                                              newValue!;
                                                        });
                                                      },
                                                      items: _options.map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              h(20),
                                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                     Text(
                                                    "Importation du document ",
                                                    style: TextStyle(
                                                        fontFamily: 'bold',
                                                        color: mainColor2,),
                                                  ),
                                              h(20),
                                                  InkWell(
                                                    onTap: () {
                                                      // Ouvrir le sélecteur de fichiers
                                                        html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
                                                        uploadInput.click();
                                                  
                                                        // Écouter l'événement de sélection de fichier
                                                        uploadInput.onChange.listen((event) {
                                                          // Récupérer le fichier sélectionné
                                                          final files = uploadInput.files;
                                                          if (files != null && files.isNotEmpty) {
                                                            final file = files.first;
                                                            setState(() {
                                                              _selectedFile = io.File(file.name);
                                                              _fileInfo = '${file.name} (${file.size/1000} KB)';
                                                            });
                                                            _selectedFile == null ? print("null") : print(_fileInfo);
                                                          }
                                                        });
                                                    },
                                                    child: Container(
                                                        height: 50,
                                                        padding: EdgeInsets.only(
                                                            left: 20, right: 20),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    6),
                                                            border: Border.all(
                                                                color: mainColor3)),
                                                        width: MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.4,
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.file_present_sharp,color: mainColor2,),
                                                            w(15),
                                                            Text(_selectedFile == null ? "Cliquez ici pour importer le fichier":_fileInfo,style: TextStyle(color: mainColor2,fontFamily: 'normal'),)
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              h(40),
                                             Row(mainAxisAlignment: MainAxisAlignment.end,
                                               children: [
                                                 InkWell(
                                                  onTap: () {
                                                    
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    padding: EdgeInsets.only(left: 25,right: 25),
                                                    decoration: BoxDecoration(
                                                      color: mainColor2,borderRadius: BorderRadius.circular(13)
                                                    ),
                                                    child: Center(
                                                      child: Text("Ajouter",style: TextStyle(
                                                        color: Colors.white,fontFamily: 'normal'
                                                      ),),
                                                    ),
                                                  ),
                                                 ), w(20),
                                                 InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    padding: EdgeInsets.only(left: 25,right: 25),
                                                    decoration: BoxDecoration(
                                                      color: mainColor3,borderRadius: BorderRadius.circular(13)
                                                    ),
                                                    child: Center(
                                                      child: Text("Fermer",style: TextStyle(
                                                        color: Colors.white,fontFamily: 'normal'
                                                      ),),
                                                    ),
                                                  ),
                                                 ),
                                               ],
                                             )
                                            ],
                                          ),
                                        )),
                                  ),
                                );
                              },
                              child: Text('Ajouter des documents importants'),
                              value: 3,
                            ),
                          ],
                          elevation:
                              8.0, // Adjust the elevation for the box shadow
                        );
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        child: Image.asset("assets/images/more_icon.png"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Text(_fileInfo)
        ],
      ),
    );
  }

  addSalarie() {
    showDialog(
      barrierColor: mainColor3,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height / 1.1,
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ajouter un Salarié",
                    style: TextStyle(
                        fontFamily: 'bold', color: mainColor2, fontSize: 20),
                  ),
                ],
              ),
              h(20),
              Text(
                "Renseignements personnels",
                style: TextStyle(
                    fontFamily: 'bold',
                    color: Color.fromARGB(153, 255, 115, 0),
                    fontSize: 17),
              ),
              h(10),
              Container(
                padding: EdgeInsets.only(left: 20),
                color: mainColor4,
                height: 40,
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: mainColor2,
                    ),
                    w(20),
                    Text(
                      "Veuillez spécifier le prénom et le nom",
                      style: TextStyle(
                          fontFamily: 'normal',
                          color: mainColor2,
                          fontSize: 13),
                    )
                  ],
                ),
              ),
              h(20),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                labelText: 'Prénom',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre prénom';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _firstName = value!;
                              },
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                labelText: 'Nom',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre nom';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _lastName = value!;
                              },
                            ),
                          ),
                        ],
                      ),
                      /* SizedBox(height: 16.0),
                          SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!
                                  .validate()) {
                                _formKey.currentState!.save();
                                // Ici, vous pouvez traiter les données du formulaire
                                print(
                                    'Prénom: $_firstName, Nom: $_lastName');
                              }
                            },
                            child: Text('Envoyer'),
                          ), */

                      h(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 33),
                                  child: Text(
                                    "Date de Naissance du salarié",
                                    style: TextStyle(
                                        fontFamily: 'normal', fontSize: 13),
                                  )),
                              h(10),
                              Container(
                                height: 45,
                                width: 300,
                                child: TextFormField(
                                  onTap: _showDatePicker,
                                  decoration: InputDecoration(
                                    labelText: 'Date',
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
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 33),
                                  child: Text(
                                    "Date d'embauche du salarié",
                                    style: TextStyle(
                                        fontFamily: 'normal', fontSize: 13),
                                  )),
                              h(10),
                              Container(
                                height: 45,
                                width: 300,
                                child: TextFormField(
                                  onTap: _showDatePicker,
                                  decoration: InputDecoration(
                                    labelText: 'Date',
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
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              h(10),
              Text(
                "Coordonnées",
                style: TextStyle(
                    fontFamily: 'bold',
                    color: Color.fromARGB(153, 255, 115, 0),
                    fontSize: 17),
              ),
              h(10),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Form(
                  key: _formKey2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                labelText: 'Ville',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre prénom';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _firstName = value!;
                              },
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                labelText: 'Quartier',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre nom';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _lastName = value!;
                              },
                            ),
                          ),
                        ],
                      ),
                      h(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.mail,
                                    color: mainColor2,
                                  ),
                                  onPressed: () => null,
                                ),
                                labelText: 'Adresse Email',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre prénom';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _firstName = value!;
                              },
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.phone,
                                    color: mainColor2,
                                  ),
                                  onPressed: () => null,
                                ),
                                labelText: 'Numéro de Téléphone',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre nom';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _lastName = value!;
                              },
                            ),
                          ),
                        ],
                      ),
                      h(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                labelText: 'Groupe Sanguin',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Groupe Sanguin';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _firstName = value!;
                              },
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.phone,color: mainColor,),
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                labelText: "Contact d'un proche",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Contact d'un proche";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _lastName = value!;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              h(10),
              Text(
                "Statut",
                style: TextStyle(
                    fontFamily: 'bold',
                    color: Color.fromARGB(153, 255, 115, 0),
                    fontSize: 17),
              ),
              h(5),
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width / 1.3,
                child: Form(
                  key: _formKey3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              final RenderBox container = _containerKey4
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
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: mainColor, width: 2.0),
                                        ),
                                      ),
                                      child: Text("Niveau Hiérachique"),
                                    ),
                                    value: 1,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Salarié'),
                                    value: 2,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Superviseur'),
                                    value: 3,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Gestionnaire'),
                                    value: 3,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Administrateur'),
                                    value: 3,
                                  ),
                                ],
                                elevation:
                                    8.0, // Adjust the elevation for the box shadow
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 5, right: 5, top: 10, bottom: 10),
                              width: 300,
                              height: 45,
                              key: _containerKey4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black26)),
                              child: Row(
                                children: [
                                  Text(
                                    "Tous les niveaux hiérachiques",
                                    style: TextStyle(
                                        fontFamily: 'normal',
                                        fontSize: 14,
                                        color: Colors.black45),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down_rounded,
                                    color: const Color.fromARGB(154, 0, 0, 0),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                labelText: 'Poste occupé',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre nom';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _lastName = value!;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: mainColor2),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Valider et Ajouter",
                            style: TextStyle(
                                fontFamily: 'normal', color: Colors.white),
                          ),
                        ],
                      )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  modifySalarie(String nom, prenom, niveau, mail, num, date, date_embauche,
      ville, quartier, id) {
    showDialog(
      barrierColor: mainColor3,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height / 1.1,
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Modifier les informations d'un Salarié",
                    style: TextStyle(
                        fontFamily: 'bold', color: mainColor2, fontSize: 20),
                  ),
                ],
              ),
              h(20),
              Text(
                "Renseignements personnels",
                style: TextStyle(
                    fontFamily: 'bold',
                    color: Color.fromARGB(153, 255, 115, 0),
                    fontSize: 17),
              ),
              h(20),
              Container(
                padding: EdgeInsets.only(left: 20),
                color: mainColor4,
                height: 40,
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: mainColor2,
                    ),
                    w(20),
                    Text(
                      "Veuillez spécifier le prénom et le nom",
                      style: TextStyle(
                          fontFamily: 'normal',
                          color: mainColor2,
                          fontSize: 13),
                    )
                  ],
                ),
              ),
              h(20),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width / 1.3,
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              initialValue: prenom,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                labelText: 'Prénom',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre prénom';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _firstName = value!;
                              },
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              initialValue: nom,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                labelText: 'Nom',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre nom';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _lastName = value!;
                              },
                            ),
                          ),
                        ],
                      ),
                      h(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 33),
                                  child: Text(
                                    "Date de Naissance du salarié",
                                    style: TextStyle(
                                        fontFamily: 'normal', fontSize: 13),
                                  )),
                              h(10),
                              Container(
                                height: 45,
                                width: 300,
                                child: TextFormField(
                                  initialValue: date,
                                  onTap: _showDatePicker,
                                  decoration: InputDecoration(
                                    labelText: 'Date',
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
                                  /* controller: TextEditingController(
                                    text: _selectedDate != null
                                        ? DateFormat('dd/MM/yyyy')
                                            .format(_selectedDate)
                                        : '',
                                  ), */
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 33),
                                  child: Text(
                                    "Date d'embauche du salarié",
                                    style: TextStyle(
                                        fontFamily: 'normal', fontSize: 13),
                                  )),
                              h(10),
                              Container(
                                height: 45,
                                width: 300,
                                child: TextFormField(
                                  initialValue: date_embauche,
                                  onTap: _showDatePicker,
                                  decoration: InputDecoration(
                                    labelText: 'Date',
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
                                  /* controller: TextEditingController(
                                    text: _selectedDate != null
                                        ? DateFormat('dd/MM/yyyy')
                                            .format(_selectedDate)
                                        : '',
                                  ), */
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              h(10),
              Text(
                "Coordonnées",
                style: TextStyle(
                    fontFamily: 'bold',
                    color: Color.fromARGB(153, 255, 115, 0),
                    fontSize: 17),
              ),
              h(20),
              Container(
                height: 120,
                width: MediaQuery.of(context).size.width / 1.3,
                child: Form(
                  key: _formKey2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              initialValue: ville,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                labelText: 'Ville',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre prénom';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _firstName = value!;
                              },
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              initialValue: quartier,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                labelText: 'Quartier',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre nom';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _lastName = value!;
                              },
                            ),
                          ),
                        ],
                      ),
                      h(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              initialValue: mail,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.mail,
                                    color: mainColor2,
                                  ),
                                  onPressed: () => null,
                                ),
                                labelText: 'Adresse Email',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre prénom';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _firstName = value!;
                              },
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              initialValue: num,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.phone,
                                    color: mainColor2,
                                  ),
                                  onPressed: () => null,
                                ),
                                labelText: 'Numéro de Téléphone',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre nom';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _lastName = value!;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              h(10),
              Text(
                "Statut",
                style: TextStyle(
                    fontFamily: 'bold',
                    color: Color.fromARGB(153, 255, 115, 0),
                    fontSize: 17),
              ),
              h(5),
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width / 1.3,
                child: Form(
                  key: _formKey3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              final RenderBox container = _containerKey4
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
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: mainColor, width: 2.0),
                                        ),
                                      ),
                                      child: Text("Niveau Hiérachique"),
                                    ),
                                    value: 1,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Salarié'),
                                    value: 2,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Superviseur'),
                                    value: 3,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Gestionnaire'),
                                    value: 3,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Administrateur'),
                                    value: 3,
                                  ),
                                ],
                                elevation:
                                    8.0, // Adjust the elevation for the box shadow
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 5, right: 5, top: 10, bottom: 10),
                              width: 300,
                              height: 45,
                              key: _containerKey4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black26)),
                              child: Row(
                                children: [
                                  Text(
                                    "Tous les niveaux hiérachiques",
                                    style: TextStyle(
                                        fontFamily: 'normal',
                                        fontSize: 14,
                                        color: Colors.black45),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down_rounded,
                                    color: const Color.fromARGB(154, 0, 0, 0),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                labelText: 'Poste occupé',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre nom';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _lastName = value!;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: mainColor2),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Valider et Ajouter",
                            style: TextStyle(
                                fontFamily: 'normal', color: Colors.white),
                          ),
                        ],
                      )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  addDocSalarie() async {
    showDialog(
      barrierColor: mainColor3,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ajouter une pièce jointe",
                        style: TextStyle(
                            fontFamily: 'bold',
                            color: mainColor2,
                            fontSize: 20),
                      ),
                    ],
                  ),
                  h(20),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: mainColor3)),
                    width: MediaQuery.of(context).size.width / 2.4,
                    child: DropdownButton<String>(
                      underline: Text(""),
                      borderRadius: BorderRadius.circular(20),
                      isExpanded: true,
                      value: _selectedValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedValue = newValue!;
                        });
                      },
                      items: _options
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  h(20),
                  Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: mainColor3)),
                      width: MediaQuery.of(context).size.width / 2.4,
                      child: null),
                  h(20),

                  Text(_fileInfo),
                  ElevatedButton(
                    onPressed: _pickFile,
                    child: Text('Import File'),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            )),
      ),
    );
  }
}
