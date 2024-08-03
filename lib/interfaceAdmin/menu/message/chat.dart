import 'package:flutter/material.dart';
import 'package:zth_app/widgets/wid_var.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
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
      padding: EdgeInsets.only(top: 0),
      width: (MediaQuery.of(context).size.width * 13.5) / 16,
      child: Row(
        children: [
          Card(
            surfaceTintColor: Colors.white,
            elevation: 5,
            child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: (MediaQuery.of(context).size.width * 3.5) / 16,
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
                              Container(
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
                    Container(
                      height: 200,
                      child: TabBarView(controller: _tabController, children: [
                        ChatSection(),
                      ]),
                    ),
                  ],
                )),
          ),
          Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: (MediaQuery.of(context).size.width * 9.8) / 16,
              child: Column(
                children: [
                  Card(
                    surfaceTintColor: Colors.white,
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      width: (MediaQuery.of(context).size.width * 10) / 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          User2("TOGNON Koffi Ange", "En ligne"),
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
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 500,
                      width: (MediaQuery.of(context).size.width * 10) / 16,
                      decoration: BoxDecoration(
                        color: mainColor__
                        // image: DecorationImage(image: AssetImage("assets/images/bg2.jpg"),scale: 1,fit: BoxFit.contain,colorFilter: ColorFilter.mode(Colors.black, BlendMode.color))
                        ),
                    ),
                  )
                ],
              )),
          /*  Container(
            height: MediaQuery.of(context).size.height,
            width: (MediaQuery.of(context).size.width*10)/16,
            color: const Color.fromARGB(255, 54, 44, 16),
          ), */
        ],
      ),
    );
  }

  ChatSection() {
    return Container(
      width: (MediaQuery.of(context).size.width * 13.5) / 16,
      child: Row(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width * 3.5) / 16,
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                User("TOGNON Koffi Ange", "2s", "D'accord, j'arrive."),
                Divider(),
                h(10),
                User("Carrine DOSSOU", "1h", "Oui, ne t'inquiètes pas."),
              ],
            ),
          ),
        ],
      ),
    );
  }

  MessageSection() {
    return Container(
      width: (MediaQuery.of(context).size.width * 10) / 16,
      color: Colors.amber,
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          User("TOGNON Koffi Ange", "2s", "D'accord, j'arrive."),
          Divider(),
          h(10),
          User("Carrine DOSSOU", "1h", "Oui, ne t'inquiètes pas."),
        ],
      ),
    );
  }

  User(String name, time, msg) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              image: DecorationImage(
                  image: AssetImage("assets/images/ange.jpg"),
                  fit: BoxFit.cover)),
        ),
        w(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: (MediaQuery.of(context).size.width * 2.2) / 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(color: mainColor, fontFamily: 'bold'),
                  ),
                  Text(
                    time,
                    style: TextStyle(fontFamily: 'bold', color: mainColor),
                  )
                ],
              ),
            ),
            h(5),
            Text(
              msg,
              style: TextStyle(
                  color: Color.fromARGB(91, 0, 0, 0), fontFamily: 'normal'),
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
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              image: DecorationImage(
                  image: AssetImage("assets/images/ange.jpg"),
                  fit: BoxFit.cover)),
        ),
        w(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: (MediaQuery.of(context).size.width * 2.2) / 16,
              child: Text(
                name,
                style: TextStyle(color: Colors.black, fontFamily: 'bold'),
              ),
            ),
            h(5),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  minRadius: 8,
                ),
                w(10),
                Text(
                  state,
                  style: TextStyle(
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
