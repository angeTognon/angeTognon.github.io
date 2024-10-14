import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zth_app/interfaceAdmin/menu/planning/creat_group_salary.dart';
import 'package:zth_app/interfaceAdmin/menu/sanctions/sanction.dart';
import 'package:zth_app/interfaceAdmin/menu/salaire/gestion_pret_avancement.dart';
import 'package:zth_app/interfaceAdmin/menu/salaire/gestion_prime.dart';
import 'package:zth_app/interfaceAdmin/menu/planning/planning_employ%C3%A9.dart';
import 'package:zth_app/main.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;

class Planning extends StatefulWidget {
  const Planning({super.key});

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning>
    with SingleTickerProviderStateMixin {
  getEquipe() async {
    var url = "https://zoutechhub.com/pharmaRh/getEquipe.php";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    print(pub);
    return pub;
  }

  int i = 0;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      _fetchMenuItems();
    });
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int index = 0;
  bool reload = false;
  bool show = false;
  final GlobalKey _containerKey0 = GlobalKey();
  final GlobalKey _containerKey1 = GlobalKey();
  TextEditingController tacheController = TextEditingController();
  List<String> _menuItems = [];
  final String _selectedOption = '';
  List<String> idGroupe = [];
  List<String> codeEquipee = [];
  Future<void> _fetchMenuItems() async {
    final response = await http
        .get(Uri.parse('https://zoutechhub.com/pharmaRh/getEquipe.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;

      final members = data.map((item) => "${item['nomEquipe']}").toList();
      final id = data.map((item) => "${item['id']}").toList();

      final codeEquipe = data.map((item) => "${item['codeEquipe']}").toList();
      setState(() {
        idGroupe = id;
        _menuItems = members;
        codeEquipee = codeEquipe;
      });
    } else {
      throw Exception('Failed to fetch menu items');
    }
  }

  int _selectedIndex = 0;
  bool cbon = false;
  DateTime _selectedDate0 = DateTime.now();
  String formattedDate1 = "";

  ajouterTache(String idGroupe, tache_, dateExecution) async {
    setState(() {
      show = true;
    });
    var url =
        "https://zoutechhub.com/pharmaRh/ajouterTache.php?id_groupe=$idGroupe&tache_=$tache_&dateExecution=$dateExecution";
    var response = await http.post(Uri.parse(url));
    print(response.body);
    print(response.statusCode);
    if (response.body == "OK") {
      setState(() {
        show = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 18, 133, 22),
          content: Text(
            "Création Réussie.",
            style: TextStyle(
              fontFamily: 'bold',
              color: Colors.white,
            ),
          )));
      Navigator.pop(context);
    } else {
      setState(() {
        show = false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Erreur. Veuillez réessayer ",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));
      });
    }
  }

  addPlanning(int indexx) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Annuler'),
              ),
              show
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: mainColor),
                      onPressed: () {
                        setState(
                          () {
                            ajouterTache(
                              codeEquipee[_selectedIndex],
                              tacheController.text,
                              formattedDate1,
                            );
                          },
                        );
                      },
                      child: const Text(
                        "Créer",
                        style:
                            TextStyle(color: Colors.white, fontFamily: 'bold'),
                      ))
            ],
            content: Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height / 1.8,
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ajouter un planning à une équipe",
                        style: TextStyle(
                            fontFamily: 'bold', color: mainColor, fontSize: 20),
                      )
                    ],
                  ),
                  h(20),
                  const Divider(),
                  h(20),
                  const Text(
                    "1- Tâches à attribuer",
                    style: TextStyle(fontFamily: 'bold', fontSize: 15),
                  ),
                  h(20),
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextFormField(
                      maxLines: 5,
                      scrollPhysics: const ClampingScrollPhysics(),
                      scrollPadding: EdgeInsets.zero,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontFamily: 'normal',
                          fontSize: 13,
                          color: Colors.black),
                      controller: tacheController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: "Cliquez pour ajouter une tâche",
                        hintStyle: TextStyle(
                            fontFamily: 'normal',
                            fontSize: 13,
                            color: Colors.black45),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre nom';
                        }
                        return null;
                      },
                    ),
                  ),
                  h(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "2- Groupes / Équipes ",
                            style: TextStyle(fontFamily: 'bold', fontSize: 15),
                          ),
                          h(20),
                          PopupMenuButton(
                            itemBuilder: (BuildContext context) => _menuItems
                                .map((item) => PopupMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    ))
                                .toList(),
                            onSelected: (value) {
                              setState(() {
                                _selectedIndex = _menuItems.indexOf(value);
                                cbon = true;
                                print(codeEquipee[_selectedIndex]);
                              });
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                              ),
                              width: 300,
                              child: Center(
                                child: cbon
                                    ? Text(_menuItems[_selectedIndex])
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_circle_outline_sharp,
                                            color: mainColor2,
                                          ),
                                          w(20),
                                          CircleAvatar(
                                            backgroundColor: mainColor,
                                            child: const Icon(
                                              Icons.person,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "3- Date d'exécution de la tâche : ",
                            style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          h(20),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: mainColor)),
                            height: 45,
                            width: 300,
                            padding: const EdgeInsets.only(left: 10, top: 3),
                            child: TextFormField(
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: _selectedDate0 ?? DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                ).then((pickedDate) {
                                  if (pickedDate != null) {
                                    setState(() {
                                      _selectedDate0 = pickedDate;
                                      formattedDate1 =
                                          "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year.toString()}";
                                      print(formattedDate1);
                                    });
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                    fontFamily: 'normal',
                                    fontSize: 14,
                                    color: Colors.black45),
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.calendar_today),
                                  onPressed: () {},
                                ),
                              ),
                              readOnly: true,
                              style: const TextStyle(
                                  fontFamily: "normal", fontSize: 14),
                              controller: TextEditingController(
                                  text: formattedDate1 != ""
                                      ? formattedDate1
                                      : "Cliquez ici pour choisir"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  deleteSalary(String codeEquipe) async {
    setState(() {
      show = true;
    });
    var url =
        "https://zoutechhub.com/pharmaRh/deleteGroupe.php?codeEquipe=$codeEquipe";
    var response = await http.post(Uri.parse(url));
    print(response.body);
    print(response.statusCode);
    if (response.body == "OK") {
      setState(() {
        show = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 18, 133, 22),
          content: Text(
            "Supression Réussie.",
            style: TextStyle(
              fontFamily: 'normal',
              color: Colors.white,
            ),
          )));
      //Navigator.pop(context);
    } else {
      setState(() {
        show = false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Erreur. Veuillez actualiser la page",
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
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height,
      width: (MediaQuery.of(context).size.width * 9.9) / 12,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Heureux de vous revoir Koffi !",
                  style: TextStyle(fontFamily: 'bold', fontSize: 18),
                ),
                Icon(
                  Icons.notifications,
                  color: mainColor,
                  size: 40,
                )
              ],
            ),
            h(10),
            const Divider(),
            h(20),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: const Text(
                "Créer des plannings pour des groupes d'employés ; Gérer vos équipes",
                style: TextStyle(
                    fontFamily: 'bold', fontSize: 16, color: Colors.black54),
              ),
            ),
            h(20),

            /* ************************************************* */
            TabBar(
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              indicatorColor: mainColor,
              onTap: (value) {
                setState(() {
                  i = value;
                });
              },
              controller: _tabController,
              tabs: [
                Tab(
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: mainColor,
                        size: 35,
                      ),
                      w(10),
                      Text(
                        "Gestion des équipes",
                        style: TextStyle(fontFamily: 'bold', color: mainColor),
                      )
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.archive,
                        color: Colors.grey,
                        size: 25,
                      ),
                      w(20),
                      const Text(
                        "Attribution des tâches ",
                        style:
                            TextStyle(fontFamily: 'bold', color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ],
            ),
            h(20),
            i == 0
                ? Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /* Row(
                      children: [
                        InkWell(
                          onTap: () {
                            addPlanning(index);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 35,
                            decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(7)),
                            child: Center(
                              child: Text(
                                "Ajouter une Tâche à un groupe de Salarié",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'normal'),
                              ),
                            ),
                          ),
                        ),
                        w(30),
                        w(20),
                        InkWell(
                          onTap: () {
                            final RenderBox container = _containerKey1
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
                                  onTap: () {
                                    setState(() {
                                      statu1 = true;
                                      statu2 = false;
                                      statu3 = false;
                                      statu4 = false;
                                    });
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                  onTap: () {
                                    setState(() {
                                      statu1 = false;
                                      statu2 = true;
                                      statu3 = false;
                                      statu4 = false;
                                    });
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                  onTap: () {
                                    setState(() {
                                      statu1 = false;
                                      statu2 = false;
                                      statu3 = true;
                                      statu4 = false;
                                    });
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                  onTap: () {
                                    setState(() {
                                      statu1 = false;
                                      statu2 = false;
                                      statu3 = false;
                                      statu4 = true;
                                    });
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                              elevation:
                                  8.0, // Adjust the elevation for the box shadow
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 5, right: 5, top: 5, bottom: 5),
                            width: 200,
                            height: 35,
                            key: _containerKey1,
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
                                      color:
                                          const Color.fromARGB(154, 0, 0, 0)),
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
 */
                              // h(50),
                              /* Text(
                      "Liste des tâches attribuées ",
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 18, color: mainColor),
                    ), */
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Liste des équipes",
                            style: TextStyle(
                                fontFamily: 'bold',
                                fontSize: 18,
                                color: mainColor2),
                          ),
                          w(20),
                          InkWell(
                            onTap: () {
                              getEquipe();
                              setState(() {
                                Future.delayed(
                                    const Duration(seconds: 3), () {});
                                reload = true;
                              });
                            },
                            child: SizedBox(
                                height: 25,
                                width: 25,
                                child: Image.asset(
                                    "assets/images/reload_icon.png")),
                          ),
                          w(100),
                          const CreationGroupleSalarie(),
                        ],
                      ),
                      h(40),
                      EnteteBoxEquipe(context),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: FutureBuilder(
                          future: reload ? getEquipe() : getEquipe(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text(
                                    "Erreur de chargement. Veuillez relancer l'application"),
                              );
                            }
                            if (snapshot.hasData) {
                              // print(vv.text + " ddd*****dddddddddddddd");
                              return snapshot.data.isEmpty
                                  ? Column(
                                      children: [
                                        h(20),
                                        Icon(
                                          Icons.safety_check_rounded,
                                          size: 50,
                                          color: mainColor,
                                        ),
                                        h(20),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: const Text(
                                            "Oups, Vous n'avez aucun employé pour l'instant ",
                                            style: TextStyle(fontSize: 14),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    )
                                  : ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        return ContenuBoxEquipe(
                                            "${snapshot.data![index]['nomEquipe']}",
                                            "${snapshot.data![index]['membres']}",
                                            "${snapshot.data![index]['typeActivite']}",
                                            "${snapshot.data![index]['dateTravail']}",
                                            "Equipe N° ${snapshot.data![index]['id']})",
                                            "${snapshot.data![index]['codeEquipe']}");
                                      });
                            }
                            return Center(
                                child: SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: Lottie.asset(
                                        "assets/images/anim.json")));
                          },
                        ),
                      ),
                      h(20),
                    ],
                  )
                : Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              addPlanning(index);
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              height: 35,
                              decoration: BoxDecoration(
                                  color: mainColor2,
                                  borderRadius: BorderRadius.circular(7)),
                              child: const Center(
                                child: Text(
                                  "Ajouter une Tâche à un groupe de Salarié",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'normal'),
                                ),
                              ),
                            ),
                          ),
                          w(30),
                          w(20),
                          InkWell(
                            onTap: () {
                              final RenderBox container = _containerKey1
                                  .currentContext
                                  ?.findRenderObject() as RenderBox;
                              final Offset containerPosition =
                                  container.localToGlobal(Offset.zero);
                              final Size containerSize = container.size;
                              showMenu(
                                color: Colors.white,
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
                                      setState(() {
                                        statu1 = true;
                                        statu2 = false;
                                        statu3 = false;
                                        statu4 = false;
                                      });
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.green),
                                        child: const Center(
                                            child: Text(
                                          'Fait',
                                          style: TextStyle(
                                            fontFamily: 'normal',
                                            color: Colors.white,
                                          ),
                                        ))),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      setState(() {
                                        statu1 = false;
                                        statu2 = true;
                                        statu3 = false;
                                        statu4 = false;
                                      });
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.orange),
                                        child: const Center(
                                            child: Text(
                                          'En Cours',
                                          style: TextStyle(
                                            fontFamily: 'normal',
                                            color: Colors.white,
                                          ),
                                        ))),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      setState(() {
                                        statu1 = false;
                                        statu2 = false;
                                        statu3 = true;
                                        statu4 = false;
                                      });
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.red),
                                        child: const Center(
                                            child: Text(
                                          'Bloqué',
                                          style: TextStyle(
                                            fontFamily: 'normal',
                                            color: Colors.white,
                                          ),
                                        ))),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      setState(() {
                                        statu1 = false;
                                        statu2 = false;
                                        statu3 = false;
                                        statu4 = true;
                                      });
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.grey),
                                        child: const Center(
                                            child: Text(
                                          'Pas Commencé',
                                          style: TextStyle(
                                            fontFamily: 'normal',
                                            color: Colors.white,
                                          ),
                                        ))),
                                  ),
                                ],
                                elevation:
                                    8.0, // Adjust the elevation for the box shadow
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 5, bottom: 5),
                              width: 200,
                              height: 35,
                              key: _containerKey1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black26)),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Trier par titre de Statut",
                                    style: TextStyle(
                                        fontFamily: 'normal',
                                        fontSize: 13,
                                        color: Color.fromARGB(154, 0, 0, 0)),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down_rounded,
                                    color: Color.fromARGB(154, 0, 0, 0),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        // height: 500,
                        child: const PlanningEmploye(),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }

  EnteteBoxEquipe(
    BuildContext context,
  ) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: mainColor3,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: Row(
        children: [
          SizedBox(
            width: 250,
            height: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  w(30),
                  const Text(
                    "Nom de l'équipe",
                    style: TextStyle(fontFamily: 'normal', color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(),
          const SizedBox(
            width: 320,
            height: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Membres de l'équipe",
                    style: TextStyle(fontFamily: 'normal', color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(),
          const SizedBox(
            width: 300,
            height: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Permanence/Garde",
                    style: TextStyle(fontFamily: 'normal', color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(),
          const SizedBox(
            width: 170,
            height: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Date",
                    style: TextStyle(fontFamily: 'normal', color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(),
          const SizedBox(
            width: 100,
            height: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Action",
                    style: TextStyle(fontFamily: 'normal', color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ContenuBoxEquipe(String NomEquipe, membre, type, date, equipe, code) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 250,
            height: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  w(5),
                  SizedBox(
                    width: 230,
                    child: Text(
                      NomEquipe == "" ? equipe : NomEquipe,
                      style: const TextStyle(fontFamily: 'normal'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(),
          Expanded(
            child: SizedBox(
              width: 200,
              height: 40,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 290,
                      child: Text(
                        membre,
                        style: const TextStyle(
                          fontFamily: 'normal',
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const VerticalDivider(),
          Container(
            height: 25,
            width: 300,
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFecfdf3)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.green,
                      ),
                      w(10),
                      Text(
                        type,
                        style: const TextStyle(
                            color: Colors.green, fontFamily: 'bold'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(),
          SizedBox(
            width: 170,
            height: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(fontFamily: 'normal'),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(),
          InkWell(
            onTap: () => deleteSalary(code),
            child: SizedBox(
              width: 100,
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: mainColor, borderRadius: BorderRadius.circular(15)),
                height: 30,
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Supprimer",
                        style: TextStyle(
                            fontFamily: 'normal',
                            color: Colors.white,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          w(20)
        ],
      ),
    );
  }
}
