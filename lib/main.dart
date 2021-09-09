import 'package:club_hub/Screens/onboardingpage.dart';
import 'package:flutter/material.dart';
// import 'Screens/homepage.dart';
// import 'Screens/profilepage.dart';
// import 'Screens/bookingpage.dart';
// import 'Screens/membershippage.dart';
// import 'Screens/loginpage.dart';
// import 'Screens/signuppage.dart';
//import 'package:club_hub/Screens/pagechange.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingPage(),
    );
  }
}
