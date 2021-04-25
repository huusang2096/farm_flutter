import 'package:flutter/material.dart';

class AppBarSaleWidget extends StatelessWidget {
  final Function onPressIcon;
  final String titleText;

  const AppBarSaleWidget({Key key, this.onPressIcon, this.titleText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          onPressIcon();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.green,
      title: Text(
        titleText,
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }
}
