import 'package:club_hub/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookingPage2 extends StatefulWidget {
  late String sportName;
  BookingPage2({required this.sportName});
  @override
  _BookingPage2State createState() => _BookingPage2State();
}

class _BookingPage2State extends State<BookingPage2> {
  bool is10_11Selected = false;
  bool is11_12Selected = false;
  bool is12_1Selected = false;
  bool is1_2Selected = false;
  bool is2_3Selected = false;
  bool is3_4Selected = false;
  bool isDate_1_Selected = false;
  bool isDate_2_Selected = false;
  bool isDate_3_Selected = false;
  bool isMember = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.sportName,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: tileColor,
      ),
      body: Column(
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
                    GridView.count(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      crossAxisCount: 5,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10.0,
                      children: [
                        dateSelector('22 Sept', isDate_1_Selected),
                        dateSelector('23 Sept', isDate_2_Selected),
                        dateSelector('24 Sept', isDate_3_Selected),
                      ],
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
                      '5',
                      style: TextStyle(fontSize: 20.0),
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
                        padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: darkPurple,
                        ),
                        child: Text(
                          'Member : Rs20',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: purple,
                        ),
                        child: Text(
                          'Guest : Rs 150',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  isMember ? 'You are a Member!' : 'You are not a Member',
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
                            Text('20'),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
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
    );
  }

  GestureDetector slotSelector(String timeSlot, selectedValue) {
    return GestureDetector(
      onTap: () {
        setState(
          () {
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

  GestureDetector dateSelector(String date, selectedValue) {
    return GestureDetector(
      onTap: () {
        setState(
          () {
            if (date == '22 Sept') {
              this.isDate_1_Selected = !isDate_1_Selected;
              if (isDate_1_Selected == true) {
                this.isDate_2_Selected = false;
                this.isDate_3_Selected = false;
              }
            }
            if (date == '23 Sept') {
              this.isDate_2_Selected = !isDate_2_Selected;
              if (isDate_2_Selected == true) {
                this.isDate_1_Selected = false;
                this.isDate_3_Selected = false;
              }
            }
            if (date == '24 Sept') {
              this.isDate_3_Selected = !isDate_3_Selected;
              if (isDate_3_Selected == true) {
                this.isDate_2_Selected = false;
                this.isDate_1_Selected = false;
              }
            }
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
            date,
            style:
                TextStyle(color: selectedValue ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
