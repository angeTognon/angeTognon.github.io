import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:zth_app/menu/planning/creat_group_salary.dart';
import 'package:zth_app/menu/salaire/gestion_plein_blame.dart';
import 'package:zth_app/menu/salaire/gestion_pret_avancement.dart';
import 'package:zth_app/menu/salaire/gestion_prime.dart';
import 'package:zth_app/menu/planning/planning_employ%C3%A9.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'dart:html' as html;

class Planning extends StatefulWidget {
  const Planning({super.key});

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int index = 0;
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Planning ",
                      style: TextStyle(
                          fontFamily: 'bold',
                          fontSize: 23,
                          color: mainColor),
                    ),
                    h(20),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        "Créer des plannings pour des groupes d'employés ; Gérer les salaires et les avantages sociaux ; Suivre les augmentations de salaire et des primes ",
                        style: TextStyle(
                            fontFamily: 'normal',
                            fontSize: 16,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                     ],
                ),
                 Container(
                      height: 200,
                      width: 300,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(13)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Vue d'ensemble des groupes",
                              style:
                                  TextStyle(fontFamily: 'bold', fontSize: 13),
                            ),
                          ),
                          h(5),
                          Divider(),
                          h(5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: mainColor,
                                    minRadius: 20,
                                    child: Center(
                                        child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    )),
                                  ),
                                  w(10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Groupe 1",
                                        style: TextStyle(
                                            fontFamily: 'bold', fontSize: 13),
                                      ),
                                      Container(
                                        width: 100,
                                        child: Text(
                                          "Ange T. ; Marc A.; Christelle O.",
                                          style: TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 11),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: mainColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  "Supprimer",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'normal',
                                      fontSize: 11),
                                  textAlign: TextAlign.center,
                                )),
                              )
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    )
                
              ],
            ),
            h(20),
            CreationGroupleSalarie(),
            h(60),
            Container(
              height: 150,
              child: PlanningEmploye(),
            )
          ],
        ),
      ),
    );
  }
}
