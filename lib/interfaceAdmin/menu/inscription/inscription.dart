import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zth_app/interfaceAdmin/menu/connexion/login.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'package:http/http.dart' as http;

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final _formKey = GlobalKey<FormState>();
  final nomPrenomController = TextEditingController();
  final emailController = TextEditingController();
  final numController = TextEditingController();
  final villeController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordController2 = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isPasswordVisible2 = false;
  bool show = false;

  /*  */

  inscription() async {
    setState(() {
      show = true;
    });
    // EncryptData(mpController.text);
    var url =
        "https://zoutechhub.com/pharmaRh/inscription.php?nomPrenom=${nomPrenomController.text}&email=${emailController.text}&tel=${numController.text}&ville=${villeController.text}&mp=${passwordController.text}&typeCompte=admin&photo=d";
    var response = await http.post(Uri.parse(url));
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');
    if (response.body == "OK") {
      setState(() {
        show = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 18, 133, 22),
          content: Text(
            "Inscription Réussie. Veuillez vous connecter maintenant",
            style: TextStyle(
                fontFamily: 'normal',
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
          (route) => false);
    } else {
      setState(() {
        show = false;
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
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      h(130),
                      const Text(
                        "PharmaRH",
                        style: TextStyle(
                            color: Color.fromARGB(255, 38, 205, 0),
                            fontFamily: 'bold',
                            fontSize: 60),
                      ),
                      h(20),
                      const Text(
                        "Gérez votre équipe avec soin,\ncomme vos médicaments.",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'bold',
                            fontSize: 25),
                      ),
                      h(50),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: const Text(
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
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, bottom: 10, top: 10),
                  decoration: const BoxDecoration(
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
                        SizedBox(
                            height: 200,
                            width: 200,
                            child: Lottie.asset("assets/images/doc.json")),
                        Container(
                          child: const Text(
                            "Création d'un compte",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'bold',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          child: TextFormField(
                            controller: nomPrenomController,
                            decoration: InputDecoration(
                              labelText: 'Nom et Prénom',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              labelStyle: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'bold',
                                  color: Color(0xCD000000)),
                            ),
                          ),
                        ),
                        h(20),
                        Container(
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              labelStyle: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'bold',
                                  color: Color(0xCD000000)),
                            ),
                          ),
                        ),
                        h(20),
                        Container(
                          child: TextFormField(
                            controller: numController,
                            decoration: InputDecoration(
                              labelText: 'Numéro de Téléphone',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              labelStyle: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'bold',
                                  color: Color(0xCD000000)),
                            ),
                          ),
                        ),
                        h(20),
                        Container(
                          child: TextFormField(
                            controller: villeController,
                            decoration: InputDecoration(
                              labelText: 'Ville',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              labelStyle: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'bold',
                                  color: Color(0xCD000000)),
                            ),
                          ),
                        ),
                        h(20),
                        TextFormField(
                          controller: passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Mot de passe',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            labelStyle: const TextStyle(
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre mot de passe';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: passwordController2,
                          obscureText: !_isPasswordVisible2,
                          decoration: InputDecoration(
                            labelText: 'Confirmez à nouveau Votre Mot de passe',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            labelStyle: const TextStyle(
                                fontSize: 13,
                                fontFamily: 'bold',
                                color: Color(0xCD000000)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: _isPasswordVisible2
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible2 = !_isPasswordVisible2;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre mot de passe';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        show
                            ? Center(
                                child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: const CircularProgressIndicator()))
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (nomPrenomController.text.isEmpty ||
                                          emailController.text.isEmpty ||
                                          numController.text.isEmpty ||
                                          villeController.text.isEmpty ||
                                          passwordController.text.isEmpty ||
                                          passwordController2.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor: Color.fromARGB(
                                                    255, 135, 28, 20),
                                                content: Text(
                                                  "Veuillez remplir tous les champs",
                                                  style: TextStyle(
                                                      fontFamily: 'normal'),
                                                )));
                                        //login();
                                      } else {
                                        inscription();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: mainColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12.0),
                                      child: Text(
                                        "S'inscrire",
                                        style: TextStyle(
                                            fontFamily: 'bold',
                                            fontSize: 15,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(height: 16.0),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Login(),
                            ));
                          },
                          child: const Text(
                            "Vous avez déjà un compte ? Connectez-vous",
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
