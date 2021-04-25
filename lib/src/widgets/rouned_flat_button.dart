import 'package:farmgate/src/common/config.dart';
import 'package:flutter/material.dart';

class RounedFlatButton extends StatelessWidget {
  final Function onPress;
  final Widget child;
  final Color color;
  final double height;
  final double borderRadius;
  final double width;

  RounedFlatButton(
      {this.onPress,
      this.child,
      this.color,
      this.height,
      this.borderRadius,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          gradient: linearGradient,
          borderRadius: BorderRadius.circular(borderRadius)),
      height: height,
      child: FlatButton(
        onPressed: onPress,
        child: child,
      ),
    );
  }
}
