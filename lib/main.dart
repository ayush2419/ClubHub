import 'package:club_hub/Screens/onboardingpage.dart';
import 'package:club_hub/Screens/pagechange.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'Screens/homepage.dart';
// import 'Screens/profilepage.dart';
// import 'Screens/bookingpage.dart';
// import 'Screens/membershippage.dart';
import 'Screens/bookingpage.dart';
import 'Screens/homepage.dart';
import 'Screens/loginpage.dart';
// import 'Screens/signuppage.dart';
import 'Screens/membershippage.dart';
import 'Screens/profilepage.dart';
import 'Screens/signuppage.dart';
import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: purple),
      //First Screen to be displayed when the App starts
      //initialRoute: '/home',

      //Routes of All pages(To be Modified)
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/booking': (context) => BookingPage(),
        '/profile': (context) => ProfilePage(),
        '/membership': (context) => MembershipPage(),
      },
      // home: PageChange(),
      home: LoginPage(),
    );
  }
}
