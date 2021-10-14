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
  late String todaysFormattedDate;
  late String endDateFormatted;
  late bool _isMember = false;

  void _getCurrentUSer() async {
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
        });
      });
    } catch (e) {
      print(e);
    }

    print(_username);
    print(_phone);
    print(_userEmail);
  }

  @override
  void initState() {
    _getCurrentUSer();
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

  void _handlerPaymentSuccess() async {
    setState(() {
      showSpinner = true;
    });

    try {
      print('INSIDE SUCCESS PAYMENT');
      print(FirebaseAuth.instance.currentUser!.uid);
      int membershipDuration = 0;

      if (option == 2000) {
        membershipDuration = 180;
      }
      if (option == 3500) {
        membershipDuration = 365;
      }
      var formatter = new DateFormat('yyyy-MM-dd');
      todaysFormattedDate = formatter.format(now).toString();
      var membershipEndDate = now.add(Duration(days: membershipDuration));
      endDateFormatted = formatter.format(membershipEndDate).toString();
      print(todaysFormattedDate);
      print(endDateFormatted);

      await firebaseFirestore
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'isMember': true,
        'MembershipStartDate': this.todaysFormattedDate,
        'MembershipEndDate': this.endDateFormatted,
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

  void _handlerErrorFailure() {
    print('Payment Error');
  }

  void _handlerExternalWallet() {
    print('External wallet');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
            "Hi, Someone",
            style: memberTextStyle,
          ),
          SizedBox(
            height: 10,
          ),
          Text("UNLIMITED MEMBERSHIP", style: memberBoldTextStyle),
          Text(
            "Valid up to 20 Dec, 2021",
            style: memberSmallTextStyle,
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
              "30 days left in membership",
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
                value: 0.02,
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
                  "Renew your membership",
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
                      // _openCheckout();
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
    );
  }
}
