import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:club_hub/constants.dart';
import 'package:club_hub/utilites/slidertrackshape.dart';

class MembershipPage extends StatefulWidget {
  const MembershipPage({Key? key}) : super(key: key);

  @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  int? option = 1;

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
                value: 0.2,
                onChanged: null,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
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
              title: Text("6 months membership", style: memberMediumTextStyle),
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
              value: 1,
              onChanged: (int? value) {
                setState(() {
                  option = value;
                });
              },
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: RadioListTile(
              activeColor: Colors.deepPurple[700],
              title: Text("12 months membership", style: memberMediumTextStyle),
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
              value: 2,
              onChanged: (int? value) {
                setState(() {
                  option = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
