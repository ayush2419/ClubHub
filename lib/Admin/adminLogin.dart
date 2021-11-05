import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import 'adminPanel.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController orgCodeController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String orgCode = 'CLUB50';
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purple,
      appBar: AppBar(
        backgroundColor: purple,
        title: Text(
          'Admin Panel',
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
          child: Column(
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
                    TextFormField(
                      controller: emailController,
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
                        labelText: "Email",
                      ),
                    ),
                    SizedBox(height: 30.0),
                    TextFormField(
                      obscureText: true,
                      controller: passwordController,
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
                        labelText: "password",
                      ),
                    ),
                    SizedBox(height: 30.0),
                    TextFormField(
                      controller: orgCodeController,
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
                        labelText: "Org code",
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
                        if (emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Enter all fields'),
                          ));
                        } else {
                          if (orgCode != orgCodeController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Invalid Credentials'),
                            ));
                          } else {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              final user =
                                  await _auth.signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text);

                              if (user.toString() != 'null') {
                                print(user);
                                print('Signed In successfully!!!');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AdminPanel()),
                                );
                              }
                              setState(() {
                                showSpinner = false;
                              });
                            } catch (e) {
                              print(e);
                            }
                          }
                        }
                      },
                      minWidth: MediaQuery.of(context).size.width,
                      color: backgroundColor,
                      height: 50.0,
                      child: Text(
                        'LOGIN',
                        style: TextStyle(color: purple),
                      ),
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
}
