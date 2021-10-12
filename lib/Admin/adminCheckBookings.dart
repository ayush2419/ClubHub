import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_hub/Admin/adminBookingList.dart';
import 'package:club_hub/Screens/bookingpage2.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';

class AdminCheckBooking extends StatefulWidget {
  @override
  _AdminCheckBookingState createState() => _AdminCheckBookingState();
}

class _AdminCheckBookingState extends State<AdminCheckBooking> {
  final sportsList = [
    'Football',
    'Lawn Tennis',
    'Swimming',
    'Volleyball',
    'Basketball',
    'Archery',
    'Golf',
    'E-Sports'
  ];
  final sportImageList = [
    'assets/Football_background.jfif',
    'assets/LawnTennis.jfif',
    'assets/Swimming.jfif',
    'assets/Volleyball.jfif',
    'assets/Basketball.jfif',
    'assets/Archery.jfif',
    'assets/Golf.jfif',
    // 'assets/Gym.jpg',
    'assets/Egames.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purple,
        title: Text('Check Bookings'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Container(
          margin: EdgeInsets.fromLTRB(60.0, 0, 60.0, 40.0),
          child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: sportsList.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: AssetImage(sportImageList[index]),
                      fit: BoxFit.fill),
                ),
                margin: EdgeInsets.symmetric(vertical: 10.0),
                height: 100.0,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AdminSelectDateAndTime(
                                  sportName: sportsList[index]),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              sportsList[index],
                              style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class AdminSelectDateAndTime extends StatefulWidget {
  String sportName;
  AdminSelectDateAndTime({required this.sportName});

  @override
  _AdminSelectDateAndTimeState createState() => _AdminSelectDateAndTimeState();
}

class _AdminSelectDateAndTimeState extends State<AdminSelectDateAndTime> {
  bool showSpinner = false;
  late String selectedDocument = '';
  bool is10_11Selected = false;
  bool is11_12Selected = false;
  bool is12_1Selected = false;
  bool is1_2Selected = false;
  bool is2_3Selected = false;
  bool is3_4Selected = false;
  late String? selectedDate = '';
  late String? selectedTime = '';

  String? docID;

  void loadDocumentID() async {
    await firebaseFirestore
        .collection(widget.sportName)
        .where('date', isEqualTo: this.selectedDate)
        .get()
        .then((snapshot) => this.docID = snapshot.docs[0].id);

    print(docID);
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.sportName,
            ),
            backgroundColor: purple,
          ),
          body: Container(
            margin: EdgeInsets.only(bottom: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Date',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: darkPurple,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          StreamBuilder(
                            stream: firebaseFirestore
                                .collection(widget.sportName)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return GridView.count(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                crossAxisCount: 5,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 1,
                                crossAxisSpacing: 10.0,
                                children: snapshot.data!.docs.map((document) {
                                  return GestureDetector(
                                    child: dateSelector(
                                        document['date'], document.id),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Select timing',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: darkPurple,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GridView.count(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            crossAxisCount: 5,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 1,
                            crossAxisSpacing: 10.0,
                            children: [
                              slotSelector('10-11', is10_11Selected),
                              slotSelector('11-12', is11_12Selected),
                              slotSelector('12-1', is12_1Selected),
                              slotSelector('1-2', is1_2Selected),
                              slotSelector('2-3', is2_3Selected),
                              slotSelector('3-4', is3_4Selected),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  height: 50.0,
                  onPressed: () async {
                    if (selectedDate == '' || selectedTime == '') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Select Date and Time'),
                      ));
                    } else {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        // await Future.delayed(Duration(seconds: 1));

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AdminBookingList(
                                    date: this.selectedDate!,
                                    time: this.selectedTime!,
                                    docId: this.docID!,
                                    sportName: widget.sportName)));
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  color: purple,
                  child: Text(
                    'Check Bookings',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  GestureDetector dateSelector(String date, String documentID) {
    return GestureDetector(
      onTap: () async {
        setState(
          () {
            this.selectedDate = date;
            print(selectedDate);
            this.selectedDocument = documentID;
          },
        );
        loadDocumentID();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: selectedDocument == documentID ? darkPurple : tileColor,
            width: 2,
          ),
          color: selectedDocument == documentID ? purple : backgroundColor,
        ),
        child: Center(
          child: Text(
            date,
            style: TextStyle(
                color: selectedDocument == documentID
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      ),
    );
  }

  GestureDetector slotSelector(String timeSlot, selectedValue) {
    return GestureDetector(
      onTap: () async {
        setState(
          () {
            this.selectedTime = timeSlot;
            if (timeSlot == '10-11') {
              this.is10_11Selected = !is10_11Selected;
              if (this.is10_11Selected) {
                this.is11_12Selected = false;
                this.is12_1Selected = false;
                this.is1_2Selected = false;
                this.is2_3Selected = false;
                this.is3_4Selected = false;
              }
            }
            if (timeSlot == '11-12') {
              this.is11_12Selected = !is11_12Selected;
              if (this.is11_12Selected) {
                this.is10_11Selected = false;
                this.is12_1Selected = false;
                this.is1_2Selected = false;
                this.is2_3Selected = false;
                this.is3_4Selected = false;
              }
            }
            if (timeSlot == '12-1') {
              this.is12_1Selected = !is12_1Selected;
              if (this.is12_1Selected) {
                this.is10_11Selected = false;
                this.is11_12Selected = false;
                this.is1_2Selected = false;
                this.is2_3Selected = false;
                this.is3_4Selected = false;
              }
            }
            if (timeSlot == '1-2') {
              this.is1_2Selected = !is1_2Selected;
              if (this.is1_2Selected) {
                this.is11_12Selected = false;
                this.is12_1Selected = false;
                this.is10_11Selected = false;
                this.is2_3Selected = false;
                this.is3_4Selected = false;
              }
            }
            if (timeSlot == '2-3') {
              this.is2_3Selected = !is2_3Selected;
              if (this.is2_3Selected) {
                this.is10_11Selected = false;
                this.is11_12Selected = false;
                this.is12_1Selected = false;
                this.is1_2Selected = false;
                this.is3_4Selected = false;
              }
            }
            if (timeSlot == '3-4') {
              this.is3_4Selected = !is3_4Selected;
              if (this.is3_4Selected) {
                this.is10_11Selected = false;
                this.is11_12Selected = false;
                this.is12_1Selected = false;
                this.is1_2Selected = false;
                this.is2_3Selected = false;
              }
            }
            print(selectedTime);
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: selectedValue ? darkPurple : tileColor,
            width: 2,
          ),
          color: selectedValue ? purple : backgroundColor,
        ),
        child: Center(
          child: Text(
            timeSlot,
            style:
                TextStyle(color: selectedValue ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
