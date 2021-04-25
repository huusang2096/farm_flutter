import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/information/information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ItemRuleWidget extends StatelessWidget {
  Rule rule;
  ItemRuleWidget({Key key, this.rule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(rule.name, style: titleNew),
          SizedBox(
            height: 5.0,
          ),
          Text(rule.description, style: descNew),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                Images.logoTinNghia,
              ),
            ),
          ),
          Html(
            data: rule.content ?? '',
          ),
        ],
      ),
    );
  }
}
