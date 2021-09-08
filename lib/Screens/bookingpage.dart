import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:club_hub/utilites/bottombar.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Booking',
          style: TextStyle(
              fontSize: 40.00,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        backgroundColor: Color(0xFFb3c8ff),
        leading: Icon(
          FontAwesomeIcons.bars,
          color: Colors.black,
        ),
        actions: [
          Icon(
            FontAwesomeIcons.ellipsisV,
            color: Colors.black,
          ),
          SizedBox(
            width: 15.00,
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
