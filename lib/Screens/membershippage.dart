import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:club_hub/constants.dart';
import 'package:club_hub/utilites/slidertrackshape.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                ),
                _isMember
                    ? CircleAvatar(
                        radius: 52,
                        backgroundColor: Colors.green,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/profile.jpg'),
                          radius: 50,
                        ),
                      )
                    : 
                    CircleAvatar(
                        radius: 52,
                        backgroundColor: Colors.grey,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/profile.jpg'),
                          radius: 50,
                        ),
                      ),
                SizedBox(
                  width: double.infinity,
                  height: 5,
                ),
                Text(
                  "Hi, $_username",
                  style: memberTextStyle,
                ),
                SizedBox(
                  height: 20,
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
                  width: double.infinity,
                  height: 40,
                ),
                _isMember
                    ? Card(
                      color: backgroundColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          borderRadius:BorderRadius.circular(10) ,
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Icon(
                                FontAwesomeIcons.rupeeSign,
                                color: Colors.black,
                                size: 35,
                              ),
                              title: Center(
                                child: Text(
                                  '$_daysLeft days left ',
                                  style: memberMediumTextStyle,
                                ),
                              ),
                              subtitle: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackShape: CustomTrackShape(),
                                  disabledActiveTrackColor: Colors.deepPurple[700],
                                  disabledInactiveTrackColor: Colors.deepPurple[100],
                                  thumbShape:
                                      RoundSliderThumbShape(enabledThumbRadius: 0.0),
                                ),
                                child: Slider(
                                  value: _membershipType == '6 MONTHS'
                                      ? _daysLeft / 180
                                      : _daysLeft / 365,
                                  onChanged: null,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 20,
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
                      membershipCard("6 months membership","2000", 2000),
                      membershipCard("12 months membership","3500", 3500),
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
        ),
      ),
    );
  }

  Card membershipCard(String text, String amount, int value) {
    return Card(
      color: backgroundColor,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: RadioListTile(
        contentPadding:EdgeInsets.symmetric(vertical: 5, horizontal:16),
        activeColor: Colors.deepPurple[700],
        title: Text(
          text,
          style: memberMediumTextStyle,
        ),
        subtitle: Row(
          children: <Widget>[
            Icon(FontAwesomeIcons.rupeeSign),
            Text(
              amount,
              style: memberTextStyle,
            ),
          ],
        ),
        groupValue: option,
        value: value,
        onChanged: (int? value) {
          setState(() {
            option = value;
          });
        },
      ),
    );
  }
}
