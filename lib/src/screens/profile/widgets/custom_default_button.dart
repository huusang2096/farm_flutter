import 'package:farmgate/src/common/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:simplest/simplest.dart';

class CustomDefaultButton extends StatelessWidget {
  final String text;
  final Function press;
  final bool isLoading;

  const CustomDefaultButton({Key key, this.text, this.press, this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = this.isLoading ?? false;

    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(44.0),
            gradient: linearGradient),
        child: isLoading
            ? SpinKitCircle(
                color: Colors.white,
                size: 28.0,
              )
            : FlatButton(
                height: 50,
                onPressed: press,
                child: Text(text.tr, style: textButton),
              ),
      ),
    );
  }
}
