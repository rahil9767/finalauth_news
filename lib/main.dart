
import 'package:finalauth_news/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'screens/signin_screen.dart';
import 'views/homepage.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoogedin = false;

  Future<void> getStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoogedin =  prefs.getBool('islogin') ?? false;
  }


  @override
  void initState() {
    getStorage();
    // TODO: implement initState
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoogedin ? HomePage() : SignInScreen(),
    );
  }
}




