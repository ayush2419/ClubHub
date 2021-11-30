import 'package:flutter/material.dart';
import 'package:club_hub/utilites/profilecard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';
import 'package:club_hub/constants.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkPurple,
        title: Text('About Us'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Contact us on:",
              style: memberMediumTextStyle.copyWith(fontSize: 25,color:Colors.black),
            ),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: 0),
            horizontalTitleGap: 0,
            leading: TextButton(
              child:  Icon(FontAwesomeIcons.phone, size: 30,color:Colors.green,),
              onPressed: ()=>_makePhoneCall('9222777432'),
            ),
            title: ProfileCard(
            text: 'Phone: +91 9222777432',
            ),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: 0),
            horizontalTitleGap: 0,
            leading: TextButton(
              child:  Icon(FontAwesomeIcons.envelope,size: 30,color: Colors.red,),
              onPressed: ()=>_launchEmail('srinil.k@somaiya.edu'),
            ),
            title: ProfileCard(
            text: 'Email: srinil.k@somaiya.edu',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Other Links:",
              style: memberMediumTextStyle.copyWith(fontSize: 25,color:Colors.black),
            ),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: 0),
            horizontalTitleGap: 0,
            leading: TextButton(
              child:  Icon(FontAwesomeIcons.github,size: 30,color: Colors.black,),
              onPressed: ()=>_launchInBrowser('https://github.com/ayush2419/ClubHub'),
            ),
            title: ProfileCard(
            text: 'Github: ayush2419/ClubHub',
            ),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: 0),
            horizontalTitleGap: 0,
            leading: TextButton(
              child:  Icon(FontAwesomeIcons.linkedin,size: 30,color: Colors.blue,),
              onPressed: ()=>_launchInBrowser('https://www.linkedin.com/in/rohan-balasubramanian-43093821b/'),
            ),
            title: ProfileCard(
            text: 'LinkedIn: Rohan Balasubramanian',
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }
  Future<void> _launchEmail(String email) async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'We are pleased to communicate with you!'
      }),
    );

    launch(emailLaunchUri.toString());
  }
  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }
}
