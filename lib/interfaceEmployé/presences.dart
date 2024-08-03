import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
class PresencesEmploye extends StatefulWidget {
  const PresencesEmploye({super.key});

  @override
  State<PresencesEmploye> createState() => _PresencesEmployeState();
}

class _PresencesEmployeState extends State<PresencesEmploye> {

    Position? _currentPosition;
  double targetLatitude = 9.35798;
  double targetLongitude = 2.63429;
  double radius = 10.0; // 10 mètres
  bool dansEntreprise=false;

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
        dansEntreprise=true;
      });
      

    } else {
      setState(() {
        dansEntreprise=false;
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
  
  
  @override
  void initState() {
    super.initState();
    _showAlertDialog();
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
                  padding: EdgeInsets.all(50),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    color: mainColor__,
                  ),
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
                        "Bonjour  Ange !",
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
                  width: MediaQuery.of(context).size.width / 2,
                  child: ScreenLock(
                    useBlur: false,
                    cancelButton: Icon(
                      Icons.close,
                      color: mainColor
                    ),
                    deleteButton: Icon(
                      Icons.arrow_back,
                      color: mainColor,
                    ),
                    title: Text(
                        "Veuillez entrer votre code Secret pour\npointer votre heure de Présence ou Sortie"),
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
                    correctString: '1234',
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
  Widget build(BuildContext context) {
    return Container(
      /* dansEntreprise */
      height: MediaQuery.of(context).size.height,
       width: (MediaQuery.of(context).size.width * 13.5) / 16,
       padding: EdgeInsets.all(30),
       child: Center(
        child: Container(
          height: 600,width: 500,child: Column(
            children: [
              Text("Vous n'est pas dans l'entreprise actuellement",style: TextStyle(
                fontFamily: 'bold',fontSize: 20,color: mainColor
              ),textAlign: TextAlign.center,),
              h(30),
              Image.asset("assets/images/oups.jpg"),
              h(15),
              Text("Vous ne pouvez pas pointer votre présence",style: TextStyle(
                fontFamily: 'bold',fontSize: 17,color: mainColor
              ),textAlign: TextAlign.center,),
            ],
          ),
        ),
       ),
    );
  }
}
