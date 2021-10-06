import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_hub/Screens/pagechange.dart';
import 'package:flutter/material.dart';
import 'package:club_hub/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _email = TextEditingController();
  late TextEditingController _password = TextEditingController();
  late TextEditingController _confirmPassword = TextEditingController();
  late TextEditingController _phone = TextEditingController();
  late TextEditingController _fullName = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
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
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 30.0),
                    TextField(
                      controller: _fullName,
                      keyboardType: TextInputType.name,
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
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter value';
                        }
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
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter value';
                        }
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
                    TextFormField(
                      obscureText: true,
                      controller: _password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter value';
                        }
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
                    TextFormField(
                      obscureText: true,
                      controller: _confirmPassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter value';
                        }
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
                  onPressed: () async {
                    if (_password.text != _confirmPassword.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Passwords dont match'),
                        ),
                      );
                    } else {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        await _auth.createUserWithEmailAndPassword(
                            email: _email.text, password: _password.text);
                        Map<String, dynamic> data = <String, dynamic>{
                          "Name": _fullName.text,
                          "Phone": _phone.text,
                          "Email": _email.text,
                          "isMember": false,
                        };

                        await firebaseFirestore
                            .collection('Users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set(data);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PageChange(
                              isAdmin: false,
                            ),
                          ),
                        );
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    }
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
      ),
    );
  }
}
