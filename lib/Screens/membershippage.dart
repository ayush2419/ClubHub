import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:club_hub/constants.dart';
import 'package:club_hub/utilites/slidertrackshape.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';
import 'bookingpage2.dart';

class MembershipPage extends StatefulWidget {
  @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  int? option = 0;
  Razorpay? _razorpay;
  bool showSpinner = false;
  late String? _username = '';
  late String? _phone = '';
  late String? _userEmail = '';
  var now = new DateTime.now();
  late String _todaysFormattedDate = '';
  late String _endDateFormatted = '';
  late String _membershipEndDate = '';
  late bool _isMember = true;
  int _daysLeft = 0;
  String _membershipType = '';

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
          if (_isMember == true) {
            this._membershipEndDate = data.data()!['MembershipEndDate'];
            this._membershipType = data.data()!['MembershipType'];
            _getDayDifference();
          }
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
  }

  void _getDayDifference() async {
    print('INSIDE GETDAY DIFF');
    DateTime endDate = new DateFormat("yyyy-MM-dd").parse(_membershipEndDate);
    print(endDate);
    this._daysLeft = endDate.difference(now).inDays;
    if (_daysLeft <= 0) {
      await firebaseFirestore
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'isMember': false,
        'MembershipStartDate': '-',
        'MembershipEndDate': '-',
        'MembershipType': 'None',
      });
      setState(() {
        this._isMember = false;
        this._membershipEndDate = '-';
        this._membershipType = 'None';
      });
    }
    print(_daysLeft);
  }

  @override
  void initState() {
    _getUserDetails();
    super.initState();
    _razorpay = new Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlerPaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlerErrorFailure);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay!.clear();
  }

  void _openCheckout() {
    var options = {
      'key': 'rzp_test_9Kjyiz2qW5U3Y0',
      'amount': option! * 100, // enter amount
      'name': this._username,
      'description': 'Payment for the Membership',
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

  void _handlerPaymentSuccess(PaymentSuccessResponse response) async {
    setState(() {
      showSpinner = true;
    });

    try {
      print('INSIDE SUCCESS PAYMENT');
      print(FirebaseAuth.instance.currentUser!.uid);
      int membershipDuration = 0;

      if (option == 2000) {
        membershipDuration = 180;
        _membershipType = '6 MONTHS';
      }
      if (option == 3500) {
        membershipDuration = 365;
        _membershipType = '12 MONTHS';
      }
      var formatter = new DateFormat('yyyy-MM-dd');
      _todaysFormattedDate = formatter.format(now).toString();
      var membershipEndDate = now.add(Duration(days: membershipDuration));
      _endDateFormatted = formatter.format(membershipEndDate).toString();
      print(_todaysFormattedDate);
      print(_endDateFormatted);

      await firebaseFirestore
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'isMember': true,
        'MembershipStartDate': this._todaysFormattedDate,
        'MembershipEndDate': this._endDateFormatted,
        'MembershipType': this._membershipType,
      });

      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      print(e);
    }
    print('Payment Success');
    this._isMember = true;
    Fluttertoast.showToast(
        msg: "Payment Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _handlerErrorFailure(PaymentFailureResponse response) {
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

  void _handlerExternalWallet(ExternalWalletResponse response) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // CircleAvatar(
            //   backgroundImage: NetworkImage("https://www.woolha.com/media/2020/03/eevee.png"),
            // )
            SizedBox(
              width: double.infinity,
            ),
            ClipOval(
              // child:Image.network(
              //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTDf__xsU-p0lRPRPRqsfJQm0hsLo4XMOjzw&usqp=CAU',
              //   width: 120,
              //   height: 120,
              //   )
              child: Image.asset(
                'assets/profile.jpg',
                height: 120,
                width: 120,
              ),
            ),
            Text(
              "Hi, $_username",
              style: memberTextStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                _isMember
                    ? "$_membershipType MEMBERSHIP"
                    : 'NO ACTIVE MEMBERSHIP',
                style: memberBoldTextStyle),
            Visibility(
              visible: _isMember,
              child: Text(
                "Valid up to $_membershipEndDate",
                style: memberSmallTextStyle,
              ),
            ),

            SizedBox(
              height: 30,
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.rupeeSign,
                color: Colors.black,
                size: 30,
              ),
              title: Text(
                _isMember
                    ? '$_daysLeft days left in membership'
                    : 'Get a Membership',
                style: memberMediumTextStyle,
              ),
              subtitle: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackShape: CustomTrackShape(),
                  disabledActiveTrackColor: Colors.deepPurple[700],
                  disabledInactiveTrackColor: Colors.deepPurple[100],
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
                ),
                child: Slider(
                  value: _membershipType == '6 MONTHS'
                      ? _daysLeft / 180
                      : _daysLeft / 365,
                  onChanged: null,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Visibility(
              visible: !_isMember,
              child: Column(
                children: [
                  Text(
                    "Available Memberships",
                    style: memberBoldTextStyle,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: RadioListTile(
                      activeColor: Colors.deepPurple[700],
                      title: Text("6 months membership",
                          style: memberMediumTextStyle),
                      subtitle: Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.rupeeSign),
                          Text(
                            "2000",
                            style: memberTextStyle,
                          ),
                        ],
                      ),
                      groupValue: option,
                      value: 2000,
                      onChanged: (int? value) {
                        setState(() {
                          option = value;
                        });
                      },
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: RadioListTile(
                      activeColor: Colors.deepPurple[700],
                      title: Text("12 months membership",
                          style: memberMediumTextStyle),
                      subtitle: Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.rupeeSign),
                          Text(
                            "3500",
                            style: memberTextStyle,
                          ),
                        ],
                      ),
                      groupValue: option,
                      value: 3500,
                      onChanged: (int? value) {
                        setState(() {
                          option = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  MaterialButton(
                    color: Colors.greenAccent[700],
                    onPressed: () {
                      if (option == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Select Membership Duration'),
                        ));
                      } else {
                        _openCheckout();
                      }
                    },
                    child: Text(
                      'CONFIRM',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
