import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_hub/Screens/bookingpage2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class AdminBookingList extends StatefulWidget {
  String date;
  String time;
  String docId;

  String sportName;
  AdminBookingList(
      {required this.date,
      required this.sportName,
      required this.time,
      required this.docId});

  @override
  _AdminBookingListState createState() => _AdminBookingListState();
}

class _AdminBookingListState extends State<AdminBookingList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.date}  : ${widget.time}'),
        backgroundColor: purple,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.fromLTRB(40.0, 50.0, 40.0, 50.0),
          child: Column(
            children: [
              StreamBuilder(
                stream: firebaseFirestore
                    .collection(widget.sportName)
                    .doc(widget.docId)
                    .collection(widget.time)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: snapshot.data!.docs.map((document) {
                      return Container(
                        decoration: BoxDecoration(
                          color: tileColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        height: 80.0,
                        child: Column(
                          children: [
                            Text(
                              'Name :  ${document['Name']}',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      document['Contact no'],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
