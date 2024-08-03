import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:zth_app/interfaceAdmin/menu/planning/creat_group_salary.dart';
import 'package:zth_app/interfaceAdmin/menu/sanctions/sanction.dart';
import 'package:zth_app/interfaceAdmin/menu/salaire/gestion_pret_avancement.dart';
import 'package:zth_app/interfaceAdmin/menu/salaire/gestion_prime.dart';
import 'package:zth_app/interfaceAdmin/menu/planning/planning_employ%C3%A9.dart';
import 'package:zth_app/interfaceEmploy%C3%A9/2planning.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'dart:html' as html;

class PlanningE extends StatefulWidget {
  const PlanningE({super.key});

  @override
  State<PlanningE> createState() => _PlanningEState();
}

class _PlanningEState extends State<PlanningE>
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

    final GlobalKey _containerKey_o = GlobalKey();
  final GlobalKey _containerKey_o2 = GlobalKey();
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
                      "Mon Planning de la semaine ",
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 23, color: mainColor),
                    ),
                  ],
                ),
              ],
            ),
            h(20),
            Text(
              "Ayez un apperçu de toute les tâches qui vont été attribuées au cours de la semaine.\n\nUne fois l'une de ces tâches terminées, cliquez sur le bouton 'Valider' pour l'envoyer à votre Responsable RH",
              style: TextStyle(color: Colors.black, fontFamily: 'normal'),
            ),
            h(40),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    final RenderBox container = _containerKey_o.currentContext
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
                          child: Text(
                            "Aujourd'hui",
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Demain',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Hier',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Cette Semaine',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'La Semaine Dernière',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'La semaine Prochaine',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Le mois-ci',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Le mois Prochain',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Le mois précédent',
                            style:
                                TextStyle(fontFamily: 'normal', fontSize: 13),
                          ),
                          value: 2,
                        ),
                      ],

                      elevation: 8.0, // Adjust the elevation for the box shadow
                    );
                  },
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                    width: 210,
                    height: 35,
                    key: _containerKey_o,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black26)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Trier par Date",
                          style: TextStyle(
                              fontFamily: 'normal',
                              fontSize: 13,
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
                w(20),
                InkWell(
                  onTap: () {
                    final RenderBox container = _containerKey_o2
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
                          child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.green),
                              child: Center(
                                  child: Text(
                                'Fait',
                                style: TextStyle(
                                  fontFamily: 'normal',
                                  color: Colors.white,
                                ),
                              ))),
                        ),
                        PopupMenuItem(
                          child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.orange),
                              child: Center(
                                  child: Text(
                                'En Cours',
                                style: TextStyle(
                                  fontFamily: 'normal',
                                  color: Colors.white,
                                ),
                              ))),
                        ),
                        PopupMenuItem(
                          child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.red),
                              child: Center(
                                  child: Text(
                                'Bloqué',
                                style: TextStyle(
                                  fontFamily: 'normal',
                                  color: Colors.white,
                                ),
                              ))),
                        ),
                        PopupMenuItem(
                          child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey),
                              child: Center(
                                  child: Text(
                                'Pas Commencé',
                                style: TextStyle(
                                  fontFamily: 'normal',
                                  color: Colors.white,
                                ),
                              ))),
                        ),
                      ],
                      elevation: 8.0, // Adjust the elevation for the box shadow
                    );
                  },
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                    width: 200,
                    height: 35,
                    key: _containerKey_o2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black26)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Trier par titre de Statut",
                          style: TextStyle(
                              fontFamily: 'normal',
                              fontSize: 13,
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
              ],
            ),
            MonPlanning(),
            
          ],
        ),
      ),
    );
  }
}
