import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:club_hub/Screens/pagechange.dart';
//import 'package:club_hub/utilites/bottombar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IconButton(
        icon: Icon(FontAwesomeIcons.ggCircle),
        onPressed: () {
          PageChange c = PageChange();
        },
      ),
    );
  }
}
