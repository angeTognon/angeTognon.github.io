import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:zth_app/menu/salaire/gestion_plein_blame.dart';
import 'package:zth_app/menu/salaire/gestion_pret_avancement.dart';
import 'package:zth_app/menu/salaire/gestion_prime.dart';
import 'package:zth_app/menu/planning/planning_employ%C3%A9.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'dart:html' as html;
import 'package:pie_chart/pie_chart.dart';

class Salaire extends StatefulWidget {
  const Salaire({super.key});

  @override
  State<Salaire> createState() => _SalaireState();
}

class _SalaireState extends State<Salaire> with SingleTickerProviderStateMixin {
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

  Map<String, double> dataMap = {
    "Fiches Déjà émises": 8.0,
    "Fiches non émises": 3,
  };
  Map<String, double> dataMap2 = {
    "Salaire Non Emis": 9.0,
    "Salaire Emis": 1.0,
  };
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
              "Salaire ",
              style:
                  TextStyle(fontFamily: 'bold', fontSize: 23, color: mainColor),
            ),
            h(20),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                "Gérer les salaires et les avantages sociaux ; Suivre les augmentations de salaire et des primes.",
                style: TextStyle(
                    fontFamily: 'normal',
                    fontSize: 16,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
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
                      Icon(Icons.attach_money_rounded,
                          color: index == 0 ? mainColor : Colors.grey,
                          size: 25),
                      w(20),
                      Text(
                        "Gestion des Primes",
                        style: TextStyle(
                            fontFamily: 'bold',
                            color: index == 0 ? mainColor : Colors.grey),
                      )
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_pin,
                        color: index == 1 ? mainColor2 : Colors.grey,
                        size: 25,
                      ),
                      w(20),
                      Text(
                        "Prêt et Avancement",
                        style: TextStyle(
                            fontFamily: 'bold',
                            color: index == 1 ? mainColor : Colors.grey),
                      )
                    ],
                  ),
                ),
              ],
            ),
            h(20),
            Container(
              height: 200,
              child: TabBarView(controller: _tabController, children: [
                GestionPrime(),
                GestionPretAvancement(),
              ]),
            ),
            h(10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Gestion des fiches de Paie ",
                        style: TextStyle(
                            fontFamily: 'bold', fontSize: 20, color: mainColor),
                      ),
                      h(20),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: PieChart(
                          dataMap: dataMap,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: 32,
                          chartRadius: 200,
                          colorList: [
                            mainColor,
                            Colors.amber,
                          ],
                          initialAngleInDegree: 0,
                          chartType: ChartType.ring,
                          ringStrokeWidth: 32,
                          centerText: "Fiches de Paie",
                          legendOptions: LegendOptions(
                            showLegendsInRow: false,
                            legendPosition: LegendPosition.right,
                            showLegends: true,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesInPercentage: false,
                            showChartValuesOutside: false,
                            decimalPlaces: 1,
                          ),
                          // gradientList: ---To add gradient colors---
                          // emptyColorGradient: ---Empty Color gradient---
                        ),
                      ),
                      h(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                              onPressed: () {},
                              child: Text(
                                "Ajouter une fiche de paie",
                                style: TextStyle(fontFamily: 'normal',color: Colors.white),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Gestion des Salaires ",
                        style: TextStyle(
                            fontFamily: 'bold', fontSize: 20, color: mainColor),
                      ),
                      h(20),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: PieChart(
                          dataMap: dataMap2,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: 32,
                          chartRadius: 200,
                          colorList: [
                            mainColor,
                            Colors.amber,
                          ],
                          initialAngleInDegree: 0,
                          chartType: ChartType.ring,
                          ringStrokeWidth: 32,
                          centerText: "Salaires émis",
                          legendOptions: const LegendOptions(
                            showLegendsInRow: false,
                            legendPosition: LegendPosition.right,
                            showLegends: true,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: false,
                            showChartValuesInPercentage: false,
                            showChartValuesOutside: false,
                            decimalPlaces: 1,
                          ),
                          // gradientList: ---To add gradient colors---
                          // emptyColorGradient: ---Empty Color gradient---
                        ),
                      ),
                      h(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                              onPressed: () {},
                              child: Text(
                                "Ajouter Un Salaire",
                                style: TextStyle(fontFamily: 'normal',color: Colors.white),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            h(20),
          ],
        ),
      ),
    );
  }
}
