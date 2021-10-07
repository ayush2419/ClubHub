import 'package:club_hub/Screens/bookingpage2.dart';
import 'package:club_hub/Screens/onboardingpage.dart';
import 'package:club_hub/Screens/pagechange.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/homepage.dart';
import 'Screens/loginpage.dart';
import 'Screens/bookingpage.dart';
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
      // home: BookingPage2(sportName: 'Badminton'),
      // home: PageChange(),
      // home: SignUpPge(),
      home: LoginPage(),
      // home: AdminScreen(),
      //home: BookingPage(),
    );
  }
}
