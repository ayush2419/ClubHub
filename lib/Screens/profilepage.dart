import 'package:club_hub/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'bookingpage2.dart';
import 'package:club_hub/utilites/profilecard.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showSpinner = false;
  late String? _username = '';
  late String? _phone = '';
  late String? _userEmail = '';
  late bool _isMember = true;
  void _getUserDetails() async {
    setState(() {
      showSpinner = true;
    });
    try {
      await firebaseFirestore
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((data) {
        setState(() {
          this._username = data.data()!['Name'];
          this._phone = data.data()!['Phone'];
          this._userEmail = data.data()!['Email'];
          this._isMember = data.data()!['isMember'];
        });
      });
      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      print(e);
    }

    // print(_username);
    // print(_phone);
    // print(_userEmail);
    // print(_isMember);
  }

  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                height: 70,
              ),
              _isMember
                  ? CircleAvatar(
                      radius: 102,
                      backgroundColor: Colors.green,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/profile.jpg'),
                        radius: 100,
                      ),
                    )
                  : CircleAvatar(
                      radius: 102,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/profile.jpg'),
                        radius: 100,
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              ProfileCard(text: "Name: $_username"),
              ProfileCard(text: "Email: $_userEmail"),
              ProfileCard(text: "Phone: $_phone")
            ],
          ),
        ),
      ),
    );
  }
}
