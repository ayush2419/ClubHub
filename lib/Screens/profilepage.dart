import 'package:club_hub/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'bookingpage2.dart';

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

    print(_username);
    print(_phone);
    print(_userEmail);
    print(_isMember);
  }

  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
              width: double.infinity,
            ),
          ClipOval(
            child: Image.asset(
              'assets/profile.jpg',
              height: 360,
              width: 360,
            ),
          ),
          SizedBox(height: 20,),
          ProfileCard(text: "Name: $_username"),
          ProfileCard(text: "Email: $_userEmail"),
          ProfileCard(text: "Phone: $_phone")
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required String? text,
  }) : _text = text, super(key: key);

  final String? _text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Color(0xFFb3c8ff),
          child: InkWell(
            onTap: (){},
            borderRadius: BorderRadius.circular(15),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  _text!,
                  style: memberTextStyle.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
