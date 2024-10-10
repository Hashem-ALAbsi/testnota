import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:testnota/Screens/auth/login.dart';
import 'package:testnota/Screens/auth/singin.dart';
import 'package:testnota/Screens/homepage.dart';
import 'package:testnota/controller/dependecy_injection.dart';
import 'package:testnota/controller/network_controller.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'firebase_options.dart';

void main() async {
  DependecyInjection.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final InternetConnectionChecker _internetConnectionChecker =
      InternetConnectionChecker();
  bool hasinternet = false;
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('================User is currently signed out!');
      } else {
        print('===============User is signed in!');
      }
    });
    super.initState();
    checkConnectivity();
    // checknet();
  }

  void checknet() {
    _internetConnectionChecker.onStatusChange.listen((event) {
      final hasinternet = event == InternetConnectionStatus.connected;
      setState(() {
        this.hasinternet = hasinternet;
      });
      if (hasinternet == false) {
        Get.rawSnackbar(
            messageText: const Text(
              "Please Connect To INTERNET ===",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            isDismissible: false,
            duration: const Duration(days: 1),
            backgroundColor: Colors.red[400]!,
            icon: const Icon(
              Icons.wifi_off,
              color: Colors.white,
              size: 35,
            ),
            margin: EdgeInsets.zero,
            snackStyle: SnackStyle.GROUNDED);
      } else {
        if (Get.isSnackbarOpen) {
          Get.closeCurrentSnackbar();
        }
      }
      print(hasinternet);
    });
  }

  void checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();

    print(result.name);
    // print(ree);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null ? fmlogin() : homepage(),
      routes: {
        "homepage": ((context) => homepage()),
        "fmlogin": ((context) => fmlogin()),
        "fmsingin": ((context) => fmsingin()),
      },
    );
  }
}
