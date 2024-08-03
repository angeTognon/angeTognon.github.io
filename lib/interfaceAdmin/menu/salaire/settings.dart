// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:zth_app/widgets/wid_var.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final GlobalKey _containerKey = GlobalKey();
  final GlobalKey _containerKey2 = GlobalKey();
  TextEditingController montantController = TextEditingController();
  TextEditingController montantAvanceController = TextEditingController();
  int count = 0;

  DateTime _selectedDate = DateTime.now();

  bool darkMode = false;
  bool anglais = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(30),
        height: MediaQuery.of(context).size.height,
        width: (MediaQuery.of(context).size.width * 13.5) / 16,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Paramètre",
                style: TextStyle(
                    fontFamily: 'bold', fontSize: 23, color: mainColor),
              ),
              h(20),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  "Gérez vos paramètres et préférences",
                  style: TextStyle(
                      fontFamily: 'normal',
                      fontSize: 15,
                      color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              h(20),
              Divider(),
              h(20),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  "Mon Profil",
                  style: TextStyle(
                      fontFamily: 'bold', fontSize: 15, color: mainColor),
                ),
              ),
              h(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    width: (MediaQuery.of(context).size.width * 9) / 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Informations Personnelles",
                          style: TextStyle(fontFamily: 'bold'),
                        ),
                        Divider(),
                        h(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Noms Et Prénoms",
                                  style: TextStyle(
                                      fontFamily: 'bold', color: mainColor),
                                ),
                                h(15),
                                Container(
                                  width: 350,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          Border.all(color: Colors.black38)),
                                  child: Center(
                                    child: Text(
                                      "TOGNON KOFFI ANGE",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontFamily: 'bold'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                      fontFamily: 'bold', color: mainColor),
                                ),
                                h(15),
                                Container(
                                  width: 350,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          Border.all(color: Colors.black38)),
                                  child: Center(
                                    child: Text(
                                      "tognonange.koffi@gmail.com",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontFamily: 'bold'),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        h(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date de Naissance",
                                  style: TextStyle(
                                      fontFamily: 'bold', color: mainColor),
                                ),
                                h(15),
                                Container(
                                  width: 350,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          Border.all(color: Colors.black38)),
                                  child: Center(
                                    child: Text(
                                      "XX/XX/XXXX",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontFamily: 'bold'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date d'embauche",
                                  style: TextStyle(
                                      fontFamily: 'bold', color: mainColor),
                                ),
                                h(15),
                                Container(
                                  width: 350,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          Border.all(color: Colors.black38)),
                                  child: Center(
                                    child: Text(
                                      "XX/XX/XXXX",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontFamily: 'bold'),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        h(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Numéro de téléphone",
                                  style: TextStyle(
                                      fontFamily: 'bold', color: mainColor),
                                ),
                                h(15),
                                Container(
                                  width: 350,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          Border.all(color: Colors.black38)),
                                  child: Center(
                                    child: Text(
                                      "57887411",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontFamily: 'bold'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Post",
                                  style: TextStyle(
                                      fontFamily: 'bold', color: mainColor),
                                ),
                                h(15),
                                Container(
                                  width: 350,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          Border.all(color: Colors.black38)),
                                  child: Center(
                                    child: Text(
                                      "Aide Soignant",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontFamily: 'bold'),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black38)),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    width: (MediaQuery.of(context).size.width * 3.5) / 16,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black38)),
                    child: Column(
                      children: [
                        Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(300),
                              image: DecorationImage(
                                  image: AssetImage("assets/images/ange.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                        h(15),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(15),
                                backgroundColor: mainColor),
                            onPressed: () {},
                            child: Text(
                              "Changer de Photo de Profil",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'normal'),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              h(10),
              Container(
                width: (MediaQuery.of(context).size.width * 9) / 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        "Thèmes",
                        style: TextStyle(
                            fontFamily: 'bold', fontSize: 15, color: mainColor),
                      ),
                    ),
                    h(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mode Sombre : ",
                          style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        w(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Switch(
                                activeColor: mainColor,
                                onFocusChange: (value) {},
                                value: darkMode,
                                onChanged: (value) {
                                  setState(() {
                                    print("changed");
                                    darkMode = !darkMode;
                                  });
                                }),
                            w(20),
                            Text(
                              darkMode ? "Activé" : "Désactivé ",
                              style: TextStyle(
                                  fontFamily: 'bold',
                                  fontSize: 14,
                                  color: mainColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    h(10),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        "Langue",
                        style: TextStyle(
                            fontFamily: 'bold', fontSize: 15, color: mainColor),
                      ),
                    ),
                    h(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Anglais : ",
                          style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        w(20),
                        Row(
                          children: [
                            Switch(
                                activeColor: mainColor,
                                onFocusChange: (value) {},
                                value: anglais,
                                onChanged: (value) {
                                  setState(() {
                                    print("changed");
                                    anglais = !anglais;
                                  });
                                }),
                            w(10),
                            Text(
                              darkMode ? "Activé" : "Désactivé ",
                              style: TextStyle(
                                  fontFamily: 'bold',
                                  fontSize: 14,
                                  color: mainColor),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
