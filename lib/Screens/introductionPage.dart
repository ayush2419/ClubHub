import 'package:club_hub/Screens/pagechange.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 30.0),
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Never stop Playing',
              body: 'A man who never plays lives only once',
              image: buildImage('assets/basketball.jpg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Simple UI',
              body: 'For enhanced reading experience',
              image: buildImage('assets/Football.jpg'),
              decoration: getPageDecoration(),
            ),
          ],
          done: Text(
            'Done',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          onDone: () {
            return goToHome(context);
          },
          showSkipButton: true,
          skip: Text('Skip',
              style: TextStyle(color: Colors.white, fontSize: 18.0)),
          onSkip: () => goToHome(context),
          next: Icon(
            Icons.arrow_forward_rounded,
            color: Colors.white,
            size: 25,
          ),
          dotsDecorator: getDotDecoration(),
          onChange: (index) => print('Page $index selected'),
          globalBackgroundColor: Theme.of(context).primaryColor,
          skipFlex: 0,
          nextFlex: 0,
        ),
      ),
    );
  }

  void goToHome(context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => PageChange(
        isAdmin: false,
      ),
    ));
  }

  Widget buildImage(String path) {
    return Center(
      child: Image.asset(path, width: 350),
    );
  }

  DotsDecorator getDotDecoration() {
    return DotsDecorator(
      color: Color(0xFFBDBDBD),
      activeColor: Colors.white,
      size: Size(10, 10),
      activeSize: Size(22, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }

  PageDecoration getPageDecoration() {
    return PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 20),
      descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
      imagePadding: EdgeInsets.all(24),
      pageColor: Colors.white,
    );
  }
}
