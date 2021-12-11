import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_hub/Screens/bookingpage.dart';
import 'package:club_hub/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class BookingPage2 extends StatefulWidget {
  late String sportName;
  BookingPage2({required this.sportName});
  @override
  _BookingPage2State createState() => _BookingPage2State();
}

class _BookingPage2State extends State<BookingPage2> {
  late List indexList = [];
  int? seats10_11, seats11_12, seats12_1, seats1_2, seats2_3, seats3_4;
  int seats = 0;
  bool is10_11Selected = false;
  bool is11_12Selected = false;
  bool is12_1Selected = false;
  bool is1_2Selected = false;
  bool is2_3Selected = false;
  bool is3_4Selected = false;
  bool _isMember = false;
  int cost = 0;
  bool showSpinner = false;
  late String selectedDocument = '';
  late String? selectedDate = '';
  late String? selectedTime = '';
  late String? _username;
  late String? _phone = '';
  late String? _userEmail = '';
  Map<String, dynamic>? map;

  Razorpay? _razorpay;

  void _getCurrentUser() async {
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
          if (this._isMember) {
            this.cost = 20;
          } else {
            this.cost = 150;
          }
        });
      });
    } catch (e) {
      print(e);
    }

    print(_username);
    print(_phone);
    print(_userEmail);
  }

  void _loadAvailableSeats() async {
    await firebaseFirestore
        .collection(widget.sportName)
        .where('date', isEqualTo: selectedDate)
        .get()
        .then((doc) => {map = doc.docs[0].data()});

    setState(() {
      this.seats10_11 = map!['10-11'];
      this.seats11_12 = map!['11-12'];
      this.seats12_1 = map!['12-1'];
      this.seats1_2 = map!['1-2'];
      this.seats2_3 = map!['2-3'];
      this.seats3_4 = map!['3-4'];

      if (selectedTime == '10-11') this.seats = seats10_11!;
      if (selectedTime == '11-12') this.seats = seats11_12!;
      if (selectedTime == '12-1') this.seats = seats12_1!;
      if (selectedTime == '1-2') this.seats = seats1_2!;
      if (selectedTime == '2-3') this.seats = seats2_3!;
      if (selectedTime == '3-4') this.seats = seats3_4!;
    });

    // seats10_11 = map!['10-11'];
    // print(seats10_11);
  }

  void _openCheckout() {
    var options = {
      'key': 'rzp_test_9Kjyiz2qW5U3Y0',
      'amount': this.cost * 100, // enter amount
      'name': this._username,
      'description': 'Payment for the sport',
      'prefill': {
        'contact': this._phone,
        'email': this._userEmail,
      },
      'external': {
        'wallets': ['paytm']
      },
    };
    try {
      _razorpay!.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print('Payment Success');
    setState(() {
      showSpinner = true;
    });
    try {
      var docId, doc;
      Map<String, dynamic> data = <String, dynamic>{
        'Sport': widget.sportName,
        'Date': this.selectedDate,
        'Time': this.selectedTime,
      };

      await firebaseFirestore
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Bookings')
          .doc()
          .set(data);

      await firebaseFirestore
          .collection(widget.sportName)
          .where('date', isEqualTo: selectedDate!)
          .get()
          .then((snapshot) {
        doc = snapshot.docs[0].data();
        docId = snapshot.docs[0].id;
        print(docId);
        print(doc);
      });

      print(doc['10-11']);
      print(selectedTime);

      await firebaseFirestore
          .collection(widget.sportName)
          .doc(docId)
          .update({selectedTime!: seats - 1});

      await firebaseFirestore
          .collection(widget.sportName)
          .doc(docId)
          .collection(selectedTime!)
          .add({'Name': this._username, 'Contact no': this._phone});

      Navigator.pop(context);

      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      print(e);
    }
    Fluttertoast.showToast(
        msg: "Payment Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _handleErrorFailure(PaymentFailureResponse response) {
    print('Payment Error');
    Fluttertoast.showToast(
        msg: "Payment Error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External wallet');
    Fluttertoast.showToast(
        msg: "External wallet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void initState() {
    _getCurrentUser();
    super.initState();
    _razorpay = new Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handleErrorFailure);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay!.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.sportName,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: tileColor,
        ),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
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
                        Text('Select Date',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: darkPurple,
                                fontWeight: FontWeight.w500)),
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
                    SizedBox(height: 10.0),
                    Divider(
                      color: tileColor,
                      thickness: 1.5,
                    ),
                    SizedBox(height: 10.0),
                    Column(
                      children: [
                        Text(
                          'Available Seats',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: darkPurple,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          seats.toString(),
                          style: seats > 3
                              ? TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.w500)
                              : TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Divider(
                      color: tileColor,
                      thickness: 1.5,
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      'Pricing',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: darkPurple,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: darkPurple,
                            ),
                            child: Text(
                              'Member : Rs20',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: purple,
                            ),
                            child: Text(
                              'Guest : Rs 150',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      _isMember ? 'You are a Member!' : 'You are not a Member',
                      style: TextStyle(fontSize: 20.0, color: darkPurple),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 70.0,
                    color: tileColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_balance_wallet_rounded,
                          size: 30.0,
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('TOTAL COST'),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.rupeeSign,
                                  size: 15.0,
                                ),
                                Text('$cost'),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      if (selectedDate == '' || selectedTime == '') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Select Date and Time'),
                        ));
                      } else {
                        _openCheckout();
                      }
                    },
                    minWidth: MediaQuery.of(context).size.width / 2,
                    height: 70.0,
                    color: Colors.greenAccent[700],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'PROCEED TO',
                              style: TextStyle(color: Colors.white),
                            ),
                            Row(
                              children: [
                                Text(
                                  'CONFIRM',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ],
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
        _loadAvailableSeats();
        print(this.selectedDate);
        print(this.selectedTime);
        await Future.delayed(Duration(seconds: 2));
        print(this.seats);
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
          },
        );

        _loadAvailableSeats();
        print(this.selectedDate);
        print(this.selectedTime);
        await Future.delayed(Duration(seconds: 2));
        print(this.seats);
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
