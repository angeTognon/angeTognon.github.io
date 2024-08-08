// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:zth_app/widgets/wid_var.dart';

class GestionPretAvancement extends StatefulWidget {
  const GestionPretAvancement({super.key});

  @override
  State<GestionPretAvancement> createState() => _GestionPretAvancementState();
}

class _GestionPretAvancementState extends State<GestionPretAvancement> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: mainColor3, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Container(
                    width: 180,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Nom et Prénoms",
                        style: TextStyle(
                            fontFamily: 'bold',
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
                    width: 120,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Salaire\nde base",
                        style: TextStyle(
                            fontFamily: 'bold',
                            fontSize: 13),textAlign: TextAlign.center
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 3,
                    color: Colors.white54,
                  ),
                  Container(
                    width: 120,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Salaire\nBrute",
                        style: TextStyle(
                            fontFamily: 'bold',
                            fontSize: 13),textAlign: TextAlign.center
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 3,
                    color: Colors.white54,
                  ),
                  Container(
                    width: 120,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Salaire\nNette",
                        style: TextStyle(
                            fontFamily: 'bold',
                            fontSize: 13),textAlign: TextAlign.center,
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
                        "Prêts Effectués",
                        style: TextStyle(
                            fontFamily: 'bold',
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
                        "Avancements\nOctroyés",
                        style: TextStyle(
                            fontFamily: 'bold',
                            fontSize: 13),textAlign: TextAlign.center
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 3,
                    color: Colors.white54,
                  ),
                  Container(
                    width: 100,
                    height: 50,
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Date d'échance",
                        style: TextStyle(
                            fontFamily: 'bold',
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
                    width: 100,
                    height: 50,
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Période de Paiement",
                        style: TextStyle(
                            fontFamily: 'bold',
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
                    width: 100,
                    height: 50,
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Montant à prélever",
                        style: TextStyle(
                            fontFamily: 'bold',
                            fontSize: 13),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 3,
                    color: Colors.white54,
                  ),
                  Expanded(
                    child: Container(
                      width: 200,
                      height: 50,
                      child: Center(
                        child: Text(
                          "Action",
                          style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            h(5),
            BoxUser(
                "Aïcha TRAORÉ",
                120000,
                70000,
                "30.000 FCA le 10/07/2024",
                "Aucun avancement pour l'instant",
                _containerKey,
                "10/10/2024",
                "3 mois",
                "12500 FCFA"),
            Divider(),
            h(5),
            BoxUser(
                "Christian ZOGBO",
                250000,
                250000,
                "Aucun Prêt pour l'instant",
                "Aucun avancement pour l'instant",
                _containerKey2,
                "-",
                "-",
                "-"),
            Divider(),
          ],
        ));
  }

  BoxUser(
      String nomprenom,
      double salaireBasic,
      salaireActu,
      String pret,
      avancement,
      GlobalKey key,
      String echeance,
      periodePaiement,
      montant_a_prelever) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            width: 180,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 40,              child: CircleAvatar(
                    backgroundColor: mainColor3,
                    child: Icon(
                      Icons.person,
                      color: mainColor2,
                    ),
                  ),
                ),
                w(20),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(width: 120,
                      child: Text(
                        nomprenom,
                        style: TextStyle(
                            fontFamily: 'normal',
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 13),
                      ),
                    ),
                  ],
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
                '$salaireBasic FCFA',
                style: TextStyle(
                    fontFamily: 'normal', color: Colors.black, fontSize: 13),
              ),
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
                '$salaireBasic FCFA',
                style: TextStyle(
                    fontFamily: 'normal', color: Colors.black, fontSize: 13),
              ),
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
                '$salaireActu FCFA',
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
                pret,
                style: TextStyle(
                    fontFamily:
                        pret == "Aucun Prêt pour l'instant" ? 'normal' : 'bold',
                    color: pret == "Aucun Prêt pour l'instant"
                        ? Colors.black87
                        : Color.fromARGB(210, 255, 0, 0),
                    fontSize: 13),textAlign: TextAlign.center,
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
                avancement,
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
          Container(
            width: 100,
            height: 50,
            child: Center(
              child: Text(
                echeance,
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
          Container(
            width: 100,
            height: 50,
            child: Center(
              child: Text(
                periodePaiement,
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
          Container(
            width: 100,
            height: 50,
            child: Center(
              child: Text(
                montant_a_prelever,
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
                          padding: EdgeInsets.all(0)),
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
                                  pretMethode(nomprenom, salaireActu,
                                      int.parse(montantController.text));
                                },
                                child: Text(
                                  'Octroyer un Prêt',
                                  style: TextStyle(fontFamily: 'normal'),
                                ),
                                value: 2,
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  print("okkkkkkkkk");
                                  avancement_Methode(nomprenom, salaireActu,
                                      int.parse(montantAvanceController.text));
                                },
                                child: Text(
                                  'Faire un avanceent',
                                  style: TextStyle(fontFamily: 'normal'),
                                ),
                                value: 1,
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

  pleinteMethode(String nomprenom) {}

  pretMethode(String nomprenom, double salaireActu, montantController_) {
    showDialog(
      barrierColor: mainColor3,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            surfaceTintColor: Colors.white,
            content: Container(
              padding: EdgeInsets.all(10),
              height: (MediaQuery.of(context).size.height / 2+20),
              width: MediaQuery.of(context).size.width / 2,
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    "Octroie de Prêt à l'employé $nomprenom",
                    style: TextStyle(
                        fontFamily: 'bold', color: mainColor2, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  h(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 45,
                        width: 300,
                        child: TextFormField(
                          controller: montantAvanceController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                fontFamily: 'normal',
                                fontSize: 14,
                                color: Colors.black45),
                            border: OutlineInputBorder(),
                            labelText: "Montant du prêt",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre prénom';
                            }
                            setState(
                              () {},
                            );
                            return null;
                          },
                        ),
                      ),
                      h(50),
                      Container(
                        height: 45,
                        width: 300,
                        child: TextFormField(
                          onTap: _showDatePicker,
                          decoration: InputDecoration(
                            labelText: "Date de l'avance",
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
                                ? DateFormat('dd/MM/yyyy').format(_selectedDate)
                                : '',
                          ),
                        ),
                      ),
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
                            "Période de Paiement",
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
                                labelText: 'Période de Paiement',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date d'échéance",
                            style: TextStyle(
                                fontFamily: 'bold',
                                color: Colors.black87,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          h(10),
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              onTap: _showDatePicker,
                              decoration: InputDecoration(
                                labelText: "Date d'échéance",
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
                  h(20),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Montant à prélever du Salaire",
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
                                labelText: 'Montant à prélever du Salaire',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          h(25),
                          Text(
                            "Salaire Avant le Prêt : 70.000FCFA",
                            style: TextStyle(
                                fontFamily: 'normal',
                                color: Colors.black87,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          h(10),
                         Text(
                            "Salaire Après le Prêt : 50.000FCFA",
                            style: TextStyle(
                                fontFamily: 'normal',
                                color: Colors.black87,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          h(10),
                        ],
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                  fontFamily: 'normal', color: Colors.white),
                            ),
                          ),
                        ),
                      )
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

  avancement_Methode(String nomprenom, double salaireActu, montantController) {
    showDialog(
      barrierColor: mainColor3,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            surfaceTintColor: Colors.white,
            content: Container(
              padding: EdgeInsets.all(10),
              height: (MediaQuery.of(context).size.height / 2.9),
              width: MediaQuery.of(context).size.width / 2,
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    "Faire un Avancement à $nomprenom",
                    style: TextStyle(
                        fontFamily: 'bold', color: mainColor2, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  h(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 45,
                        width: 300,
                        child: TextFormField(
                          controller: montantAvanceController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                fontFamily: 'normal',
                                fontSize: 14,
                                color: Colors.black45),
                            border: OutlineInputBorder(),
                            labelText: "Montant de l'avance",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre prénom';
                            }
                            setState(
                              () {},
                            );
                            return null;
                          },
                        ),
                      ),
                      Container(
                        height: 45,
                        width: 300,
                        child: TextFormField(
                          onTap: _showDatePicker,
                          decoration: InputDecoration(
                            labelText: "Date de l'avance",
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
                                ? DateFormat('dd/MM/yyyy').format(_selectedDate)
                                : '',
                          ),
                        ),
                      ),
                    ],
                  ),
                  h(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            " Salaire Avant Prêt :",
                            style: TextStyle(
                                fontFamily: 'bold',
                                color: mainColor,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          h(10),
                          Text(
                            "$salaireActu FCFA",
                            style: TextStyle(
                                fontFamily: 'normal',
                                color: Colors.black87,
                                fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            " Salaire Après Prêt :",
                            style: TextStyle(
                                fontFamily: 'bold',
                                color: mainColor,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          h(10),
                          Text(
                            "${salaireActu - montantController} FCFA",
                            style: TextStyle(
                                fontFamily: 'normal',
                                color: Colors.black87,
                                fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    ],
                  ),
                  h(20),
                  InkWell(
                    onTap: () {
                      setState(
                        () {
                          salaireActu = montantController;
                        },
                      );

                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: mainColor2),
                      child: Center(
                        child: Text(
                          "Confirmer",
                          style: TextStyle(
                              fontFamily: 'normal', color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
