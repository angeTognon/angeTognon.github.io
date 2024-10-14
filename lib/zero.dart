import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zth_app/interfaceEmploy%C3%A9/home_employe.dart';
import 'package:zth_app/main.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late RTCVideoRenderer _renderer;

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

  html.VideoElement? _videoElement;

  Future<void> _takePicture() async {
    setState(() {
      show = true;
    });

    try {
      final canvas = html.CanvasElement(width: 640, height: 480);
      final context = canvas.getContext('2d') as html.CanvasRenderingContext2D;

      if (_videoElement != null) {
        // Draw the video frame into the canvas using drawImageToRect
        context.drawImageToRect(
          _videoElement!,
          const html.Rectangle(0, 0, 640, 480),
        );

        // Wait a moment before capturing the image
        await Future.delayed(const Duration(milliseconds: 100));

        await _uploadImage(canvas);
      } else {
        print('Video element is not initialized.');
      }
    } catch (e) {
      print('Erreur lors de la prise de photo : $e');
    }
  }

  Future<void> _uploadImage(html.CanvasElement canvas) async {
    final dataUrl = canvas.toDataUrl('image/jpeg');
    final bytes = dataUrl.split(',')[1];
    final byteData = base64Decode(bytes);

    await _uploadImageToServer(byteData);
  }

  Future<void> _uploadImageToServer(Uint8List bytes) async {
    try {
      var uri = Uri.parse(
          'https://zoutechhub.com/pharmaRh/presencePhoto.php?email=$user_email');
      var request = http.MultipartRequest('POST', uri);
      request.files.add(
          http.MultipartFile.fromBytes('image', bytes, filename: 'image.jpg'));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        var responseJson = jsonDecode(responseString);

        print('Réponse du serveur: $responseString');
        if (responseJson['success']) {
          setState(() {
            linked = "https://zoutechhub.com/pharmaRh/uploads/$user_email.jpg"
                .replaceAll(".com", "");
          });
          inscription(linked);
          // Affiche "ok" si success est true
          // Appelle ta méthode inscription ou autre ici
        } else {
          print('Erreur lors du téléchargement : ${responseJson['message']}');
        }
      } else {
        print('Erreur lors du téléchargement : ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Erreur lors de l\'envoi de l\'image : $error');
    }
  }

  Future<void> _takePicture2() async {
    setState(() {
      show = true;
    });

    try {
      final canvas = html.CanvasElement(width: 640, height: 480);
      final context = canvas.getContext('2d') as html.CanvasRenderingContext2D;

      if (_videoElement != null) {
        // Draw the video frame into the canvas using drawImageToRect
        context.drawImageToRect(
          _videoElement!,
          const html.Rectangle(0, 0, 640, 480),
        );

        // Wait a moment before capturing the image
        await Future.delayed(const Duration(milliseconds: 100));

        await _uploadImage2(canvas);
      } else {
        print('Video element is not initialized.');
      }
    } catch (e) {
      print('Erreur lors de la prise de photo : $e');
    }
  }

  Future<void> _uploadImage2(html.CanvasElement canvas) async {
    final dataUrl = canvas.toDataUrl('image/jpeg');
    final bytes = dataUrl.split(',')[1];
    final byteData = base64Decode(bytes);

    await _uploadImageToServer2(byteData);
  }

  Future<void> _uploadImageToServer2(Uint8List bytes) async {
    try {
      var uri = Uri.parse(
          'https://zoutechhub.com/pharmaRh/presencePhoto.php?email=$user_email');
      var request = http.MultipartRequest('POST', uri);
      request.files.add(
          http.MultipartFile.fromBytes('image', bytes, filename: 'image.jpg'));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        var responseJson = jsonDecode(responseString);

        print('Réponse du serveur: $responseString');
        if (responseJson['success']) {
          setState(() {
            linked = "https://zoutechhub.com/pharmaRh/uploads/$user_email.jpg"
                .replaceAll(".com", "");
          });
          ajoutHeureFin(linked);
          // Affiche "ok" si success est true
          // Appelle ta méthode inscription ou autre ici
        } else {
          print('Erreur lors du téléchargement : ${responseJson['message']}');
        }
      } else {
        print('Erreur lors du téléchargement : ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Erreur lors de l\'envoi de l\'image : $error');
    }
  }

  bool show = false;
  String linked = "";
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

  void _showAlertDialog() {
    Future.delayed(Duration.zero, () {
      showDialog<void>(
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height,
                  width: (MediaQuery.of(context).size.width * 7) / 12,
                  decoration: BoxDecoration(color: mainColor2),
                  child: Column(
                    children: [
                      Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1000),
                            image: const DecorationImage(
                                image: AssetImage("assets/images/ange.jpg"),
                                fit: BoxFit.cover)),
                      ),
                      h(30),
                      const Text(
                        "Heureux de vous revoir !",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'bold'),
                      ),
                      Text(
                        "${DateTime.now().hour} : ${DateTime.now().minute}",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 80,
                            fontFamily: 'bold'),
                      ),
                      Text(
                        "${DateTime.now().day} / ${DateTime.now().month} /${DateTime.now().year}",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16,
                            fontFamily: 'normal'),
                      ),
                      h(50),
                      const Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 50,
                      ),
                      h(40),
                      const Text(
                        "PharmaRh",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16,
                            fontFamily: 'bold'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: (MediaQuery.of(context).size.width * 5) / 12,
                  child: ScreenLock(
                    useBlur: false,
                    cancelButton: Icon(Icons.close, color: mainColor),
                    deleteButton: Icon(
                      Icons.arrow_back,
                      color: mainColor,
                    ),
                    title: const Text(
                      "Veuillez entrer votre code Secret pour\npointer votre heure de Présence ou Sortie",
                      style: TextStyle(fontFamily: 'normal', fontSize: 20),
                    ),
                    onError: (value) => ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(
                            backgroundColor: Color.fromARGB(255, 135, 31, 23),
                            content: Text(
                              "Mauvais mots de passse. Veuillez ressayer svp",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'normal'),
                            ))),
                    config: ScreenLockConfig(
                        titleTextStyle: const TextStyle(color: Colors.black),
                        textStyle: const TextStyle(color: Colors.black),
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
  void initState() {
    super.initState();
    _renderer = RTCVideoRenderer();
    _initCamera().then((_) => _showAlertDialog());
  }

  Future<void> _initCamera() async {
    final mediaStream = await html.window.navigator.getUserMedia(video: true);
    _videoElement = html.VideoElement()
      ..srcObject = mediaStream
      ..autoplay = true;

    // Attach the video element to the DOM
    html.document.body?.append(_videoElement as html.Node);
  }

  @override
  void dispose() {
    _videoElement?.remove();
    // _renderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width * 9.9) / 12,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: dansEntreprise == true
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
                      width: 300,
                      height: 300,
                      child: RTCVideoView(
                        _renderer,
                        objectFit:
                            RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
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

 /* Future<void> _takePicture2() async {
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
 */
  /* Future<void> _uploadImageToServer(List<int> bytes) async {
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
        print('Erreur lors du téléchargement : ${await response.reasonPhrase}');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

 */