import 'package:club_hub/Screens/bookingHistory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:club_hub/Admin/adminPanel.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LeftAppDraw extends StatefulWidget {
  bool isAdmin;
  LeftAppDraw({required this.isAdmin});
  @override
  _LeftAppDrawState createState() => _LeftAppDrawState();
}

class _LeftAppDrawState extends State<LeftAppDraw> {
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Drawer(
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => BookingHistory()));
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
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () async {
                setState(() {
                  showSpinner = true;
                });
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.popUntil(context, (route) => route.isFirst);
                  setState(() {
                    showSpinner = false;
                  });
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
