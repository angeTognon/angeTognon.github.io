import 'dart:convert';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zth_app/interfaceAdmin/home.dart';
import 'package:zth_app/interfaceAdmin/menu/connexion/login.dart';
import 'package:zth_app/interfaceEmploy%C3%A9/home_employe.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

import 'package:zth_app/zero.dart';

bool isFirstRun = false;
bool isFirstCall = false;
late List<CameraDescription> _cameras;

Future<void> initializeCameras() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
}

String currentUserId = "";
bool eya = false;
bool eyaEmploye = false;
bool clientC = false;
bool etatCompte = false;
String currentUserEmail = "";
String userName = "";
String imagPath = "";
String user_email = "";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefss = await SharedPreferences.getInstance();
  final isClient = prefss.getBool('isClient') ?? false;

  final prefsss = await SharedPreferences.getInstance();
  final isActivated = prefsss.getBool('isActivated') ?? false;

  final prefs = await SharedPreferences.getInstance();
  final isConnected = prefs.getBool('isConnected') ?? false;

  final prefs2 = await SharedPreferences.getInstance();
  final isConnected2 = prefs.getBool('isConnected2') ?? false;

  final userPref = await SharedPreferences.getInstance();
  user_email = userPref.getString('email') ?? "";

  final userNamePref = await SharedPreferences.getInstance();
  userName = userNamePref.getString('userName') ?? "";
  print("isConnected????");

  eya = isConnected;
  print(isConnected);
  eyaEmploye = isConnected2;
  clientC = isClient;
  etatCompte = isActivated;

  runApp(Phoenix(child: MyApp(isConnected: isConnected)));
}

class MyApp extends StatefulWidget with WidgetsBindingObserver {
  final isConnected;
  MyApp({super.key, required this.isConnected});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _getUserName();
    print("***************dsdsds**********$user_name");
  }

  Future<void> _getUserName() async {
    final salary = await getSalary();
    if (salary.isNotEmpty) {
      setState(() {
        user_name = "${salary[0]['prenom']} ${salary[0]['nom']}";
        print("***************d**********$user_name");
      });
    } else {
      print("vide");
    }
  }

  getSalary() async {
    var url = "https://zoutechhub.com/pharmaRh/getU.php?email=$user_email";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  Future<void> _loadThemeFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  Future<void> _saveThemeToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _isDarkMode);
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    _saveThemeToPreferences();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: mainColor,
          ),
          useMaterial3: true,
        ),
        //home: Zero());
        home: eya == true && eyaEmploye == false
            ? const Home()
            : eya == false && eyaEmploye == true
                ? const HomeEmploye()
                : const Login());
    // home: eya ? Home() : eyaEmploye ? HomeEmploye() : Login());
  }
}

class PresencesEmploye extends StatefulWidget {
  const PresencesEmploye({super.key});

  @override
  _PresencesEmployeState createState() => _PresencesEmployeState();
}

