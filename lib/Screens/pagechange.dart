import 'package:club_hub/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:club_hub/Screens/homepage.dart';
import 'package:club_hub/Screens/profilepage.dart';
import 'package:club_hub/Screens/membershippage.dart';
import 'package:club_hub/Screens/bookingpage.dart';
import 'package:club_hub/utilites/scrollphysics.dart';
import 'package:club_hub/utilites/drawer.dart';

class PageChange extends StatefulWidget {
  bool? isAdmin;
  PageChange({required this.isAdmin});
  @override
  _PageChangeState createState() => _PageChangeState();
}

class _PageChangeState extends State<PageChange> {
  PageController _pageController = PageController();

  //List of Screens in PageView
  List<Widget> _screens = [
    HomePage(),
    BookingPage(),
    MembershipPage(),
    ProfilePage(),
  ];

  //Gives the current screen index (integer value)
  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //Action for tapping the item on the bottom bar
  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  //Function for setting the AppBar Title
  String setAppBarName(_selectedIndex) {
    if (_selectedIndex == 0)
      return 'ClubHub';
    else if (_selectedIndex == 1)
      return 'Booking';
    else if (_selectedIndex == 2)
      return 'Membership';
    else
      return 'Profile';
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          setAppBarName(_selectedIndex),
          style: TextStyle(fontSize: 25.00, color: darkPurple),
        ),
        backgroundColor: Color(0xFFb3c8ff),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(FontAwesomeIcons.bars),
            color: Colors.black,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          Icon(
            FontAwesomeIcons.ellipsisV,
            color: Colors.black,
          ),
          SizedBox(
            width: 15.00,
          ),
        ],
      ),
      drawer: LeftAppDraw(
        isAdmin: widget.isAdmin!,
      ),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: const CustomPageViewScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF425DF3),
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
            label: 'Booking',
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
      ),
    );
  }
}
