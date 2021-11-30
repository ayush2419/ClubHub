import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_hub/Screens/bookingpage2.dart';
import 'package:club_hub/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookingHistory extends StatefulWidget {
  @override
  _BookingHistoryState createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: darkPurple,
        title: Text('Your Bookings'),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.fromLTRB(40.0, 50.0, 40.0, 50.0),
          child: Column(
            children: [
              StreamBuilder(
                  stream: firebaseFirestore
                      .collection('Users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('Bookings')
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
                            color: purple,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          height: 100.0,
                          child: Column(
                            children: [
                              Text(
                                document['Sport'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.date_range,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        document['Date'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.watch_later_outlined,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        document['Time'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    );
                    // return ListView.builder(itemBuilder: itemBuilder)(
                  })
            ],
          ),
        ),
      ),
    );
  }
}
