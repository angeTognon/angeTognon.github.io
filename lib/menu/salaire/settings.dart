// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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

  void _showPopupNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 187, 64, 55),
        content: Text(
          'Veuillez Patienter la date de la prochaine prime. Nous vous notifierons 5 jours avant la dite date !',
          style: TextStyle(color: Colors.white, fontFamily: 'normal'),
        ),
        duration: Duration(seconds: 10),
        action: SnackBarAction(
          label: 'Fermer',
          onPressed: () {
            // Do something when the user dismisses the notification
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    montantController.text = "0";
    super.initState();
  }

  void calculPrime1() {}
  String _selectedValue = 'Cliquez ici pour choisir';
  /* · l' ;
· l'avertissement écrit ;
· le blâme ;
· la mise à pied de 1 à 8 jours avec privation de salaire ;
· le licenciement avec préavis ;
· le licenciement sans préavis en cas de faute lourde sous réserve de l'appréciation de la juridiction compétente en ce qui concerne la
gravité de la faute. */
  final List<String> _options = [
    'Cliquez ici pour choisir',
    'Avertissement Verbal',
    'Blâme',
    'La mise à pied de 1 à 8 jours avec privation de salaire',
    'licenciement avec préavis',
    'licenciement sans préavis'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(30),
        height: MediaQuery.of(context).size.height,
        width: (MediaQuery.of(context).size.width * 13.5) / 16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Paramètre",
              style:
                  TextStyle(fontFamily: 'bold', fontSize: 23, color: mainColor),
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(300),
                          image: DecorationImage(
                              image: AssetImage("assets/images/ange.jpg"),
                              fit: BoxFit.cover)),
                    ),
                    w(30),
                     Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "TOGNON KOFFI ANGE",
                          style: TextStyle(fontFamily: 'bold', fontSize: 15, ),
                        ),
                        h(20),
                        Text(
                          "Administrateur",
                          style: TextStyle(fontFamily: 'normal', fontSize: 14,color: mainColor ),
                        ),
                       
                      ],
                    )
                  ],
                ),
                w(20),
                Container(
                  height: 200,width: 4,color: Colors.black26,
                ),
                w(20),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Nationalité :",style: TextStyle(fontFamily: 'bold', fontSize: 14,color: mainColor ),),
                            w(20),
                            Text("Béninoise",style: TextStyle(fontFamily: 'normal', fontSize: 14, ),),
                          ],
                        ),   
                        h(20),
                        Row(
                          children: [
                            Text("Ville :",style: TextStyle(fontFamily: 'bold', fontSize: 14,color: mainColor ),),
                            w(20),
                            Text("Parakou",style: TextStyle(fontFamily: 'normal', fontSize: 14, ),),
                          ],
                        ),
                        h(20),
                        Row(
                          children: [
                            Text("Quartier :",style: TextStyle(fontFamily: 'bold', fontSize: 14,color: mainColor ),),
                            w(20),
                            Text("Zongo",style: TextStyle(fontFamily: 'normal', fontSize: 14, ),),
                          ],
                        ),  
                        h(20),
                        Row(
                          children: [
                            Text("Groupe Sanguin :",style: TextStyle(fontFamily: 'bold', fontSize: 14,color: mainColor ),),
                            w(20),
                            Text("B",style: TextStyle(fontFamily: 'normal', fontSize: 14, ),),
                          ],
                        ),    
                        h(20),
                        Row(
                          children: [
                            Text("Email :",style: TextStyle(fontFamily: 'bold', fontSize: 14,color: mainColor ),),
                            w(20),
                            Text("ange@gmail.com",style: TextStyle(fontFamily: 'normal', fontSize: 14, ),),
                          ],
                        ),                      
                      ],
                    )
              ],
            ),
           
          ],
        ));
  }

  BoxUser(String nomprenom, double nbrSanction, String typeSanction,
      dateSanction, motifSanction, GlobalKey key) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            width: 300,
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
                    nomprenom,
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
            color: Color.fromARGB(19, 0, 0, 0),
          ),
          Container(
            width: 120,
            height: 50,
            child: Center(
              child: Text(
                '$nbrSanction',
                style: TextStyle(
                    fontFamily: 'normal', color: Colors.black87, fontSize: 13),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 3,
            color: Color.fromARGB(19, 0, 0, 0),
          ),
          Container(
            width: 200,
            height: 50,
            child: Center(
              child: Text(
                '$typeSanction ',
                style: TextStyle(
                    fontFamily: 'normal', color: Colors.black87, fontSize: 13),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 3,
            color: Color.fromARGB(19, 0, 0, 0),
          ),
          Container(
            width: 150,
            height: 50,
            child: Center(
              child: Text(
                dateSanction,
                style: TextStyle(
                    fontFamily: 'normal', color: Colors.black87, fontSize: 13),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 3,
            color: Color.fromARGB(19, 0, 0, 0),
          ),
          Container(
            width: 250,
            height: 50,
            child: Center(
              child: Text(
                motifSanction,
                style: TextStyle(
                    fontFamily: 'normal', color: Colors.black87, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            height: 50,
            width: 3,
            color: Color.fromARGB(19, 0, 0, 0),
          ),
          Expanded(
            child: Container(
                width: 30,
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(149, 255, 255, 255),
                          padding: EdgeInsets.all(15)),
                      onPressed: () {
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
                                onTap: () {
                                  pleinteMethode(
                                    nomprenom,
                                  );
                                },
                                child: Text(
                                  "Ajouter une sanction à l'employé",
                                  style: TextStyle(fontFamily: 'normal'),
                                ),
                                value: 2,
                              ),
                            ]);
                      },
                      child: Container(
                        key: key,
                        height: 30,
                        width: 30,
                        child: Image.asset("assets/images/more_icon.png"),
                      ),
                    )
                  ],
                )),
          ),
          Container(
            height: 50,
            width: 3,
            color: Color.fromARGB(19, 0, 0, 0),
          ),
        ],
      ),
    );
  }

  pleinteMethode(String nomprenom) {
    showDialog(
      barrierColor: mainColor3,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            surfaceTintColor: Colors.white,
            content: Container(
              padding: EdgeInsets.all(10),
              height: (MediaQuery.of(context).size.height / 2.2),
              width: MediaQuery.of(context).size.width / 2,
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    "Sanction à l'employé $nomprenom",
                    style: TextStyle(
                        fontFamily: 'bold', color: mainColor2, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  h(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Type de Sanction : ",
                            style: TextStyle(
                                fontFamily: 'bold',
                                color: Colors.black87,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            width: 350,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _selectedValue,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedValue = newValue!;
                                });
                              },
                              items: _options.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          h(15),
                          Text(
                            "Motif de la Sanction",
                            style: TextStyle(
                                fontFamily: 'bold',
                                color: Colors.black87,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          h(10),
                          Container(
                            height: 150,
                            width: 350,
                            child: TextFormField(
                              //controller: montantController,
                              maxLines: 8,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                labelText: 'Motif de la sanction',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              onTap: _showDatePicker,
                              decoration: InputDecoration(
                                labelText: 'Date de la sanction',
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
                          h(30),
                          Text(
                            "Information Suplémentaire",
                            style: TextStyle(
                                fontFamily: 'bold',
                                color: Colors.black87,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          h(10),
                          Container(
                            height: 40,
                            width: 300,
                            child: TextFormField(
                              //controller: montantController,
                              maxLines: 8,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: OutlineInputBorder(),
                                labelText: 'Information Suplémentaire',
                              ),
                            ),
                          ),
                          h(30),
                          InkWell(
                            onTap: () {
                              setState(
                                () {},
                              );

                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: mainColor2),
                              child: Center(
                                child: Text(
                                  "Confirmer",
                                  style: TextStyle(
                                      fontFamily: 'normal',
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
