import 'package:club_hub/Screens/adminPanel.dart';
import 'package:club_hub/Screens/bookingHistory.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LeftAppDraw extends StatefulWidget {
  bool isAdmin;
  LeftAppDraw({required this.isAdmin});
  @override
  _LeftAppDrawState createState() => _LeftAppDrawState();
}

class _LeftAppDrawState extends State<LeftAppDraw> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFb3c8ff),
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.calendarCheck,
            ),
            title: const Text('Booking History'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => BookingHistory()));
            },
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.rupeeSign,
            ),
            title: const Text('Membership'),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.user,
            ),
            title: const Text('Profile'),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.pop(context);
            },
          ),
          Visibility(
            visible: widget.isAdmin,
            child: ListTile(
              leading: Icon(
                Icons.admin_panel_settings,
              ),
              title: const Text('Admin'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AdminPanel()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
