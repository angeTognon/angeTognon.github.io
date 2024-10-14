import 'dart:convert';
import 'dart:io' as io;
import 'dart:js_interop';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:universal_html/html.dart';
import 'package:zth_app/interfaceAdmin/home.dart';
import 'package:zth_app/interfaceAdmin/profil/user_profile.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:url_launcher/url_launcher.dart';
import 'dart:js' as js;

class RH extends StatefulWidget {
  const RH({super.key});

  @override
  State<RH> createState() => _RHState();
}

class _RHState extends State<RH> with SingleTickerProviderStateMixin {
  final int _currentIndex = 0;
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  String _firstName = '';
  String salaireB = '';
  String _lastName = '';

  String _selectedValue = 'Type de Document';
  final List<String> _options = [
    'Type de Document',
    'CV',
    'Contrats',
    'Certiﬁcats',
    'Fiches d’évaluation finale'
  ];
  final List<GlobalKey<State>> _containerKeys = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 100; i++) {
      _containerKeys.add(GlobalKey<State>());
    }
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
  final bool _isSearching = false;
  void performSearch(String query) {
    // Ici, vous pouvez implémenter la logique de recherche en fonction de votre application
    print("Recherche pour : $query");
  }

  DateTime _selectedDate = DateTime.now();
  String formattedDate1 = "";

  DateTime _selectedDate2 = DateTime.now();
  String formattedDate2 = "";

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
          formattedDate1 =
              "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year.toString()}";
          print(formattedDate1);
        });
      }
    });
  }

  final String _ville = "";

  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController dateNaissanceController = TextEditingController();
  TextEditingController dateEmbaucheController = TextEditingController();
  TextEditingController villeController = TextEditingController();
  TextEditingController quartierController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController groupeSanguinController = TextEditingController();
  TextEditingController contactProcheController = TextEditingController();
  TextEditingController niveauHierachiqueController = TextEditingController();
  TextEditingController postController = TextEditingController();
  TextEditingController salaireBaseController = TextEditingController();
  TextEditingController profileController = TextEditingController();

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

  String mp = "";
  bool show = false;

  inscription() async {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    setState(() {
      show = true;
      print(show);
      mp = String.fromCharCodes(
        Iterable.generate(
          6,
          (_) => chars.codeUnitAt(
            random.nextInt(chars.length),
          ),
        ),
      );
      print(mp);
    });
    // EncryptData(mpController.text);
    var url =
        "https://zoutechhub.com/pharmaRh/ajouter_salarie.php?nom=${nomController.text}&prenom=${prenomController.text}&dateNaissance=$formattedDate1&dateEmbauche=$formattedDate2&ville=${villeController.text}&quartier=${quartierController.text}&email=${emailController.text}&tel=${telController.text}&groupeSanguin=${groupeSanguinController.text}&contactProche=${contactProcheController.text}&niveauHierachique=$statut&post=${postController.text}&profile=d&mp=$mp&salaireBase=${salaireBaseController.text}";
    var response = await http.post(Uri.parse(url));
    if (response.body == "OK") {
      setState(() {
        show = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 18, 133, 22),
          content: Text(
            "Ajout Réussie.",
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
              "Erreur : Il semble que cette adresse mail a déjà été utilisée ",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));
      });
    }
  }

  update(int id) async {
    setState(() {
      show = true;
    });
    // EncryptData(mpController.text);
    var url =
        //"https://zoutechhub.com/pharmaRh/updateSalary.php?id=2&nom=TOGNON aaaa&prenom=Koffi Ange&dateNaissance=04/10/2002&dateEmbauche=13/06/2023&ville=Parakou&quartier=Zongo&email=tognange@gmail.com&tel=55555555&groupeSanguin=B+&contactProche=56565656&niveauHierachique=Salarie&post=Dev";
        "https://zoutechhub.com/pharmaRh/updateSalary.php?id=$id&nom=${nomController.text}&prenom=${prenomController.text}&dateNaissance=$formattedDate1&dateEmbauche=$formattedDate2&ville=${villeController.text}&quartier=${quartierController.text}&email=${emailController.text}&tel=${telController.text}&groupeSanguin=${groupeSanguinController.text}&contactProche=${contactProcheController.text}&niveauHierachique=$statut&post=${postController.text}";
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

  String statut = "";
  String fileName_ = "";

  getSalary() async {
    var url = "https://zoutechhub.com/pharmaRh/getSalary.php";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  getSalaryByNiveau() async {
    var url =
        "https://zoutechhub.com/pharmaRh/getSalaryByNiveau.php?niveauHierachique=$niveauHierachique";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  getSalaryArchived() async {
    var url = "https://zoutechhub.com/pharmaRh/getSalaryArchived.php";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  getSalaryPlusAncien() async {
    var url = "https://zoutechhub.com/pharmaRh/getSalaryPlusAncien.php";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  getSalaryMoinsAncien() async {
    var url = "https://zoutechhub.com/pharmaRh/getSalaryMoinsAncien.php";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  getSalaryAlphaCroissant() async {
    var url = "https://zoutechhub.com/pharmaRh/getSalaryAlphaCroissant.php";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  getSalaryAlphaDecroissant() async {
    var url = "https://zoutechhub.com/pharmaRh/getSalaryAlphaDecroissant.php";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }
  /*  */

  deleteSalary(int id) async {
    setState(() {
      show = true;
    });
    var url = "https://zoutechhub.com/pharmaRh/deleteSalary.php?id=$id";
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

  late final result;
  bool isUploaded = false;
  Future<void> pickFile() async {
    if (result != null && result!.files.isNotEmpty) {
      result = null;
    }
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      onFileLoading: (status) => print(status),
      allowedExtensions: null,
    );
  }

  late final file;
  Future<bool> uploadFileToServer(String username) async {
    setState(() {
      show = true;
    });
    try {
      if (result != null && result.files.isNotEmpty) {
        file = result.files.single;
        final bytes = file.bytes;
        if (bytes != null) {
          final uri = Uri.parse(
              'https://zoutechhub.com/pharmaRh/ajouterDocSalary.php?folder=$username');
          final request = http.MultipartRequest('POST', uri);
          request.files.add(
              http.MultipartFile.fromBytes('file', bytes, filename: fileName_));
          final response = await request.send();
          final responseData = await response.stream.bytesToString();
          final jsonResponse = jsonDecode(responseData);

          if (response.statusCode == 200 && !jsonResponse['error']) {
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Color.fromARGB(255, 18, 133, 22),
                  content: Text(
                    "Ajout Réussi",
                    style: TextStyle(
                      fontFamily: 'normal',
                      color: Colors.white,
                    ),
                  )));
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ));
            });
            return true;
          } else {
            print('Error uploading file: ${jsonResponse['msg']}');
            return false;
          }
        } else {
          print('No file selected');
          return false;
        }
      } else {
        print('No file selected');
        return false;
      }
    } catch (e) {
      setState(() {
        show = false;
      });

      print('Error uploading file: $e');
      return false;
    }
  }

  updateCV(int id, String endPoint) async {
    setState(() {
      show = true;
    });
    var url =
        "https://zoutechhub.com/pharmaRh/updateCv.php?cv=$endPoint&id=$id";
    var response = await http.post(Uri.parse(url));
    print(response.body);
    print(response.statusCode);
    if (response.body == "OK") {
      setState(() {
        show = false;
      });
      /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 18, 133, 22),
          content: Text(
            "Modification Réussie.",
            style: TextStyle(
              fontFamily: 'normal',
              color: Colors.white,
            ),
          )));
      Navigator.pop(context); */
    } else {
      setState(() {
        show = false;
        /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Erreur. Veuillez actualiser la page",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ))); */
      });
    }
  }

  updateContrat(int id, String endPoint) async {
    setState(() {
      show = true;
    });
    var url =
        "https://zoutechhub.com/pharmaRh/updateContrat.php?contrat=$endPoint&id=$id";
    var response = await http.post(Uri.parse(url));
    print(response.body);
    print(response.statusCode);
    if (response.body == "OK") {
      setState(() {
        show = false;
      });
    } else {
      setState(() {
        show = false;
      });
    }
  }

  updateCertificat(int id, String endPoint) async {
    setState(() {
      show = true;
    });
    var url =
        "https://zoutechhub.com/pharmaRh/updateCertificat.php?certificat=$endPoint&id=$id";
    var response = await http.post(Uri.parse(url));
    print(response.body);
    print(response.statusCode);
    if (response.body == "OK") {
      setState(() {
        show = false;
      });
    } else {
      setState(() {
        show = false;
      });
    }
  }

  updateFiche(int id, String endPoint) async {
    setState(() {
      show = true;
    });
    var url =
        "https://zoutechhub.com/pharmaRh/updateFiche.php?fiche=$endPoint&id=$id";
    var response = await http.post(Uri.parse(url));
    print(response.body);
    print(response.statusCode);
    if (response.body == "OK") {
      setState(() {
        show = false;
      });
    } else {
      setState(() {
        show = false;
      });
    }
  }

  archiver(int id) async {
    setState(() {
      show = true;
    });
    var url = "https://zoutechhub.com/pharmaRh/archiver.php?id=$id";
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
            "Archivage Réussie",
            style: TextStyle(
              fontFamily: 'normal',
              color: Colors.white,
            ),
          )));
    } else {
      setState(() {
        show = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "Erreur. Veuillez actualiser la page",
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          )));
    }
  }

  desarchiver(int id) async {
    setState(() {
      show = true;
    });
    var url = "https://zoutechhub.com/pharmaRh/desarchiver.php?id=$id";
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
            "Archivage Réussie",
            style: TextStyle(
              fontFamily: 'normal',
              color: Colors.white,
            ),
          )));
    } else {
      setState(() {
        show = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "Erreur. Veuillez actualiser la page",
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          )));
    }
  }

  int index = 0;

  bool isNiveauHierachique = false;
  bool isAnciennetePlus = false;
  bool isAncienneteMoins = false;
  bool isCroissant = false;
  bool isDecroissant = false;
  String niveauHierachique = "";
  String anciennete = "";
  String alpha = "";

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
            /* Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Liste des Salariés",
                  style: TextStyle(
                      fontFamily: 'bold', fontSize: 23, color: mainColor),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(30),
                        backgroundColor: mainColor),
                    onPressed: () {
                      setState(
                        () {
                          nomController.text = "";
                          prenomController.text = "";
                          villeController.text = "";
                          quartierController.text = "";
                          emailController.text = "";
                          telController.text = "";
                          postController.text = "";
                          formattedDate1 = "";
                          formattedDate2 = "";
                          statut = statut;
                          print(formattedDate1 + "------ " + formattedDate2);
                        },
                      );
                      addSalarie();
                    },
                    child: Text(
                      "Créer un Salarié",
                      style: TextStyle(color: Colors.white, fontFamily: 'bold'),
                    ))
              ],
            ), */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Heureux de vous revoir Koffi !",
                  style: TextStyle(fontFamily: 'bold', fontSize: 18),
                ),
                Icon(
                  Icons.notifications,
                  color: mainColor,
                  size: 40,
                ),
              ],
            ),
            h(10),
            const Divider(),
            h(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Détails sur vos employés",
                  style: TextStyle(
                      fontFamily: 'bold', fontSize: 16, color: Colors.black54),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(
                          () {
                            nomController.text = "";
                            prenomController.text = "";
                            villeController.text = "";
                            quartierController.text = "";
                            emailController.text = "";
                            telController.text = "";
                            postController.text = "";
                            formattedDate1 = "";
                            formattedDate2 = "";
                            statut = statut;
                            print("$formattedDate1------ $formattedDate2");
                          },
                        );
                        addSalarie();
                      },
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(10)),
                          height: 40,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Center(
                              child: Row(
                            children: [
                              const Icon(
                                Icons.person_add_alt_sharp,
                                color: Colors.white,
                              ),
                              w(10),
                              const Text(
                                "Ajouter un membre",
                                style: TextStyle(
                                  fontFamily: 'normal',
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ),
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
                      Icon(
                        Icons.person,
                        color: mainColor,
                        size: 35,
                      ),
                      w(20),
                      Text(
                        "Utilisateurs Actifs",
                        style: TextStyle(fontFamily: 'bold', color: mainColor),
                      )
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.archive,
                        color: Colors.grey,
                        size: 25,
                      ),
                      w(20),
                      const Text(
                        "Utilisateurs Archivés ",
                        style:
                            TextStyle(fontFamily: 'bold', color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ],
            ),
            h(20),
            index == 0 ? Utilisateur() : UtilisateurArchivied(),
          ],
        ),
      ),
    );
  }

  BoxSalary(
      String prenom,
      nom,
      dateNaissance,
      dateEmbauche,
      ville,
      quartier,
      email,
      tel,
      groupeSanguin,
      contactProche,
      niveauHierachique,
      post,
      int index,
      id,
      String cv,
      contrat,
      certificat,
      fiche) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 250,
                margin: const EdgeInsets.only(left: 0),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 5),
                      width: 35,
                      child: CircleAvatar(
                        backgroundColor: mainColor3,
                        child: Icon(
                          Icons.person,
                          color: mainColor2,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "$prenom " + nom,
                            style: const TextStyle(
                                fontFamily: 'normal',
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 3,
                color: const Color.fromARGB(87, 194, 194, 194),
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: Center(
                  child: Text(
                    niveauHierachique,
                    style: const TextStyle(
                        fontFamily: 'normal',
                        color: Colors.black,
                        fontSize: 14),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 3,
                color: const Color.fromARGB(87, 194, 194, 194),
              ),
              SizedBox(
                width: 250,
                height: 50,
                child: Center(
                  child: Text(
                    email,
                    style: const TextStyle(
                        fontFamily: 'normal',
                        color: Colors.black,
                        fontSize: 14),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 3,
                color: const Color.fromARGB(87, 194, 194, 194),
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: Center(
                  child: Text(
                    tel,
                    style: const TextStyle(
                        fontFamily: 'normal',
                        color: Colors.black,
                        fontSize: 14),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 3,
                color: const Color.fromARGB(87, 194, 194, 194),
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: Center(
                  child: Text(
                    dateNaissance,
                    style: const TextStyle(
                        fontFamily: 'normal',
                        color: Colors.black,
                        fontSize: 14),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 3,
                color: const Color.fromARGB(87, 194, 194, 194),
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: Center(
                  child: Text(
                    dateEmbauche,
                    style: const TextStyle(
                        fontFamily: 'normal',
                        color: Colors.black,
                        fontSize: 14),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 3,
                color: const Color.fromARGB(87, 194, 194, 194),
              ),
              SizedBox(
                key: _containerKeys[index],
                width: 110,
                height: 50,
                child: Center(
                  child: InkWell(
                    onTap: () {
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
                            onTap: () {
                              print("**************" "${_tabController.index}");
                              setState(
                                () {
                                  _tabController.index == 0
                                      ? archiver(id)
                                      : desarchiver(id);
                                },
                              );
                            },
                            value: 2,
                            child: Text(
                              _tabController.index == 0
                                  ? 'Archiver'
                                  : "Désarchiver",
                              style: TextStyle(fontFamily: 'normal'),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              setState(
                                () {
                                  nomController.text = nom;
                                  prenomController.text = prenom;
                                  villeController.text = ville;
                                  quartierController.text = quartier;
                                  emailController.text = email;
                                  telController.text = tel;
                                  postController.text = post;
                                  groupeSanguinController.text = groupeSanguin;
                                  contactProcheController.text = contactProche;
                                  formattedDate1 = dateNaissance;
                                  formattedDate2 = dateEmbauche;
                                  statut = niveauHierachique;
                                  print(
                                      "$formattedDate1------ $formattedDate2");
                                },
                              );
                              modifySalarie(
                                  prenom,
                                  nom,
                                  dateNaissance,
                                  dateEmbauche,
                                  ville,
                                  quartier,
                                  email,
                                  tel,
                                  groupeSanguin,
                                  contactProche,
                                  niveauHierachique,
                                  post,
                                  id);
                            },
                            value: 2,
                            child: Text(
                              'Modifier le profile',
                              style: TextStyle(fontFamily: 'normal'),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              setState(
                                () {
                                  nomController.text = nom;
                                  prenomController.text = prenom;
                                  villeController.text = ville;
                                  quartierController.text = quartier;
                                  emailController.text = email;
                                  telController.text = tel;
                                  postController.text = post;
                                  formattedDate1 = dateNaissance;
                                  formattedDate2 = dateEmbauche;
                                  statut = statut;
                                  print(
                                      "$formattedDate1------ $formattedDate2");
                                },
                              );
                              showDialog(
                                  //barrierColor: mainColor3,
                                  context: context,
                                  builder: (context) => StatefulBuilder(
                                        builder: (context, setState) {
                                          return AlertDialog(
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                            content: Container(
                                              padding: const EdgeInsets.all(20),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  1.1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: 140,
                                                        width: 140,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            image: const DecorationImage(
                                                                image: AssetImage(
                                                                    "assets/images/ange.jpg"),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      ),
                                                    ],
                                                  ),
                                                  h(20),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Noms Et Prénoms",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'bold',
                                                                  color:
                                                                      mainColor),
                                                            ),
                                                            h(10),
                                                            Container(
                                                              width: 350,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black38)),
                                                              child: Center(
                                                                child: Text(
                                                                  "$prenom " +
                                                                      nom,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          'bold'),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Email",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'bold',
                                                                  color:
                                                                      mainColor),
                                                            ),
                                                            h(10),
                                                            Container(
                                                              width: 350,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black38)),
                                                              child: Center(
                                                                child: Text(
                                                                  email,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          'bold'),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ]),
                                                  h(10),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Date de Naissance",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'bold',
                                                                  color:
                                                                      mainColor),
                                                            ),
                                                            h(10),
                                                            Container(
                                                              width: 350,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black38)),
                                                              child: Center(
                                                                child: Text(
                                                                  dateNaissance,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          'bold'),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Date Embauche",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'bold',
                                                                  color:
                                                                      mainColor),
                                                            ),
                                                            h(10),
                                                            Container(
                                                              width: 350,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black38)),
                                                              child: Center(
                                                                child: Text(
                                                                  dateEmbauche,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          'bold'),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ]),
                                                  h(5),
                                                  const Text(
                                                    "Coordonnées",
                                                    style: TextStyle(
                                                        fontFamily: 'bold',
                                                        color: Color.fromARGB(
                                                            153, 255, 115, 0),
                                                        fontSize: 17),
                                                  ),
                                                  h(5),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Contact d'un Proche",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'bold',
                                                                  color:
                                                                      mainColor),
                                                            ),
                                                            h(10),
                                                            Container(
                                                              width: 350,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black38)),
                                                              child: Center(
                                                                child: Text(
                                                                  contactProche,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          'bold'),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Quartier",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'bold',
                                                                  color:
                                                                      mainColor),
                                                            ),
                                                            h(10),
                                                            Container(
                                                              width: 350,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black38)),
                                                              child: Center(
                                                                child: Text(
                                                                  quartier,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          'bold'),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ]),
                                                  h(5),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Numéro de Téléphone",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'bold',
                                                                  color:
                                                                      mainColor),
                                                            ),
                                                            h(10),
                                                            Container(
                                                              width: 350,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black38)),
                                                              child: Center(
                                                                child: Text(
                                                                  tel,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          'bold'),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Groupe Sanguin",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'bold',
                                                                  color:
                                                                      mainColor),
                                                            ),
                                                            h(10),
                                                            Container(
                                                              width: 350,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black38)),
                                                              child: Center(
                                                                child: Text(
                                                                  groupeSanguin,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          'bold'),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ]),
                                                  h(10),
                                                  const Text(
                                                    "Statut",
                                                    style: TextStyle(
                                                        fontFamily: 'bold',
                                                        color: Color.fromARGB(
                                                            153, 255, 115, 0),
                                                        fontSize: 17),
                                                  ),
                                                  h(5),
                                                  SizedBox(
                                                    height: 70,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.3,
                                                    child: Form(
                                                      key: _formKey3,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left: 5,
                                                                        right:
                                                                            5,
                                                                        top: 10,
                                                                        bottom:
                                                                            10),
                                                                width: 300,
                                                                height: 45,
                                                                key:
                                                                    _containerKey4,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .black26)),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      statut ==
                                                                              ""
                                                                          ? niveauHierachique
                                                                          : statut,
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                              'normal',
                                                                          fontSize:
                                                                              14,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0)),
                                                                    ),
                                                                    const Icon(
                                                                      Icons
                                                                          .arrow_drop_down_rounded,
                                                                      color: Color
                                                                          .fromARGB(
                                                                              154,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 45,
                                                                width: 300,
                                                                child:
                                                                    TextFormField(
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'bold',
                                                                      color: Colors
                                                                          .black45,
                                                                      fontSize:
                                                                          14),
                                                                  controller:
                                                                      postController,
                                                                  enabled:
                                                                      false,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelStyle: TextStyle(
                                                                        fontFamily:
                                                                            'bold',
                                                                        fontSize:
                                                                            14,
                                                                        color:
                                                                            mainColor),
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                    labelText:
                                                                        "Post",
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      show
                                                          ? const CircularProgressIndicator()
                                                          : InkWell(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                height: 50,
                                                                width: 200,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    color:
                                                                        mainColor2),
                                                                child:
                                                                    const Center(
                                                                        child:
                                                                            Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      "Fermer",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'normal',
                                                                          color:
                                                                              Colors.white),
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
                                          );
                                        },
                                      ));
                            },
                            value: 3,
                            child: Text(
                              'Voir le profil',
                              style: TextStyle(fontFamily: 'normal'),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              deleteSalary(id);
                            },
                            value: 3,
                            child: Text(
                              'Supprimer le profil',
                              style: TextStyle(fontFamily: 'normal'),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              setState(() {
                                show = false;
                              });
                            },
                            value: 3,
                            child: Text(
                              'Ajouter des documents importants',
                              style: TextStyle(fontFamily: 'normal'),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              cv == ""
                                  ? ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor:
                                              Color.fromARGB(255, 106, 15, 15),
                                          content: Text(
                                            "Veuillez d'abord ajouter un document",
                                            style: TextStyle(
                                              fontFamily: 'normal',
                                              color: Colors.white,
                                            ),
                                          )))
                                  : js.context.callMethod('open', [cv]);
                            },
                            value: 2,
                            child: Text(
                              'Voir le CV',
                              style: TextStyle(fontFamily: 'normal'),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              contrat == ""
                                  ? ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor:
                                              Color.fromARGB(255, 106, 15, 15),
                                          content: Text(
                                            "Veuillez d'abord ajouter un document",
                                            style: TextStyle(
                                              fontFamily: 'normal',
                                              color: Colors.white,
                                            ),
                                          )))
                                  : js.context.callMethod('open', [contrat]);
                            },
                            value: 2,
                            child: Text(
                              'Voir le Contrat',
                              style: TextStyle(fontFamily: 'normal'),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              certificat == ""
                                  ? ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor:
                                              Color.fromARGB(255, 106, 15, 15),
                                          content: Text(
                                            "Veuillez d'abord ajouter un document",
                                            style: TextStyle(
                                              fontFamily: 'normal',
                                              color: Colors.white,
                                            ),
                                          )))
                                  : js.context.callMethod('open', [certificat]);
                            },
                            value: 2,
                            child: Text(
                              'Voir le Certificat',
                              style: TextStyle(fontFamily: 'normal'),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              setState(() {
                                fiche == ""
                                    ? ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            backgroundColor: Color.fromARGB(
                                                255, 106, 15, 15),
                                            content: Text(
                                              "Veuillez d'abord ajouter un document",
                                              style: TextStyle(
                                                fontFamily: 'normal',
                                                color: Colors.white,
                                              ),
                                            )))
                                    : js.context.callMethod('open', [fiche]);
                              });
                            },
                            value: 2,
                            child: Text(
                              'Voir la Fiche évaluation',
                              style: TextStyle(fontFamily: 'normal'),
                            ),
                          ),
                        ],
                        elevation:
                            8.0, // Adjust the elevation for the box shadow
                      );
                    },
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset("assets/images/more_icon.png"),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            height: 2,
          ),
        ],
      ),
    );
  }

  addSalarie() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height + 100,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Ajouter un Membre",
                      style: TextStyle(
                          fontFamily: 'bold',
                          color: Colors.black,
                          fontSize: 20),
                    ),
                  ],
                ),
                h(20),
                const Text(
                  "Renseignements personnels",
                  style: TextStyle(
                      fontFamily: 'bold', color: Colors.black, fontSize: 17),
                ),
                h(20),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 45,
                              width: 300,
                              child: TextFormField(
                                controller: prenomController,
                                decoration: const InputDecoration(
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
                            SizedBox(
                              height: 45,
                              width: 300,
                              child: TextFormField(
                                controller: nomController,
                                decoration: const InputDecoration(
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
                        h(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(left: 33),
                                    child: const Text(
                                      "Date de Naissance du salarié",
                                      style: TextStyle(
                                          fontFamily: 'normal', fontSize: 13),
                                    )),
                                h(10),
                                SizedBox(
                                  height: 45,
                                  width: 300,
                                  child: TextFormField(
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate:
                                            _selectedDate ?? DateTime.now(),
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
                                      labelText: 'Date',
                                      labelStyle: const TextStyle(
                                          fontFamily: 'normal',
                                          fontSize: 14,
                                          color: Colors.black45),
                                      border: const OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.calendar_today),
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
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(left: 33),
                                    child: const Text(
                                      "Date d'embauche du salarié",
                                      style: TextStyle(
                                          fontFamily: 'normal', fontSize: 13),
                                    )),
                                h(10),
                                SizedBox(
                                  height: 45,
                                  width: 300,
                                  child: TextFormField(
                                    onTap: () {
                                      showDatePicker(
                                        initialDatePickerMode:
                                            DatePickerMode.day,
                                        initialEntryMode:
                                            DatePickerEntryMode.inputOnly,
                                        context: context,
                                        initialDate:
                                            _selectedDate2 ?? DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100),
                                      ).then((pickedDate2) {
                                        if (pickedDate2 != null) {
                                          setState(() {
                                            _selectedDate2 = pickedDate2;
                                            formattedDate2 =
                                                "${pickedDate2.day.toString().padLeft(2, '0')}/${pickedDate2.month.toString().padLeft(2, '0')}/${pickedDate2.year.toString()}";
                                            print(formattedDate2);
                                          });
                                        }
                                      });
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Date',
                                      labelStyle: const TextStyle(
                                          fontFamily: 'normal',
                                          fontSize: 14,
                                          color: Colors.black45),
                                      border: const OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.calendar_today),
                                        onPressed: () {},
                                      ),
                                    ),
                                    readOnly: true,
                                    controller: TextEditingController(
                                        text: formattedDate2 != ""
                                            ? formattedDate2
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
                ),
                h(10),
                const Text(
                  "Coordonnées",
                  style: TextStyle(
                      fontFamily: 'bold', color: Colors.black, fontSize: 17),
                ),
                h(10),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Form(
                    key: _formKey2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 45,
                              width: 300,
                              child: TextFormField(
                                controller: villeController,
                                decoration: const InputDecoration(
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
                            SizedBox(
                              height: 45,
                              width: 300,
                              child: TextFormField(
                                controller: quartierController,
                                decoration: const InputDecoration(
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
                            SizedBox(
                              height: 45,
                              width: 300,
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      fontFamily: 'normal',
                                      fontSize: 14,
                                      color: Colors.black45),
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.mail,
                                      color: mainColor2,
                                    ),
                                    onPressed: () {},
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
                            SizedBox(
                              height: 45,
                              width: 300,
                              child: TextFormField(
                                controller: telController,
                                decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      fontFamily: 'normal',
                                      fontSize: 14,
                                      color: Colors.black45),
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.phone,
                                      color: mainColor2,
                                    ),
                                    onPressed: () {},
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
                            SizedBox(
                              height: 45,
                              width: 300,
                              child: TextFormField(
                                controller: groupeSanguinController,
                                decoration: const InputDecoration(
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
                            SizedBox(
                              height: 45,
                              width: 300,
                              child: TextFormField(
                                controller: contactProcheController,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.phone,
                                    color: mainColor,
                                  ),
                                  labelStyle: const TextStyle(
                                      fontFamily: 'normal',
                                      fontSize: 14,
                                      color: Colors.black45),
                                  border: const OutlineInputBorder(),
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
                const Text(
                  "Statut",
                  style: TextStyle(
                      fontFamily: 'bold', color: Colors.black, fontSize: 17),
                ),
                h(5),
                SizedBox(
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
                                      onTap: () {
                                        setState(() {
                                          statut = "Salarié";
                                        });
                                      },
                                      value: 2,
                                      child: Text('Salarié'),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        setState(() {
                                          statut = "Superviseur";
                                        });
                                      },
                                      value: 3,
                                      child: Text('Superviseur'),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        setState(() {
                                          statut = "Gestionnaire";
                                        });
                                      },
                                      value: 3,
                                      child: Text('Gestionnaire'),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        setState(() {
                                          statut = "Administrateur";
                                        });
                                      },
                                      value: 3,
                                      child: Text('Administrateur'),
                                    ),
                                  ],
                                  elevation:
                                      8.0, // Adjust the elevation for the box shadow
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, top: 10, bottom: 10),
                                width: 300,
                                height: 45,
                                key: _containerKey4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black26)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      statut == ""
                                          ? "Tous les niveaux hiérachiques"
                                          : statut,
                                      style: const TextStyle(
                                          fontFamily: 'normal',
                                          fontSize: 14,
                                          color: Colors.black45),
                                    ),
                                    const Icon(
                                      Icons.arrow_drop_down_rounded,
                                      color: Color.fromARGB(154, 0, 0, 0),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 45,
                              width: 300,
                              child: TextFormField(
                                controller: postController,
                                decoration: const InputDecoration(
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 45,
                      width: 300,
                      child: TextFormField(
                        controller: salaireBaseController,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(
                              fontFamily: 'normal',
                              fontSize: 14,
                              color: Colors.black45),
                          border: OutlineInputBorder(),
                          labelText: 'Salaire de base',
                        ),
                        onSaved: (value) {
                          salaireB = value!;
                        },
                      ),
                    ),
                    show
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: 300,
                            child: InkWell(
                              onTap: () {
                                if (prenomController.text == "" ||
                                    nomController.text == "" ||
                                    formattedDate1 == "" ||
                                    formattedDate2 == "" ||
                                    villeController.text == "" ||
                                    quartierController.text == "" ||
                                    emailController.text == "" ||
                                    telController.text == "" ||
                                    groupeSanguinController.text == "" ||
                                    contactProcheController.text == "" ||
                                    statut == "" ||
                                    postController.text == "") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                      "Veuillez remplir tous les champs",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'bold'),
                                    ),
                                    backgroundColor:
                                        Color.fromARGB(255, 148, 39, 31),
                                  ));
                                } else {
                                  setState(() {
                                    inscription();
                                  });
                                }
                              },
                              child: Container(
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: mainColor2),
                                child: const Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Valider et Ajouter",
                                      style: TextStyle(
                                          fontFamily: 'normal',
                                          color: Colors.white),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                  ],
                ), /* 
                 */
              ],
            ),
          ),
        );
      }),
    );
  }

  modifySalarie(String prenom, nom, date, dateEmbauche, ville, quartier, email,
      tel, groupeSanguin, contactProche, niveau, post, int id) {
    showDialog(
        //barrierColor: mainColor3,
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  content: Container(
                    padding: const EdgeInsets.all(20),
                    height: MediaQuery.of(context).size.height / 1.1,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Modifier les informations d'un membre",
                              style: TextStyle(
                                  fontFamily: 'bold',
                                  color: Colors.black,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        h(20),
                        const Text(
                          "Renseignements personnels",
                          style: TextStyle(
                              fontFamily: 'bold',
                              color: Colors.black,
                              fontSize: 17),
                        ),
                        h(20),
                        Container(
                          padding: const EdgeInsets.only(left: 20),
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
                        SizedBox(
                          height: 140,
                          width: MediaQuery.of(context).size.width / 1.3,
                          child: Form(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      height: 45,
                                      width: 300,
                                      child: TextFormField(
                                        controller: prenomController,
                                        //initialValue: prenom,
                                        decoration: InputDecoration(
                                          labelStyle: const TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 14,
                                              color: Colors.black45),
                                          border: const OutlineInputBorder(),
                                          labelText:
                                              prenomController.text == prenom
                                                  ? "Prénoms"
                                                  : prenom,
                                        ),
                                        onTap: () {
                                          setState(
                                            () {
                                              prenomController.text = prenom;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: 300,
                                      child: TextFormField(
                                        controller: nomController,
                                        decoration: InputDecoration(
                                          labelStyle: const TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 14,
                                              color: Colors.black45),
                                          border: const OutlineInputBorder(),
                                          labelText: nomController.text == nom
                                              ? "Noms"
                                              : nom,
                                        ),
                                        onTap: () {
                                          setState(
                                            () {
                                              nomController.text = nom;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                h(10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin:
                                                const EdgeInsets.only(left: 33),
                                            child: const Text(
                                              "Date de Naissance du salarié",
                                              style: TextStyle(
                                                  fontFamily: 'normal',
                                                  fontSize: 13),
                                            )),
                                        h(10),
                                        SizedBox(
                                          height: 45,
                                          width: 300,
                                          child: TextFormField(
                                            onTap: () {
                                              showDatePicker(
                                                initialDatePickerMode:
                                                    DatePickerMode.day,
                                                initialEntryMode:
                                                    DatePickerEntryMode
                                                        .inputOnly,
                                                context: context,
                                                initialDate: _selectedDate ??
                                                    DateTime.now(),
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime(2100),
                                                useRootNavigator: true,
                                                routeSettings:
                                                    const RouteSettings(
                                                        name: 'date_picker'),
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
                                              labelText: 'Date',
                                              labelStyle: const TextStyle(
                                                  fontFamily: 'normal',
                                                  fontSize: 14,
                                                  color: Colors.black45),
                                              border:
                                                  const OutlineInputBorder(),
                                              suffixIcon: IconButton(
                                                icon: const Icon(
                                                    Icons.calendar_today),
                                                onPressed: () {},
                                              ),
                                            ),
                                            readOnly: true,
                                            controller: TextEditingController(
                                                text: formattedDate1 !=
                                                        "Cliquez ici pour choisir"
                                                    ? formattedDate1
                                                    : formattedDate1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin:
                                                const EdgeInsets.only(left: 33),
                                            child: const Text(
                                              "Date d'embauche du salarié",
                                              style: TextStyle(
                                                  fontFamily: 'normal',
                                                  fontSize: 13),
                                            )),
                                        h(10),
                                        SizedBox(
                                          height: 45,
                                          width: 300,
                                          child: TextFormField(
                                            onTap: () {
                                              showDatePicker(
                                                initialDatePickerMode:
                                                    DatePickerMode.day,
                                                initialEntryMode:
                                                    DatePickerEntryMode
                                                        .inputOnly,
                                                context: context,
                                                initialDate: _selectedDate2 ??
                                                    DateTime.now(),
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime(2100),
                                              ).then((pickedDate2) {
                                                if (pickedDate2 != null) {
                                                  setState(() {
                                                    _selectedDate2 =
                                                        pickedDate2;
                                                    formattedDate2 =
                                                        "${pickedDate2.day.toString().padLeft(2, '0')}/${pickedDate2.month.toString().padLeft(2, '0')}/${pickedDate2.year.toString()}";
                                                    print(formattedDate2);
                                                  });
                                                }
                                              });
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Date',
                                              labelStyle: const TextStyle(
                                                  fontFamily: 'normal',
                                                  fontSize: 14,
                                                  color: Colors.black45),
                                              border:
                                                  const OutlineInputBorder(),
                                              suffixIcon: IconButton(
                                                icon: const Icon(
                                                    Icons.calendar_today),
                                                onPressed: () {},
                                              ),
                                            ),
                                            readOnly: true,
                                            controller: TextEditingController(
                                                text: formattedDate2 != ""
                                                    ? formattedDate2
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
                        ),
                        const Text(
                          "Coordonnées",
                          style: TextStyle(
                              fontFamily: 'bold',
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 17),
                        ),
                        h(5),
                        SizedBox(
                          height: 165,
                          width: MediaQuery.of(context).size.width / 1.3,
                          child: Form(
                            key: _formKey2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      height: 45,
                                      width: 300,
                                      child: TextFormField(
                                        controller: villeController,
                                        decoration: InputDecoration(
                                          labelStyle: const TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 14,
                                              color: Colors.black45),
                                          border: const OutlineInputBorder(),
                                          labelText:
                                              villeController.text == ville
                                                  ? "Ville"
                                                  : ville,
                                        ),
                                        onTap: () {
                                          setState(
                                            () {
                                              villeController.text = ville;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: 300,
                                      child: TextFormField(
                                        controller: quartierController,
                                        decoration: InputDecoration(
                                          labelStyle: const TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 14,
                                              color: Colors.black45),
                                          border: const OutlineInputBorder(),
                                          labelText: quartierController.text ==
                                                  quartier
                                              ? "Quartier"
                                              : quartier,
                                        ),
                                        onTap: () {
                                          setState(
                                            () {
                                              quartierController.text =
                                                  quartier;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                h(20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      height: 45,
                                      width: 300,
                                      child: TextFormField(
                                        controller: emailController,
                                        decoration: InputDecoration(
                                          labelStyle: const TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 14,
                                              color: Colors.black45),
                                          border: const OutlineInputBorder(),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              Icons.mail,
                                              color: mainColor2,
                                            ),
                                            onPressed: () {},
                                          ),
                                          labelText:
                                              emailController.text == email
                                                  ? "Adresse email"
                                                  : email,
                                        ),
                                        onTap: () {
                                          setState(
                                            () {
                                              emailController.text = email;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: 300,
                                      child: TextFormField(
                                        onTap: () {
                                          setState(
                                            () {
                                              telController.text = tel;
                                            },
                                          );
                                        },
                                        controller: telController,
                                        //initialValue: tel,
                                        decoration: InputDecoration(
                                          labelStyle: const TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 14,
                                              color: Colors.black45),
                                          border: const OutlineInputBorder(),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              Icons.phone,
                                              color: mainColor2,
                                            ),
                                            onPressed: () {},
                                          ),
                                          labelText: telController.text == tel
                                              ? "Numéro de téléphone"
                                              : tel,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                h(10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      height: 45,
                                      width: 300,
                                      child: TextFormField(
                                        onTap: () {
                                          setState(
                                            () {
                                              groupeSanguinController.text =
                                                  groupeSanguin;
                                            },
                                          );
                                        },
                                        controller: groupeSanguinController,
                                        decoration: InputDecoration(
                                          labelStyle: const TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 14,
                                              color: Colors.black45),
                                          border: const OutlineInputBorder(),
                                          labelText:
                                              groupeSanguinController.text ==
                                                      groupeSanguin
                                                  ? "Groupe Sanguin"
                                                  : groupeSanguin,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: 300,
                                      child: TextFormField(
                                        onTap: () {
                                          setState(
                                            () {
                                              contactProcheController.text =
                                                  contactProche;
                                            },
                                          );
                                        },
                                        controller: contactProcheController,
                                        decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.phone,
                                            color: mainColor,
                                          ),
                                          labelStyle: const TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 14,
                                              color: Colors.black45),
                                          border: const OutlineInputBorder(),
                                          labelText:
                                              contactProcheController.text ==
                                                      contactProche
                                                  ? "Contact d'un Proche"
                                                  : contactProche,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        h(10),
                        const Text(
                          "Statut",
                          style: TextStyle(
                              fontFamily: 'bold',
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 17),
                        ),
                        h(5),
                        SizedBox(
                          height: 70,
                          width: MediaQuery.of(context).size.width / 1.3,
                          child: Form(
                            key: _formKey3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        final RenderBox container =
                                            _containerKey4
                                                    .currentContext
                                                    ?.findRenderObject()
                                                as RenderBox;
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
                                                setState(() {
                                                  statut = "Salarié";
                                                });
                                              },
                                              value: 2,
                                              child: Text('Salarié'),
                                            ),
                                            PopupMenuItem(
                                              onTap: () {
                                                setState(() {
                                                  statut = "Superviseur";
                                                });
                                              },
                                              value: 3,
                                              child: Text('Superviseur'),
                                            ),
                                            PopupMenuItem(
                                              onTap: () {
                                                setState(() {
                                                  statut = "Gestionnaire";
                                                });
                                              },
                                              value: 3,
                                              child: Text('Gestionnaire'),
                                            ),
                                            PopupMenuItem(
                                              onTap: () {
                                                setState(() {
                                                  statut = "Administrateur";
                                                });
                                              },
                                              value: 3,
                                              child: Text('Administrateur'),
                                            ),
                                          ],
                                          elevation:
                                              8.0, // Adjust the elevation for the box shadow
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 10,
                                            bottom: 10),
                                        width: 300,
                                        height: 45,
                                        key: _containerKey4,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.black26)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              statut == "" ? niveau : statut,
                                              style: const TextStyle(
                                                  fontFamily: 'normal',
                                                  fontSize: 14,
                                                  color: Colors.black45),
                                            ),
                                            const Icon(
                                              Icons.arrow_drop_down_rounded,
                                              color:
                                                  Color.fromARGB(154, 0, 0, 0),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: 300,
                                      child: TextFormField(
                                        controller: postController,
                                        decoration: InputDecoration(
                                          labelStyle: const TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 14,
                                              color: Colors.black45),
                                          border: const OutlineInputBorder(),
                                          labelText: postController.text == post
                                              ? "Post"
                                              : post,
                                        ),
                                        onTap: () {
                                          setState(
                                            () {
                                              postController.text = post;
                                            },
                                          );
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
                            show
                                ? const CircularProgressIndicator()
                                : InkWell(
                                    onTap: () {
                                      setState(() {
                                        update(id);
                                      });
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: mainColor2),
                                      child: const Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Modifier",
                                            style: TextStyle(
                                                fontFamily: 'normal',
                                                color: Colors.white),
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
                );
              },
            ));
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
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ajouter une pièce jointe",
                        style: TextStyle(
                            fontFamily: 'bold',
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ],
                  ),
                  h(20),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: mainColor3)),
                    width: MediaQuery.of(context).size.width / 2.4,
                    child: DropdownButton<String>(
                      underline: const Text(""),
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
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: mainColor3)),
                      width: MediaQuery.of(context).size.width / 2.4,
                      child: null),
                  h(20),
                  Text(_fileInfo),
                  ElevatedButton(
                    onPressed: _pickFile,
                    child: const Text('Import File'),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            )),
      ),
    );
  }

  bool aucun = true;
  bool salarie = false;
  bool superviseur = false;
  bool gestionnaire = false;
  bool admin = false;

  bool aucun2 = false;
  bool plus_ancien = false;
  bool moins_ancien = false;

  bool aucun3 = false;
  bool croissant = false;
  bool decroissant = false;

  Utilisateur() {
    return Column(
      children: [
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
                  color: Colors.white,
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
                          isNiveauHierachique = false;
                          niveauHierachique = "Trier par Niveau Hiérachique";
                          aucun = true;
                          salarie = false;
                          superviseur = false;
                          gestionnaire = false;
                          admin = false;
                        });
                      },
                      value: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: aucun ? mainColor : Colors.white,
                                width: 2.0),
                          ),
                        ),
                        child: Text(
                          "Aucun",
                          style: TextStyle(fontFamily: 'normal', fontSize: 13),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          isNiveauHierachique = true;
                          niveauHierachique = "Salarié";
                          aucun = false;
                          salarie = true;
                          superviseur = false;
                          gestionnaire = false;
                          admin = false;
                        });
                      },
                      value: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: salarie ? mainColor : Colors.white,
                                width: 2.0),
                          ),
                        ),
                        child: Text(
                          'Salarié',
                          style: TextStyle(fontFamily: 'normal', fontSize: 13),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          isNiveauHierachique = true;
                          niveauHierachique = "Superviseur";
                          aucun = false;
                          salarie = false;
                          superviseur = true;
                          gestionnaire = false;
                          admin = false;
                        });
                      },
                      value: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: superviseur ? mainColor : Colors.white,
                                width: 2.0),
                          ),
                        ),
                        child: Text(
                          'Superviseur',
                          style: TextStyle(fontFamily: 'normal', fontSize: 13),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          isNiveauHierachique = true;
                          niveauHierachique = "Gestionnaire";
                          aucun = false;
                          salarie = false;
                          superviseur = false;
                          gestionnaire = true;
                          admin = false;
                        });
                      },
                      value: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: gestionnaire ? mainColor : Colors.white,
                                width: 2.0),
                          ),
                        ),
                        child: Text(
                          'Gestionnaire',
                          style: TextStyle(fontFamily: 'normal', fontSize: 13),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          isNiveauHierachique = true;
                          niveauHierachique = "Administrateur";
                          aucun = false;
                          salarie = false;
                          superviseur = false;
                          gestionnaire = false;
                          admin = true;
                        });
                      },
                      value: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: admin ? mainColor : Colors.white,
                                width: 2.0),
                          ),
                        ),
                        child: Text(
                          'Administrateur',
                          style: TextStyle(fontFamily: 'normal', fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                  elevation: 8.0, // Adjust the elevation for the box shadow
                );
              },
              child: Container(
                padding: const EdgeInsets.only(
                    left: 5, right: 5, top: 10, bottom: 10),
                key: _containerKey,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black26)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      niveauHierachique == ""
                          ? "Trier par niveaux hiérarchiques"
                          : "Trier par : $niveauHierachique",
                      style: const TextStyle(
                          fontFamily: 'normal',
                          fontSize: 13,
                          color: Color.fromARGB(154, 0, 0, 0)),
                    ),
                    const Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Color.fromARGB(154, 0, 0, 0),
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
                  color: Colors.white,
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
                          isAnciennetePlus = false;
                          isAncienneteMoins = false;
                          isNiveauHierachique = false;
                          isCroissant = false;
                          isDecroissant = false;
                          aucun2 = true;
                          moins_ancien = false;
                          plus_ancien = false;
                        });
                      },
                      value: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: aucun2 ? mainColor : Colors.white,
                                width: 2.0),
                          ),
                        ),
                        child: Text(
                          "Aucun",
                          style: TextStyle(fontFamily: 'normal', fontSize: 13),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          isAnciennetePlus = false;
                          isAncienneteMoins = true;
                          isNiveauHierachique = false;
                          isCroissant = false;
                          isDecroissant = false;
                          aucun2 = false;
                          moins_ancien = false;
                          plus_ancien = true;
                        });
                      },
                      value: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: plus_ancien ? mainColor : Colors.white,
                                width: 2.0),
                          ),
                        ),
                        child: Text(
                          "Plus Ancien",
                          style: TextStyle(fontFamily: 'normal', fontSize: 13),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          isAnciennetePlus = true;
                          isAncienneteMoins = false;
                          isNiveauHierachique = false;
                          isCroissant = false;
                          isDecroissant = false;
                          aucun2 = false;
                          moins_ancien = true;
                          plus_ancien = false;
                        });
                      },
                      value: 2,
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color:
                                      moins_ancien ? mainColor : Colors.white,
                                  width: 2.0),
                            ),
                          ),
                          child: Text(
                            'Moins Ancien',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          )),
                    ),
                  ],
                  elevation: 8.0, // Adjust the elevation for the box shadow
                );
              },
              child: Container(
                padding: const EdgeInsets.only(
                    left: 5, right: 5, top: 10, bottom: 10),
                width: 185,
                key: _containerKey2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black26)),
                child: Row(
                  children: [
                    Text(
                      anciennete == "" ? "Trier par Ancienneté" : anciennete,
                      style: const TextStyle(
                          fontFamily: 'normal',
                          fontSize: 12,
                          color: Color.fromARGB(154, 0, 0, 0)),
                    ),
                    const Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Color.fromARGB(154, 0, 0, 0),
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
                  color: Colors.white,
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
                          isAnciennetePlus = false;
                          isAncienneteMoins = false;
                          isNiveauHierachique = false;
                          isCroissant = false;
                          isDecroissant = false;
                          alpha = "";
                          aucun3 = true;
                          croissant = false;
                          decroissant = false;
                        });
                      },
                      value: 2,
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: aucun3 ? mainColor : Colors.white,
                                  width: 2.0),
                            ),
                          ),
                          child: Text(
                            'Aucun',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          )),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          isAnciennetePlus = false;
                          isAncienneteMoins = false;
                          isNiveauHierachique = false;
                          isCroissant = true;
                          isDecroissant = false;
                          alpha = "Trier par ordre Croissant";
                          aucun3 = false;
                          croissant = true;
                          decroissant = false;
                        });
                      },
                      value: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: croissant ? mainColor : Colors.white,
                                width: 2.0),
                          ),
                        ),
                        child: Text(
                          "Trier par ordre Croissant",
                          style: TextStyle(fontFamily: 'normal', fontSize: 13),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          isAnciennetePlus = false;
                          isAncienneteMoins = false;
                          isNiveauHierachique = false;
                          isCroissant = false;
                          isDecroissant = true;
                          alpha = "Trier par ordre DéCroissant";
                          aucun3 = false;
                          croissant = false;
                          decroissant = true;
                        });
                      },
                      value: 2,
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: decroissant ? mainColor : Colors.white,
                                  width: 2.0),
                            ),
                          ),
                          child: Text(
                            'Trier par ordre DéCroissant',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          )),
                    ),
                  ],
                  elevation: 8.0, // Adjust the elevation for the box shadow
                );
              },
              child: Container(
                padding: const EdgeInsets.only(
                    left: 5, right: 5, top: 10, bottom: 10),
                width: 220,
                key: _containerKey3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black26)),
                child: Row(
                  children: [
                    Text(
                      alpha == "" ? "Trier par Ordre Alphabétique" : alpha,
                      style: const TextStyle(
                          fontFamily: 'normal',
                          fontSize: 12,
                          color: Color.fromARGB(154, 0, 0, 0)),
                    ),
                    const Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Color.fromARGB(154, 0, 0, 0),
                    )
                  ],
                ),
              ),
            ),
            w(50),
          ],
        ),
        h(40),

        /* here */
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: isAnciennetePlus
                ? getSalaryPlusAncien()
                : isAncienneteMoins
                    ? getSalaryMoinsAncien()
                    : isNiveauHierachique
                        ? getSalaryByNiveau()
                        : isCroissant
                            ? getSalaryAlphaCroissant()
                            : isDecroissant
                                ? getSalaryAlphaDecroissant()
                                : getSalary(),
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
                            size: 100,
                            color: mainColor,
                          ),
                          h(20),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: const Text(
                              "Oups, Vous n'avez aucun employé pour l'instant ",
                              style: TextStyle(fontSize: 17),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return BoxUser(
                              "${snapshot.data![index]['nom']}",
                              "${snapshot.data![index]['prenom']}",
                              "${snapshot.data![index]['post']}",
                              "${snapshot.data![index]['dateEmbauche']}",
                              "${snapshot.data![index]['groupeSanguin']}",
                              "${snapshot.data![index]['email']}",
                              "${snapshot.data![index]['tel']}",
                              "assets/images/ange.jpg",
                              "${snapshot.data![index]['dateNaissance']}",
                              "${snapshot.data![index]['contactProche']}",
                              "${snapshot.data![index]['niveauHierachique']}",
                              "${snapshot.data![index]['salaireBase']}",
                              "${snapshot.data![index]['quartier']}",
                              "${snapshot.data![index]['ville']}",
                              "${snapshot.data![index]['groupeSanguin']}",
                              "${snapshot.data![index]['cv']}",
                              "${snapshot.data![index]['contrat']}",
                              "${snapshot.data![index]['certificat']}",
                              "${snapshot.data![index]['fiche']}",
                              "${snapshot.data![index]['salaireBrute']}",
                              int.parse("${snapshot.data![index]['id']}")
                              /* 
                            ,
                            ,
                             */
                              /* index,
                            int.parse("${snapshot.data![index]['id']}"),
                            snapshot.data![index]['cv'] == null
                                ? ""
                                : "${snapshot.data![index]['cv']}",
                            snapshot.data![index]['contrat'] == null
                                ? ""
                                : "${snapshot.data![index]['contrat']}",
                            snapshot.data![index]['certificat'] == null
                                ? ""
                                : "${snapshot.data![index]['certificat']}",
                            snapshot.data![index]['fiche'] == null
                                ? ""
                                : "${snapshot.data![index]['fiche']}" */
                              );
                        });
              }
              return Center(
                  child: SizedBox(
                      height: 150,
                      width: 150,
                      child: Lottie.asset("assets/images/anim.json")));
            },
          ),
        ),
      ],
    );
  }

  BoxUser(
      String nom,
      prenom,
      post,
      dateEmbauche,
      groupeS,
      mail,
      phone,
      path,
      dateNaissance,
      contactProche,
      niveauHierachique,
      salaireBase,
      quartier,
      ville,
      groupeSanguin,
      cv,
      contrat,
      certificat,
      fiche,
      salaireBrut,
      int id) {
    return Card(
      elevation: 14,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Container(
        padding: const EdgeInsets.all(5),
        height: 500,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => StatefulBuilder(
                            builder: (context, setState) => AlertDialog(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                content: Container(
                                  padding: const EdgeInsets.all(20),
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Ajouter une pièce jointe",
                                            style: TextStyle(
                                                fontFamily: 'bold',
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      h(20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Type de document : ",
                                            style: TextStyle(
                                              fontFamily: 'bold',
                                              color: Colors.black,
                                            ),
                                          ),
                                          h(20),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                    color: mainColor3)),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.4,
                                            child: DropdownButton<String>(
                                              underline: const Text(""),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              isExpanded: true,
                                              value: _selectedValue,
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _selectedValue = newValue!;
                                                  print(
                                                      "********************************$_selectedValue");
                                                });
                                              },
                                              items: _options.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      h(20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Importation du document ",
                                            style: TextStyle(
                                              fontFamily: 'bold',
                                              color: Colors.black,
                                            ),
                                          ),
                                          h(20),
                                          InkWell(
                                            onTap: () async {
                                              result = await FilePicker.platform
                                                  .pickFiles(
                                                type: FileType.custom,
                                                onFileLoading: (status) =>
                                                    print(status),
                                                allowedExtensions: [
                                                  'pdf',
                                                  'jpg',
                                                  'png',
                                                  'docx'
                                                ],
                                              );
                                              if (result != null &&
                                                  result.files.isNotEmpty) {
                                                final fileName =
                                                    result.files.single.name;
                                                setState(() {
                                                  fileName_ = fileName;
                                                  print(fileName_);
                                                });
                                              } else {
                                                print(
                                                    'Aucun fichier sélectionné');
                                              }
                                            },
                                            child: Container(
                                                height: 50,
                                                padding: const EdgeInsets.only(
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
                                                    Icon(
                                                      Icons.file_present_sharp,
                                                      color: mainColor2,
                                                    ),
                                                    w(15),
                                                    Text(
                                                      fileName_ == ""
                                                          ? "Cliquez ici pour importer le fichier"
                                                          : fileName_,
                                                      style: TextStyle(
                                                          color: mainColor2,
                                                          fontFamily: 'normal'),
                                                    )
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                      h(40),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(
                                                () {
                                                  if (_selectedValue == "" ||
                                                      fileName_ == "") {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                backgroundColor:
                                                                    Color
                                                                        .fromARGB(
                                                                            255,
                                                                            133,
                                                                            24,
                                                                            18),
                                                                content: Text(
                                                                  "Veuillez remplir toutes les cases",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'normal',
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                )));
                                                  } else {
                                                    setState(
                                                      () {
                                                        print(fileName_);
                                                        uploadFileToServer(nom);
                                                        _selectedValue == "CV"
                                                            ? updateCV(id,
                                                                "https://zoutechhub.com/pharmaRh/uploads/$nom/$fileName_")
                                                            : _selectedValue ==
                                                                    "Contrats"
                                                                ? updateContrat(id,
                                                                    "https://zoutechhub.com/pharmaRh/uploads/$nom/$fileName_")
                                                                : _selectedValue ==
                                                                        "Certiﬁcats"
                                                                    ? updateCertificat(
                                                                        id,
                                                                        "https://zoutechhub.com/pharmaRh/uploads/$nom/$fileName_")
                                                                    : _selectedValue ==
                                                                            "Fiches d’évaluation finale"
                                                                        ? updateFiche(
                                                                            id,
                                                                            "https://zoutechhub.com/pharmaRh/uploads/$nom/$fileName_")
                                                                        : null;
                                                      },
                                                    );
                                                  }
                                                },
                                              );
                                            },
                                            child: show
                                                ? const CircularProgressIndicator()
                                                : Container(
                                                    height: 40,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 25,
                                                            right: 25),
                                                    decoration: BoxDecoration(
                                                        color: mainColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13)),
                                                    child: const Center(
                                                      child: Text(
                                                        "Ajouter",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'normal'),
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                          w(20),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              height: 40,
                                              padding: const EdgeInsets.only(
                                                  left: 25, right: 25),
                                              decoration: BoxDecoration(
                                                  color: mainColor3,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          13)),
                                              child: const Center(
                                                child: Text(
                                                  "Fermer",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'normal'),
                                                ),
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
                      child: CircleAvatar(
                        backgroundColor: mainColor,
                        radius: 15,
                        child: const Center(
                          child: Icon(
                            Icons.upload_file,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(
                          () {
                            nomController.text = nom;
                            prenomController.text = prenom;
                            villeController.text = ville;
                            quartierController.text = quartier;
                            emailController.text = mail;
                            telController.text = phone;
                            postController.text = post;
                            groupeSanguinController.text = groupeSanguin;
                            contactProcheController.text = contactProche;
                            formattedDate1 = dateNaissance;
                            formattedDate2 = dateEmbauche;
                            statut = niveauHierachique;
                            print("$formattedDate1------ $formattedDate2");
                          },
                        );
                        modifySalarie(
                            prenom,
                            nom,
                            dateNaissance,
                            dateEmbauche,
                            ville,
                            quartier,
                            mail,
                            phone,
                            groupeSanguin,
                            contactProche,
                            niveauHierachique,
                            post,
                            id);
                      },
                      child: CircleAvatar(
                        backgroundColor: mainColor3,
                        radius: 15,
                        child: const Center(
                          child: Icon(
                            Icons.pan_tool_alt_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    w(5),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserProfile(
                                name: prenom + " " + nom,
                                post: post,
                                dateNaissance: dateNaissance,
                                mail: mail,
                                phone: phone,
                                dateEmbauche: dateEmbauche,
                                contactProche: contactProche,
                                groupeSanguin: groupeSanguin,
                                niveauHierachique: niveauHierachique,
                                quartier: quartier,
                                salaireBase: salaireBase,
                                ville: ville,
                                cv: cv,
                                contrat: contrat,
                                certificat: certificat,
                                fiche: fiche,
                                id: id,
                                archiver: archiver(id),
                                salaireBrute: salaireBrut,
                              ),
                            ));
                      },
                      child: CircleAvatar(
                        backgroundColor: mainColor2,
                        radius: 15,
                        child: const Center(
                          child: Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100), color: mainColor2
                  /* image: DecorationImage(
                      image: AssetImage(path), fit: BoxFit.cover) */
                  ),
              child: const Center(
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            /* CircleAvatar(
            radius: 40,
            backgroundColor: mainColor,
            child: Center(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 40,
              ),
            ),
          ), */
            h(5),
            Text(
              prenom + " " + nom,
              style: const TextStyle(fontFamily: 'bold'),
            ),
            Text(
              post,
              style: const TextStyle(
                  fontFamily: 'normal', color: Color.fromARGB(127, 0, 0, 0)),
            ),
            h(5),
            Container(
              padding: const EdgeInsets.all(10),
              width: 270,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 15,
                            color: mainColor,
                          ),
                          w(5),
                          const Text(
                            "Date d'embauche : ",
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            dateEmbauche,
                            style: const TextStyle(
                                fontFamily: 'bold', fontSize: 13),
                          )
                        ],
                      )
                    ],
                  ),
                  h(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.bloodtype,
                            size: 15,
                            color: mainColor,
                          ),
                          w(5),
                          const Text(
                            "Groupe sanguin  : ",
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            groupeS,
                            style: const TextStyle(
                                fontFamily: 'bold', fontSize: 13),
                          )
                        ],
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.mail,
                            size: 15,
                            color: mainColor,
                          ),
                          w(5),
                          Text(
                            mail,
                            style: const TextStyle(
                                fontFamily: 'normal', fontSize: 13),
                          )
                        ],
                      ),
                    ],
                  ),
                  h(3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 15,
                            color: mainColor,
                          ),
                          w(5),
                          Text(
                            phone,
                            style: const TextStyle(
                                fontFamily: 'normal', fontSize: 13),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  UtilisateurArchivied() {
    return Column(
      children: [
        /*  Row(
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
        */
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
              color: mainColor3, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              SizedBox(
                width: 240,
                height: 50,
                child: const Center(
                  child: Text(
                    "Nom et Prénoms",
                    style: TextStyle(fontFamily: 'bold', fontSize: 13),
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
                child: const Center(
                  child: Text(
                    "Niveau Hiérachique",
                    style: TextStyle(fontFamily: 'bold', fontSize: 13),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 3,
                color: Colors.white54,
              ),
              SizedBox(
                width: 250,
                height: 50,
                child: const Center(
                  child: Text(
                    "Email",
                    style: TextStyle(fontFamily: 'bold', fontSize: 13),
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
                child: const Center(
                  child: Text(
                    "Numéro de Tel",
                    style: TextStyle(fontFamily: 'bold', fontSize: 13),
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
                child: const Center(
                  child: Text(
                    "Date de Naissance",
                    style: TextStyle(fontFamily: 'bold', fontSize: 13),
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
                child: const Center(
                  child: Text(
                    "Date Embauche",
                    style: TextStyle(fontFamily: 'bold', fontSize: 13),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 3,
                color: Colors.white54,
              ),
              SizedBox(
                width: 110,
                height: 50,
                child: const Center(
                  child: Text(
                    "Action",
                    style: TextStyle(fontFamily: 'bold', fontSize: 13),
                  ),
                ),
              )
            ],
          ),
        ),
        h(10),
        /* here */
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: getSalaryArchived(),
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
                            size: 100,
                            color: mainColor,
                          ),
                          h(20),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: const Text(
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
                          return BoxSalary(
                            "${snapshot.data![index]['prenom']}",
                            "${snapshot.data![index]['nom']}",
                            "${snapshot.data![index]['dateNaissance']}",
                            "${snapshot.data![index]['dateEmbauche']}",
                            "${snapshot.data![index]['ville']}",
                            "${snapshot.data![index]['quartier']}",
                            "${snapshot.data![index]['email']}",
                            "${snapshot.data![index]['tel']}",
                            "${snapshot.data![index]['groupeSanguin']}",
                            "${snapshot.data![index]['contactProche']}",
                            "${snapshot.data![index]['niveauHierachique']}",
                            "${snapshot.data![index]['post']}",
                            index,
                            int.parse("${snapshot.data![index]['id']}"),
                            snapshot.data![index]['cv'] == null
                                ? ""
                                : "${snapshot.data![index]['cv']}",
                            snapshot.data![index]['contrat'] == null
                                ? ""
                                : "${snapshot.data![index]['contrat']}",
                            snapshot.data![index]['certificat'] == null
                                ? ""
                                : "${snapshot.data![index]['certificat']}",
                            snapshot.data![index]['fiche'] == null
                                ? ""
                                : "${snapshot.data![index]['fiche']}",
                          );
                        });
              }
              return Center(
                  child: SizedBox(
                      height: 150,
                      width: 150,
                      child: Lottie.asset("assets/images/anim.json")));
            },
          ),
        ),
        const Divider(),
        Text(_fileInfo)
      ],
    );
  }
}