class _PresencesEmployeState extends State<PresencesEmploye> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // Obtenir la liste des caméras disponibles
    availableCameras().then((cameras) {
      // Choisir la première caméra
      _controller = CameraController(
        cameras.first,
        ResolutionPreset.high,
      );
      _initializeControllerFuture = _controller.initialize();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /* late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  Future<void> _initializeCamerasx() async {
    _cameras = await availableCameras();
    // Vérifiez si des caméras sont disponibles
    if (_cameras.isEmpty) {
      print("Aucune caméra disponible");
    } else {
      _showAlertDialog();
      _controller = CameraController(
        _cameras.first,
        ResolutionPreset.medium,
      );
      _initializeControllerFuture = _controller.initialize();
      _initializeControllerFuture.then((_) {
        print("ok");
      }).catchError((error) {
        print("Erreur lors de l'initialisation : $error");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeCamerasx();
/*  */
    //_showAlertDialog();

    /* // Initialiser le contrôleur de la caméra
    _controller = CameraController(
      // Utiliser la première caméra disponible
      _cameras.first,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
    print("ok"); */
  }

  void _showAlertDialog() {
    Future.delayed(Duration.zero, () {
      showDialog<void>(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height,
                  width: (MediaQuery.of(context).size.width * 12) / 16,
                  decoration: BoxDecoration(color: mainColor),
                  child: Column(
                    children: [
                      Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1000),
                            image: DecorationImage(
                                image: AssetImage("assets/images/ange.jpg"),
                                fit: BoxFit.cover)),
                      ),
                      h(30),
                      Text(
                        "Bonjour  !",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'bold'),
                      ),
                      Text(
                        "${DateTime.now().hour} : ${DateTime.now().minute}",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 80,
                            fontFamily: 'bold'),
                      ),
                      Text(
                        "${DateTime.now().day} / ${DateTime.now().month} /${DateTime.now().year}",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16,
                            fontFamily: 'normal'),
                      ),
                      h(50),
                      Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 50,
                      ),
                      h(40),
                      Text(
                        "PharmaRh",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16,
                            fontFamily: 'bold'),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 4,
                  child: ScreenLock(
                    useBlur: false,
                    cancelButton: Icon(Icons.close, color: mainColor),
                    deleteButton: Icon(
                      Icons.arrow_back,
                      color: mainColor,
                    ),
                    title: Text(
                      "Veuillez entrer votre code Secret pour\npointer votre heure de Présence ou Sortie",
                      style: TextStyle(fontFamily: 'normal', fontSize: 20),
                    ),
                    onError: (value) =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Color.fromARGB(255, 135, 31, 23),
                            content: Text(
                              "Mauvais mots de passse. Veuillez ressayer svp",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'normal'),
                            ))),
                    config: ScreenLockConfig(
                        titleTextStyle: TextStyle(color: Colors.black),
                        textStyle: TextStyle(color: Colors.black),
                        buttonStyle: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        )),
                    secretsConfig: SecretsConfig(
                        secretConfig: SecretConfig(
                            disabledColor: Colors.grey,
                            enabledColor: mainColor)),
                    correctString: '4444',
                    onCancelled: () {
                      Navigator.of(context).pop();
                      _getCurrentLocation();
                    },
                    onUnlocked: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          );
        },
      );
    });
  }

  @override
  void dispose() {
    // Libérer les ressources de la caméra lors de la destruction du widget
    _controller.dispose();
    super.dispose();
  }
 */
  Position? _currentPosition;
  double targetLatitude = 9.35798;
  double targetLongitude = 2.63429;
  double radius = 10.0; // 10 mètres
  bool dansEntreprise = false;

  _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;
    });

    // Vérifier si l'utilisateur est dans le rayon
    if (_isWithinRadius(position.latitude, position.longitude)) {
      print('L\'utilisateur est dans le rayon de 10 mètres');
      setState(() {
        dansEntreprise = true;
      });
    } else {
      setState(() {
        dansEntreprise = false;
      });

      print('L\'utilisateur est en dehors du rayon de 10 mètres');
    }
  }

  bool _isWithinRadius(double latitude, double longitude) {
    double distance = _calculateDistance(
        latitude, longitude, targetLatitude, targetLongitude);
    return distance <= radius;
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    double p = 0.017453292519943295;
    double a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<void> _takePicture() async {
    setState(() {
      show = true;
    });
    try {
      await _initializeControllerFuture;
      final XFile image = await _controller.takePicture();
      final bytes = await image.readAsBytes();
      await _uploadImageToServer(bytes);
    } catch (e) {
      print('Erreur lors de la prise de photo : $e');
    }
  }

  Future<void> _takePicture2() async {
    setState(() {
      show = true;
    });
    try {
      await _initializeControllerFuture;
      final XFile image = await _controller.takePicture();
      final bytes = await image.readAsBytes();
      await _uploadImageToServer2(bytes);
    } catch (e) {
      print('Erreur lors de la prise de photo : $e');
    }
  }

  Future<void> _uploadImageToServer(List<int> bytes) async {
    try {
      var uri = Uri.parse(
          'https://zoutechhub.com/pharmaRh/presencePhoto.php?email=$user_email');
      var request = http.MultipartRequest('POST', uri);
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        bytes,
        filename: 'image.jpg',
      ));

      var response = await request.send();
      print("**********************************");
      print("Request sent successfully. Status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        var responseJson = jsonDecode(responseString);

        if (responseJson['success']) {
          print('Image téléchargée avec succès');
          inscription(
              "https://zoutechhub.com/pharmaRh/uploads/$user_email.jpg");
        } else {
          print('Erreur lors du téléchargement : ${responseJson['message']}');
        }
      } else {
        print('Erreur lors du téléchargement : ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  Future<void> _uploadImageToServer2(List<int> bytes) async {
    try {
      var uri = Uri.parse(
          'https://zoutechhub.com/pharmaRh/presencePhoto.php?email=$user_email');
      var request = http.MultipartRequest('POST', uri);
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        bytes,
        filename: 'image.jpg',
      ));

      var response = await request.send();
      print("**********************************");
      print("Request sent successfully. Status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        var responseJson = jsonDecode(responseString);

        if (responseJson['success']) {
          print('Image téléchargée avec succès');
          ajoutHeureFin(
              "https://zoutechhub.com/pharmaRh/uploads/${user_email}fin.jpg");
        } else {
          print('Erreur lors du téléchargement : ${responseJson['message']}');
        }
      } else {
        print('Erreur lors du téléchargement : ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  bool show = false;
  inscription(String linkPhoto) async {
    // EncryptData(mpController.text);
    var url =
        "https://zoutechhub.com/pharmaRh/addPresence.php?email=$user_email&datePresence=${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}&heureArrive=${DateTime.now().hour} : ${DateTime.now().minute}&heureFin=${DateTime.now().hour} : ${DateTime.now().minute}&linkPhoto=$linkPhoto";
    var response = await http.post(Uri.parse(url));
    print(response.body);
    if (response.body == "OK") {
      setState(() {
        show = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 18, 133, 22),
          content: Text(
            "Pointage Réussie",
            style: TextStyle(
                fontFamily: 'normal',
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeEmploye(),
        ),
      );
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

  ajoutHeureFin(String linkPhoto) async {
    // EncryptData(mpController.text);
    var url =
        "https://zoutechhub.com/pharmaRh/updatePresence.php?email=$user_email&heureFin=${DateTime.now().hour} : ${DateTime.now().minute}&dd=${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    var response = await http.post(Uri.parse(url));
    print(response.body);
    if (response.body == "OK") {
      setState(() {
        show = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 18, 133, 22),
          content: Text(
            "Pointage Réussie",
            style: TextStyle(
                fontFamily: 'normal',
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeEmploye(),
        ),
      );
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: (MediaQuery.of(context).size.width * 13.5) / 16,
      padding: const EdgeInsets.all(30),
      child: Center(
        child: dansEntreprise
            ? SizedBox(
                height: 600,
                width: 500,
                child: Column(
                  children: [
                    Text(
                      "Vous n'est pas dans l'entreprise actuellement",
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 20, color: mainColor),
                      textAlign: TextAlign.center,
                    ),
                    h(30),
                    Image.asset("assets/images/oups.jpg"),
                    h(15),
                    Text(
                      "Vous ne pouvez pas pointer votre présence",
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 17, color: mainColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : SizedBox(
                height: 600,
                width: 500,
                child: Column(
                  children: [
                    Text(
                      "Vous êtes bien dans la pharmacie",
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 20, color: mainColor),
                      textAlign: TextAlign.center,
                    ),
                    h(30),
                    SizedBox(
                      height: 200,
                      child: FutureBuilder<void>(
                        future: _initializeControllerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // Si l'initialisation de la caméra est terminée, afficher le rendu
                            return CircleAvatar(
                                backgroundColor: Colors.white,
                                minRadius: 40,
                                child: CameraPreview(_controller));
                          } else {
                            // Sinon, afficher un indicateur de chargement
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                    h(20),
                    show
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: 500,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: mainColor),
                                    onPressed: () {
                                      setState(() {
                                        _takePicture();
                                      });
                                    },
                                    child: const Text(
                                      "Point mon heure d'arrivée",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'normal'),
                                    )),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: mainColor),
                                    onPressed: () {
                                      setState(() {
                                        _takePicture2();
                                      });
                                    },
                                    child: const Text(
                                      "Point mon heure de Sortie",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'normal'),
                                    )),
                              ],
                            ),
                          ),
                    h(15),
                  ],
                ),
              ),
      ),
    );
  }
}
