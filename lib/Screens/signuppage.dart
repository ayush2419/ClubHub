import 'package:club_hub/Screens/pagechange.dart';
import 'package:flutter/material.dart';
import 'package:club_hub/constants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String _email;
  late String _password;
  late String _phone;
  late String _fullName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'ClubHub',
          style: TextStyle(fontSize: 25.0, color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0.0,
        toolbarHeight: 50.0,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 80.0),
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Text(
                    'Create an account',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 30.0),
                  TextField(
                    onChanged: (value) {
                      this._fullName = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: purple,
                        ),
                      ),
                      focusedErrorBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: purple,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Full Name",
                    ),
                  ),
                  SizedBox(height: 30.0),
                  TextField(
                    onChanged: (value) {
                      this._email = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: purple,
                          ),
                        ),
                        focusedErrorBorder: new OutlineInputBorder(
                          borderSide: new BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: purple,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        hintText: "Email ",
                        helperText: 'Enter valid email-id'),
                  ),
                  SizedBox(height: 30.0),
                  TextField(
                    onChanged: (value) {
                      this._phone = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: purple,
                        ),
                      ),
                      focusedErrorBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: purple,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Phone no",
                    ),
                  ),
                  SizedBox(height: 30.0),
                  TextField(
                    obscureText: true,
                    onChanged: (value) {
                      this._password = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: purple,
                        ),
                      ),
                      focusedErrorBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: purple,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "password",
                      helperText: 'Enter password',
                    ),
                  ),
                  SizedBox(height: 30.0),
                  TextField(
                    obscureText: true,
                    onChanged: (value) {
                      this._password = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: purple,
                        ),
                      ),
                      focusedErrorBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: purple,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Confirm password",
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              child: MaterialButton(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PageChange(),
                    ),
                  );
                },
                minWidth: MediaQuery.of(context).size.width,
                color: purple,
                height: 50.0,
                child: Text(
                  'SIGNUP',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
