import 'package:farmgate/src/common/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class EmptyNewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(40),
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                gradient: linearGradient,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Color(0xFF467A76), width: 1)),
            child: Image.asset(
              Images.emptyNewPaper,
              color: Colors.white,
              height: 100,
              width: 100,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'empty_news'.tr,
              style: body1,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
