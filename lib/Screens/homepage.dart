import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:club_hub/Screens/pagechange.dart';
//import 'package:club_hub/utilites/bottombar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final sportsList = [
    'Football',
    'Lawn Tennis',
    'Swimming',
    'Volleyball',
    'Basketball',
    'Archery',
    'Golf',
    'E-Sports'
  ];
  final sportdata = [
    '11 vs 11 Turfs',
    'Hard court',
    'Olympic size pool',
    'Traditional Hardwood Courts',
    'Asphalt surface',
    '34.5m x 20.0m x. 7.5m halls',
    '18 Hole Arena',
    'Professional Arena'
  ];
  final sportImageList = [
    'assets/Football_background.jfif',
    'assets/LawnTennis.jfif',
    'assets/Swimming.jfif',
    'assets/Volleyball.jfif',
    'assets/Basketball.jfif',
    'assets/Archery.jfif',
    'assets/Golf.jfif',
    // 'assets/Gym.jpg',
    'assets/Egames.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: sportsList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: AssetImage(sportImageList[index]),
                      fit: BoxFit.fill),
                ),
                height: 200.0,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            sportsList[index],
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 10),
                          Text(
                            sportdata[index],
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white70,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
