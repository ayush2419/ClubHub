import 'dart:ui';
import 'package:club_hub/Admin/adminLogin.dart';
import 'package:club_hub/Screens/introductionPage.dart';
import 'package:club_hub/Screens/pagechange.dart';
import 'package:club_hub/Screens/signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:club_hub/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email;
  late String _password;
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool showSpinner = false;

  @override
  String _errorMessage = '';
  String _passCheck = "";
  String helpTextEmail = "Enter email";
  String helpTextPassword = "Enter password";
  Widget build(BuildContext context) {
    double maxHeight =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.longestSide
            : MediaQuery.of(context).size.longestSide +
                MediaQuery.of(context).padding.top;
    // print(maxHeight);
    // print("tb height $kToolbarHeight");
    // print("bottom height$kBottomNavigationBarHeight");
    // print(MediaQuery.of(context).padding.top);
    // print(MediaQuery.of(context).size.aspectRatio);
    // print(MediaQuery.of(context).size.shortestSide);
    // print(MediaQuery.of(context).size.height);
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: maxHeight / 2.5,
                        // height: maxHeight / 2.5,
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
                        height: maxHeight / 5,
                        // height: maxHeight / 5,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    // height: maxHeight/ 2.5,
                    height: maxHeight / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.fromLTRB(30.0, 150.0, 30.0, 100.0),
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Log In',
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                              // height: 30.0,
                              ),
                        ),
                        Expanded(
                          flex: 5,
                          child: TextField(
                            onChanged: (value) {
                              this._email = value;
                              validateEmail(_email);
                              setState(() {
                                helpTextEmail = '';
                              });
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
                              hintText: "Email",
                              helperText: helpTextEmail,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                              // height: 30.0,
                              ),
                        ),
                        Expanded(
                          flex: 5,
                          child: TextField(
                            obscureText: true,
                            onChanged: (value) {
                              this._password = value;
                              if (value.isEmpty) {
                                _passCheck = "Please enter the Password";
                              }
                              setState(() {
                                helpTextPassword = "";
                              });
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
                              hintText: "Password",
                              helperText: helpTextPassword,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    child: MaterialButton(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        if (_errorMessage != "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(_errorMessage),
                              backgroundColor: Colors.red,
                            ),
                          );
                          setState(() {
                            showSpinner = false;
                          });
                        } else if (_passCheck != "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(_passCheck),
                              backgroundColor: Colors.red,
                            ),
                          );
                          setState(() {
                            showSpinner = false;
                          });
                        } else {
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
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
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text(
                                          'Oops! User with that email id Not Found'),
                                      actions: [
                                        TextButton(
                                          child: Text("Ok"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            setState(() {
                                              showSpinner = false;
                                            });
                                          },
                                        )
                                      ],
                                    );
                                  });
                            } else if (e.code == 'invalid-email') {
                              print('No user found for that email.');
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text(
                                          "Please enter a correct email id"),
                                      actions: [
                                        TextButton(
                                          child: Text("Ok"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            setState(() {
                                              showSpinner = false;
                                            });
                                          },
                                        )
                                      ],
                                    );
                                  });
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text('Wrong password'),
                                      actions: [
                                        TextButton(
                                          child: Text("Ok"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            setState(() {
                                              showSpinner = false;
                                            });
                                          },
                                        )
                                      ],
                                    );
                                  });
                            }
                          }
                        }
                        // catch (e) {
                        //   print(e);
                        // }
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
        ),
      ),
    );
  }

  void validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Email can not be empty";
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage = "Invalid Email Address";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }
}
