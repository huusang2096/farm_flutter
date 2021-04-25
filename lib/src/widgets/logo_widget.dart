import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key key,
    @required this.urlImg,
    @required this.bottom,
  }) : super(key: key);
  final String urlImg;
  final double bottom;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      margin: EdgeInsets.only(bottom: bottom),
      child: Image.asset(urlImg),
    );
  }
}
