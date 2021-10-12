import 'package:club_hub/Screens/bookingpage2.dart';
import 'package:club_hub/constants.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(top: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  'Select Sport',
                  style: TextStyle(
                    color: darkPurple,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(40.0, 0, 40.0, 40.0),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10.0,
                  children: [
                    Container(
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(10.0),
                        color: backgroundColor,
                        // color: Color(0xFF),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      BookingPage2(sportName: 'Football'),
                                ));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.sports_soccer,
                                size: 50.0,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Football',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(10.0),
                        color: backgroundColor,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      BookingPage2(sportName: 'Lawn Tennis'),
                                ));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.sports_tennis,
                                color: Colors.brown,
                                size: 50.0,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Lawn Tennis',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(10.0),
                        color: backgroundColor,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      BookingPage2(sportName: 'Swimming'),
                                ));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.water,
                                color: Colors.blue,
                                size: 50.0,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Swimming',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(10.0),
                        color: backgroundColor,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      BookingPage2(sportName: 'Volleyball'),
                                ));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.sports_volleyball,
                                color: Colors.green[900],
                                size: 50.0,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Volleyball',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(10.0),
                        color: backgroundColor,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      BookingPage2(sportName: 'Basketball'),
                                ));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.sports_basketball,
                                color: Colors.brown[600],
                                size: 50.0,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Basketball',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(10.0),
                        color: backgroundColor,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      BookingPage2(sportName: 'Archery'),
                                ));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_forward,
                                size: 50.0,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Archery',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(10.0),
                        color: backgroundColor,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      BookingPage2(sportName: 'Golf'),
                                ));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.golf_course,
                                color: Colors.green[900],
                                size: 50.0,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Golf',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(10.0),
                        color: backgroundColor,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      BookingPage2(sportName: 'E-Sports'),
                                ));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.tv,
                                size: 50.0,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'E-Sports',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
