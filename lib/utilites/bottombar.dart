import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  //Function to show selected page on bottom bar
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'Home',
          backgroundColor: Color(0xFFb3c8ff),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.calendarCheck,
          ),
          label: 'Book',
          backgroundColor: Color(0xFFb3c8ff),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.rupeeSign,
          ),
          label: 'Membership',
          backgroundColor: Color(0xFFb3c8ff),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.user,
          ),
          label: 'Profile',
          backgroundColor: Color(0xFFb3c8ff),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Color(0xFF425DF3),
      onTap: _onItemTapped,
    );
  }
}
