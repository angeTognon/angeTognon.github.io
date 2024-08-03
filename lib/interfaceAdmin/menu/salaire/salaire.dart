import 'dart:convert';
import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:zth_app/interfaceAdmin/menu/sanctions/sanction.dart';
import 'package:zth_app/interfaceAdmin/menu/salaire/gestion_pret_avancement.dart';
import 'package:zth_app/interfaceAdmin/menu/salaire/gestion_prime.dart';
import 'package:zth_app/interfaceAdmin/menu/planning/planning_employ%C3%A9.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'dart:html' as html;
import 'package:pie_chart/pie_chart.dart';
import 'package:d_chart/d_chart.dart';
import 'dart:io';

import 'dart:html' as html;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as uh;

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
    "Prêt en Cours": 8.0,
    "Prêt en retard": 3,
  };
  Map<String, double> dataMap2 = {
    "Salaire Non Emis": 9.0,
    "Salaire Emis": 1.0,
  };

  final ordinalGroup = [
    OrdinalGroup(
      color: mainColor,
      id: '1',
      data: [
        OrdinalData(
          domain: 'Janvier',
          measure: 3,
        ),
        OrdinalData(domain: 'Février', measure: 0),
        OrdinalData(domain: 'Mars', measure: 0),
        OrdinalData(domain: 'Avril', measure: 2),
        OrdinalData(domain: 'Mai', measure: 0),
        OrdinalData(domain: 'Juin', measure: 8),
        OrdinalData(domain: 'Juillet', measure: 6.5),
      ],
    ),
  ];

  /* PDF */

  Future<void> generatePDF(
    String name,
    String email,
    String phone,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Formulaire'),
            pw.SizedBox(height: 20),
            pw.Text('Nom: $name'),
            pw.SizedBox(height: 10),
            pw.Text('Email: $email'),
            pw.SizedBox(height: 10),
            pw.Text('Téléphone: $phone'),
          ],
        ),
      ),
    );

    final bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = uh.AnchorElement(href: url)
      ..setAttribute('download', 'formulaire.pdf')
      ..click();
    html.Url.revokeObjectUrl(url);
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Salaire ",
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 23, color: mainColor),
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
                  ],
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                    onPressed: () async {
                      generatePDF(
                        "d",
                        "jkjkjk",
                        "hkjhkjhk"
                      );
                    },
                    child: Text(
                      "Générer une fiche de Paie",
                      style:
                          TextStyle(fontFamily: 'normal', color: Colors.white),
                    ))
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Statistiques Des Prêts effecués durant les 7 derniers mois",
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 15, color: mainColor),
                    ),
                    Container(
                      height: 500,
                      width: 500,
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: DChartBarO(
                              areaColor: (group, ordinalData, index) {
                                if (ordinalData == 10) {
                                  mainColor;
                                }
                              },
                              groupList: ordinalGroup,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Statistiques Des Prêts En Cours / En Retard",
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 15, color: mainColor),
                    ),
                    PieChart(
                      dataMap: dataMap,
                      animationDuration: Duration(milliseconds: 800),
                      chartLegendSpacing: 32,
                      chartRadius: 300,
                      colorList: [
                        mainColor,
                        Color.fromARGB(219, 185, 28, 28),
                      ],
                      initialAngleInDegree: 0,
                      ringStrokeWidth: 32,
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
                      ),
                      // gradientList: ---To add gradient colors---
                      // emptyColorGradient: ---Empty Color gradient---
                    ),
                    h(180)
                  ],
                ),
              ],
            ),
            h(15),
            /* Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor),
                              onPressed: () {},
                              child: Text(
                                "Ajouter une fiche de paie",
                                style: TextStyle(
                                    fontFamily: 'normal', color: Colors.white),
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
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor),
                              onPressed: () {},
                              child: Text(
                                "Ajouter Un Salaire",
                                style: TextStyle(
                                    fontFamily: 'normal', color: Colors.white),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            */
            h(20),
          ],
        ),
      ),
    );
  }
}
