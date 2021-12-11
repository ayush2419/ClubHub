import 'package:flutter/material.dart';
import 'package:club_hub/constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required String? text,
  })  : _text = text,
        super(key: key);

  final String? _text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {},
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_text!,
                    style: memberTextStyle.copyWith(
                      color: Colors.black,
                    ),
                    softWrap: false,
                    maxLines: 1,
                    overflow: TextOverflow.fade),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
