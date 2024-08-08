import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zth_app/interfaceAdmin/home.dart';
import 'package:zth_app/interfaceAdmin/menu/connexion/login.dart';
import 'package:zth_app/interfaceEmploy%C3%A9/home_employe.dart';
import 'package:zth_app/widgets/wid_var.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

bool isFirstRun = false;
bool isFirstCall = false;

String currentUserId = "";
bool eya = false;
bool clientC = false;
bool etatCompte = false;
String currentUserEmail = "";
String userName = "";
String imagPath = "";
String user_email = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefss = await SharedPreferences.getInstance();
  final isClient = prefss.getBool('isClient') ?? false;

  final prefsss = await SharedPreferences.getInstance();
  final isActivated = prefsss.getBool('isActivated') ?? false;

  final prefs = await SharedPreferences.getInstance();
  final isConnected = prefs.getBool('isConnected') ?? false;

  final userPref = await SharedPreferences.getInstance();
  user_email = userPref.getString('email') ?? "";

  final userNamePref = await SharedPreferences.getInstance();
  userName = userNamePref.getString('userName') ?? "";

  eya = isConnected;
  clientC = isClient;
  etatCompte = isActivated;
  runApp(Phoenix(child: MyApp(isConnected: isConnected)));
}

class MyApp extends StatefulWidget {
 final isConnected;
  MyApp({required this.isConnected});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
   // _loadThemeFromPreferences();
  }

  Future<void> _loadThemeFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  Future<void> _saveThemeToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _isDarkMode);
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    _saveThemeToPreferences();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor,),
        useMaterial3: true,
      ),
      home: Home()
    );
  }
}
