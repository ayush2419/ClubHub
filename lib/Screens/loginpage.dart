import 'dart:ui';
import 'package:club_hub/Admin/adminLogin.dart';
import 'package:club_hub/Screens/introductionPage.dart';
import 'package:club_hub/Screens/pagechange.dart';
import 'package:club_hub/Screens/signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:club_hub/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email;
  late String _password;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: purple,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AdminLogin()));
              },
              icon: Icon(Icons.admin_panel_settings))
        ],
        title: Text(
          'ClubHub',
          style: TextStyle(fontSize: 25.0),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 50.0,
        bottomOpacity: 0,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2.5,
                      color: purple,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: purple,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(700),
                          bottomLeft: Radius.circular(700),
                        ),
                      ),
                      height: MediaQuery.of(context).size.height / 5,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.fromLTRB(30.0, 150.0, 30.0, 100.0),
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Text(
                          'Log In',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.w500),
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
                              hintText: "Email / Phone",
                              helperText: 'Enter email / phone'),
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
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30.0),
                        child: MaterialButton(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              final user =
                                  await _auth.signInWithEmailAndPassword(
                                      email: _email, password: _password);

                              if (user != null) {
                                print(user);
                                print('Signed In successfully!!!');
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (_) => PageChange(
                                //       isAdmin: false,
                                //     ),
                                //   ),
                                // );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => IntroductionPage(),
                                  ),
                                );
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          minWidth: MediaQuery.of(context).size.width,
                          color: purple,
                          height: 50.0,
                          child: Text(
                            'LOGIN',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, './signup');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
