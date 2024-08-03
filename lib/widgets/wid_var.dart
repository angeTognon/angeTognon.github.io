import 'package:flutter/material.dart';

h(double h) {
  return SizedBox(
    height: h,
  );
}

w(double w) {
  return SizedBox(
    width: w,
  );

}
Color txtDesc = const Color.fromARGB(166, 0, 0, 0);
Color mainColor = Color.fromARGB(255, 7, 65, 173);
Color mainColor__ = Color.fromARGB(16, 7, 65, 173);
Color amainColor__ = Color.fromARGB(16, 7, 65, 173);
Color mainColor2__ = Color.fromARGB(255, 7, 65, 173);
// Color mainColor = Color.fromARGB(255, 0, 136, 20);
Color mainColor2 = Color.fromARGB(216, 42, 116, 100);//Color.fromARGB(73, 42, 116, 100)
Color mainColor3 = Color.fromARGB(73, 42, 116, 100);//
Color mainColor4 = Color.fromARGB(33, 42, 116, 100);//
Color mainColor5 = Color.fromARGB(255, 7, 65, 173);//

MAB(BuildContext context){
  return AppBar(
    backgroundColor: Color.fromARGB(255, 42, 116, 100),
    title: Text("PharmaRH",style: TextStyle(color: Colors.white, fontSize: 20 ,fontFamily: 'bold',),),
    actions: [
      Text("Aide",style: TextStyle(color: Colors.white, fontFamily: 'normal',),),
      w(15),
      CircleAvatar(backgroundColor: Color.fromARGB(255, 255, 255, 255),
      child: Image.asset("assets/images/notif_icon.png"),
      ),
      w(15)
    ],
  );
}