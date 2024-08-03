import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zth_app/interfaceAdmin/home.dart';
import 'package:zth_app/interfaceAdmin/menu/inscription/inscription.dart';
import 'package:zth_app/main.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool show = false;

/* Future<void> login() async {
  setState(() {
    show = true; // Assuming 'show' controls a loading indicator
  });

  var url = "https://zoutechhub.com/pharmaRh/login.php?email=&mp=";

  try {
    print("*********************");

    final response = await http.post(Uri.parse(url), body: {"username": "your_username", "password": "your_password"});
    if (response.statusCode == 200) {
      // Handle successful login (e.g., navigate to a different screen)
      print("Login successful!");
    } else {
      // Handle login failure (e.g., display an error message)
      print("Login failed with status code: ${response.statusCode}");
    }
  } catch (error) {
    // Handle network or other errors
    print("Error during login: $error");
  } finally {
    setState(() {
      show = false; // Hide the loading indicator
    });
  }
} */

  login() async {
    setState(() {
      show = true;
    });
    //print("coucou");

    var url = "https://zoutechhub.com/pharmaRh/connexion.php";
    var response = await http.post(Uri.parse(url),
        body: {'email': _emailOrPhoneController.text, 'mp': _passwordController.text});

    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    var data = json.decode(response.body);
    //print(data);
    if (data == "Success") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 3, 78, 5),
        content: Text("Connexion Réussie"),
      ));
      final prefs = await SharedPreferences.getInstance();
      eya = true;
      prefs.setBool('isConnected', eya);

      user_email = _emailOrPhoneController.text;

      final userPref = await SharedPreferences.getInstance();

      userPref.setString('email', _emailOrPhoneController.text);
      show = false;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
          (route) => false);
    } else {
      setState(() {
        show = false;
      });
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Attention"),
          content: Text(
              "L'email ou le mot de passe n'existe pas ! Veuillez réessayer"),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text("Ok"))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: mainColor2__,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.all(50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      h(130),
                      Text(
                        "PharmaRH",
                        style: TextStyle(
                            color: Color.fromARGB(255, 38, 205, 0),
                            fontFamily: 'bold',
                            fontSize: 60),
                      ),
                      h(20),
                      Text(
                        "Gérez votre équipe avec soin,\ncomme vos médicaments.",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'bold',
                            fontSize: 25),
                      ),
                      h(50),
                      Container(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: Text(
                            "Pharma HR est la solution de gestion des ressources humaines conçue sur-mesure pour les pharmacies. Gérez efficacement les fiches de paie, les congés, les formations et bien plus encore, le tout dans une interface intuitive. Restez concentré sur vos patients, laissez Pharma HR s'occuper de vos employés",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'normal',
                                fontSize: 18),
                          ))
                    ],
                  ),
                  // child : Image.asset("assets/images/login.jpg")
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 40, right: 40, bottom: 0, top: 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          bottomLeft: Radius.circular(40))),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                            height: 400,
                            width: 400,
                            child: Lottie.asset("assets/images/doc.json")),
                        Container(
                          child: Text(
                            'Connectez-vous à votre Compte',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'bold',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          child: TextFormField(
                            controller: _emailOrPhoneController,
                            decoration: InputDecoration(
                              labelText: 'Votre Adresse Email',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              labelStyle: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'bold',
                                  color: Color(0xCD000000)),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Mot de passe',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            labelStyle: TextStyle(
                                fontSize: 13,
                                fontFamily: 'bold',
                                color: Color(0xCD000000)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: _isPasswordVisible
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        show
                            ? Center(
                                child: Container(
                                    height: 60,
                                    width: 60,
                                    child: CircularProgressIndicator()))
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      login();
                                      /*  if (_emailOrPhoneController
                                              .text.isEmpty ||
                                          _passwordController.text.isEmpty) {
                                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          backgroundColor: const Color.fromARGB(255, 135, 28, 20),
                                          content: Text("Veuillez remplir tous les champs",style: TextStyle(fontFamily: 'normal'),)));
                                      } else {
                                        login();
                                      } */
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12.0),
                                      child: Text(
                                        'Se connecter',
                                        style: TextStyle(
                                            fontFamily: 'bold',
                                            fontSize: 15,
                                            color: Colors.white),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: mainColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed('/forgot-password');
                            },
                            child: Text(
                              'Mot de passe oublié?',
                              style: TextStyle(
                                  fontFamily: 'regular',
                                  color: Colors.black,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Inscription(),
                            ));
                          },
                          child: Text(
                            'Vous n\'avez pas de compte ? Inscrivez-vous',
                            style: TextStyle(
                                fontFamily: 'regular',
                                color: Colors.black,
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
