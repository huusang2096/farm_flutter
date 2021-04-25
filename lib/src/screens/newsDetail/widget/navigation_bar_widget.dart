import 'package:farmgate/src/common/config.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  final Size size;
  final List<String> listTitle;

  NavigationBar({Key key, this.size, this.listTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      decoration: BoxDecoration(gradient: linearGradient),
      child: Text.rich(
        TextSpan(children: generateTextSpan(), style: titleBar),
      ),
    );
  }

  List<TextSpan> generateTextSpan() {
    List<TextSpan> listWidget = [];
    int temp = 0;
    listTitle.forEach((element) {
      listWidget.add(
        TextSpan(
          text: element,
        ),
      );
      if (temp < listTitle.length - 1) {
        listWidget.add(
          TextSpan(
            text: '       >      ',
          ),
        );
        temp++;
      }
    });
    return listWidget;
  }
}
