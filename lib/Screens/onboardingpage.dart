import 'package:club_hub/Screens/pagechange.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'Never stop Playing',
            body: 'The man who never plays lives only once',
            image: buildImage('assets/basketball.jpg'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'Simple UI',
            body: 'For enhanced reading experience',
            image: buildImage('assets/Football.jpg'),
            footer: ButtonWidget(
              text: 'Start Booking',
              onClicked: () => goToHome(context),
            ),
            decoration: getPageDecoration(),
          ),
        ],
        done: Text(
          'Read',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onDone: () {
          return goToHome(context);
        },
        showSkipButton: true,
        skip: Text('Skip'),
        onSkip: () => goToHome(context),
        next: Icon(Icons.arrow_forward),
        dotsDecorator: getDotDecoration(),
        onChange: (index) => print('Page $index selected'),
        globalBackgroundColor: Theme.of(context).primaryColor,
        skipFlex: 0,
        nextFlex: 0,
      ),
    );
  }

  void goToHome(context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => PageChange(),
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
      //activeColor: Colors.orange,
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

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => RaisedButton(
        onPressed: onClicked,
        color: Theme.of(context).primaryColor,
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
}
