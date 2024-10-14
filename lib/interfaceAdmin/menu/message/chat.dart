// ignore_for_file: sort_child_properties_last

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zth_app/interfaceEmploy%C3%A9/home_employe.dart';
import 'package:zth_app/main.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _scrollController = ScrollController();
  getSalary() async {
    var url = "https://zoutechhub.com/pharmaRh/getMessage.php?codee=$codee";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  getDiscussion() async {
    var url =
        "https://zoutechhub.com/pharmaRh/getMessageDiscussion.php?email=$user_email";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  get() async {
    var url = "https://zoutechhub.com/pharmaRh/getSalary.php";
    var response = await http.get(Uri.parse(url));
    var pub = await json.decode(response.body);
    return pub;
  }

  bool change = false;
  bool newDiscussion = false;
  void _scrollToEnd() {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.offset) {
      return;
    }
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  bool _isScrolledToEnd = false;
  @override
  // 66063796
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      getSalary();
      getDiscussion();
    });
    Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        change = !change;
      });
    });
    _scrollController.addListener(_scrollToEnd);
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final TextEditingController _textController = TextEditingController();

  int index = 0;
  bool isNew = false;

  inscription() async {
    var url =
        "https://zoutechhub.com/pharmaRh/addMessage.php?nomPrenomE=$user_name&nomPrenomR=$receveur&msg=${_textController.text}&codee=7AEEBc8l";
    var response = await http.post(Uri.parse(url));
  }

  String mp = "";
  sendMessage(String nomPrenomR) async {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    setState(() {
      mp = String.fromCharCodes(
        Iterable.generate(
          6,
          (_) => chars.codeUnitAt(
            random.nextInt(chars.length),
          ),
        ),
      );
      print(mp);
      codee = mp;
    });
    // EncryptData(mpController.text);
    var url =
        "https://zoutechhub.com/pharmaRh/addMessage.php?nomPrenomE=$user_name&nomPrenomR=$nomPrenomR&msg=&codee=$mp";
    var response = await http.post(Uri.parse(url));
    if (response.body == "OK") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 18, 133, 22),
          content: Text(
            "Ajout Réussie.",
            style: TextStyle(
              fontFamily: 'normal',
              color: Colors.white,
            ),
          )));
    } else {
      setState(() {
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

  @override
  Widget build(BuildContext context) {
    if (_scrollController.hasClients &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      _isScrolledToEnd = true;
    } else {
      _isScrolledToEnd = false;
    }
    return SizedBox(
      width: (MediaQuery.of(context).size.width * 9.7) / 12,
      child: Row(
        children: [
          Card(
            surfaceTintColor: Colors.white,
            elevation: 5,
            child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: (MediaQuery.of(context).size.width * 2.66) / 12,
                child: Column(
                  children: [
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
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: Center(
                                  child: Image.asset("assets/images/chat.png"),
                                ),
                              ),
                              w(20),
                              Text(
                                "Chats",
                                style: TextStyle(
                                    fontFamily: 'bold',
                                    color:
                                        index == 0 ? mainColor : Colors.grey),
                              ),
                              w(50)
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            children: [
                              Icon(
                                Icons.call,
                                color: index == 1 ? mainColor2 : Colors.grey,
                                size: 25,
                              ),
                              w(20),
                              Text(
                                "Appel",
                                style: TextStyle(
                                    fontFamily: 'bold',
                                    color:
                                        index == 1 ? mainColor : Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    h(20),
                    SizedBox(
                      height: 100,
                      width: (MediaQuery.of(context).size.width * 3.5) / 16,
                      child: FutureBuilder(
                        future: get(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Column(
                              children: [
                                Icon(
                                  Icons.error,
                                  color: mainColor,
                                  size: 40,
                                ),
                                const Center(
                                  child: Text(
                                    "Vous n'avez aucune discusion pour l'instant",
                                    style: TextStyle(fontFamily: 'normal'),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
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
                                        size: 100,
                                        color: mainColor,
                                      ),
                                      h(20),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: const Text(
                                          "Oups, Vous n'avez aucun employé pour l'instant ",
                                          style: TextStyle(fontSize: 17),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  )
                                : ListView.builder(
                                    itemCount: snapshot.data.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.only(left: 22),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              receveur =
                                                  "${snapshot.data![index]['prenom']} ${snapshot.data![index]['nom']}";
                                              sendMessage(receveur);
                                            });
                                          },
                                          child: user_name ==
                                                  "${snapshot.data![index]['prenom']} ${snapshot.data![index]['nom']}"
                                              ? h(0)
                                              : Column(
                                                  children: [
                                                    CircleAvatar(
                                                      minRadius: 30,
                                                      backgroundColor:
                                                          mainColor,
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.person,
                                                          color: Colors.white,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    ),
                                                    h(10),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "${snapshot.data![index]['prenom']} ",
                                                          style:
                                                              const TextStyle(
                                                            fontFamily: 'bold',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    /*  */
                                                  ],
                                                ),
                                        ),
                                      );
                                    });
                          }
                          return Center(
                              child: SizedBox(
                                  height: 150,
                                  width: 150,
                                  child:
                                      Lottie.asset("assets/images/anim.json")));
                        },
                      ),
                    ),
                    const Divider(),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Discussions récentes",
                            style: TextStyle(
                                fontFamily: 'bold', color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: TabBarView(controller: _tabController, children: [
                        SizedBox(
                          width:
                              (MediaQuery.of(context).size.width * 13.5) / 16,
                          child: Row(
                            children: [
                              Container(
                                height: 500,
                                width:
                                    (MediaQuery.of(context).size.width * 3.5) /
                                        16,
                                padding: const EdgeInsets.all(15),
                                child: FutureBuilder(
                                  future: getDiscussion(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasError) {
                                      return Column(
                                        children: [
                                          Icon(
                                            Icons.error,
                                            color: mainColor,
                                            size: 40,
                                          ),
                                          const Center(
                                            child: Text(
                                              "Vous n'avez aucune discusion pour l'instant",
                                              style: TextStyle(
                                                  fontFamily: 'normal'),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
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
                                                  size: 100,
                                                  color: mainColor,
                                                ),
                                                h(20),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 20, right: 20),
                                                  child: const Text(
                                                    "Oups, aucune donnée pour l'instant ",
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : ListView.builder(
                                              itemCount: snapshot.data.length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            codee = snapshot
                                                                    .data![
                                                                index]['codee'];
                                                            snapshot.data![index][
                                                                        'nomPrenomR'] ==
                                                                    user_name
                                                                ? receveur = snapshot
                                                                            .data![
                                                                        index][
                                                                    'nomPrenomE']
                                                                : receveur = snapshot
                                                                            .data![
                                                                        index][
                                                                    'nomPrenomR'];

                                                            /* "${snapshot.data![index]['nomPrenomE']}"
                                                                : snapshot.data![
                                                                        index][
                                                                    'nomPrenomR'] */

                                                            print(codee);
                                                          });
                                                        },
                                                        child: User(
                                                            snapshot.data![index]
                                                                        [
                                                                        'nomPrenomR'] ==
                                                                    user_name
                                                                ? "${snapshot.data![index]['nomPrenomE']}"
                                                                : snapshot.data![
                                                                        index][
                                                                    'nomPrenomR'],
                                                            "2s",
                                                            "${snapshot.data![index]['msg']}",
                                                            index)),
                                                    const Divider()
                                                  ],
                                                );
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
                            ],
                          ),
                        )
                      ]),
                    ),
                  ],
                )),
          ),
          Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: (MediaQuery.of(context).size.width * 6.96) / 12,
              child: Column(
                children: [
                  SizedBox(
                      height: 80,
                      width: (MediaQuery.of(context).size.width * 6.96) / 12,
                      // width: (MediaQuery.of(context).size.width * 10) / 16,
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 80,
                          width: (MediaQuery.of(context).size.width * 10) / 16,
                          child: FutureBuilder(
                            future: change ? getSalary() : getSalary(),
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
                                    ? receveur == ""
                                        ? Column(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 20, right: 20),
                                                child: Text(
                                                  receveur == ""
                                                      ? ""
                                                      : receveur,
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  User2(receveur, "En ligne"),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.videocam_outlined,
                                                        color: mainColor,
                                                        size: 35,
                                                      ),
                                                      w(20),
                                                      Icon(
                                                        Icons.call,
                                                        color: mainColor,
                                                        size: 25,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const Divider()
                                            ],
                                          )
                                    : ListView.builder(
                                        itemCount: 1,
                                        itemBuilder: (context, index) {
                                          //
                                          return Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  User2(
                                                      snapshot.data![index][
                                                                  'nomPrenomR'] ==
                                                              "ange"
                                                          ? "${snapshot.data![index]['nomPrenomE']}"
                                                          : snapshot
                                                                  .data![index]
                                                              ['nomPrenomR'],
                                                      "En ligne"),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.videocam_outlined,
                                                        color: mainColor,
                                                        size: 35,
                                                      ),
                                                      w(20),
                                                      Icon(
                                                        Icons.call,
                                                        color: mainColor,
                                                        size: 25,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const Divider()
                                            ],
                                          );
                                        });
                              }
                              return Center(
                                  child: SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: Lottie.asset(
                                          "assets/images/anim.json")));
                            },
                          ))),
                  SizedBox(
                    height: 500,
                    width: (MediaQuery.of(context).size.width * 10) / 16,
                    child: FutureBuilder(
                      future: getSalary(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                                      Icons.error,
                                      size: 100,
                                      color: mainColor,
                                    ),
                                    h(20),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: const Text(
                                        "Veuillez choisir une discussion d'abord",
                                        style: TextStyle(fontSize: 17),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                )
                              : ListView.builder(
                                  controller: _scrollController,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      _scrollController.animateTo(
                                        _scrollController
                                            .position.maxScrollExtent,
                                        duration:
                                            const Duration(milliseconds: 1),
                                        curve: Curves.easeInOut,
                                      );
                                    });

                                    return Align(
                                      alignment: snapshot.data![index]
                                                  ['nomPrenomE'] ==
                                              user_name
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: snapshot.data![index]
                                                        ['nomPrenomE'] ==
                                                    user_name
                                                ? mainColor
                                                : Colors.blueGrey,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(
                                              "${snapshot.data![index]['msg']}",
                                              style: const TextStyle(
                                                fontFamily: 'normal',
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                        }
                        return Center(
                            child: SizedBox(
                                height: 150,
                                width: 150,
                                child:
                                    Lottie.asset("assets/images/anim.json")));
                      },
                    ),
                  ),
                  /* floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: actualite
          ? 
          : null, */
                ],
              )),
        ],
      ),
    );
  }

  User(String name, time, msg, int indexx) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: mainColor,
          child: const Center(
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ),
        w(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width * 2.2) / 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      name,
                      style: TextStyle(color: mainColor, fontFamily: 'bold'),
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(fontFamily: 'bold', color: mainColor),
                  )
                ],
              ),
            ),
            h(5),
            SizedBox(
              width: 220,
              child: Text(
                msg,
                style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0), fontFamily: 'normal'),
              ),
            ),
          ],
        ),
        w(22),
      ],
    );
  }

  User2(String name, state) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: mainColor,
          child: const Center(
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ),
        w(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width * 2.2) / 16,
              child: Text(
                name,
                style: const TextStyle(color: Colors.black, fontFamily: 'bold'),
              ),
            ),
            h(5),
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.green,
                  minRadius: 8,
                ),
                w(10),
                Text(
                  state,
                  style: const TextStyle(
                      color: Color.fromARGB(91, 0, 0, 0), fontFamily: 'normal'),
                ),
              ],
            ),
          ],
        ),
        w(22),
      ],
    );
  }
}

class Message {
  final String text;
  final bool isMe;

  Message({
    required this.text,
    required this.isMe,
  });
}
