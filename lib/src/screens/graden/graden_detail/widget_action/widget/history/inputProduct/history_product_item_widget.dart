import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/action.dart';
import 'package:farmgate/src/model/graden/garden_history_action_response.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';

const Color _colorRedAccent = Colors.redAccent;
const Color _colorGrey = Colors.grey;

// ignore: must_be_immutable
class HistoryInputProductItemWidget extends StatelessWidget {
  final InputProduct actionType;
  const HistoryInputProductItemWidget({Key key, this.actionType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 15),
        FDottedLine(
          color: appIconColor,
          height: 40,
        ),
        SizedBox(width: 20),
        Text(actionType.name + ": ",
            style: body1.copyWith(fontWeight: FontWeight.bold)),
        SizedBox(height: 2),
        Text(actionType.price,
            style: body1.copyWith(fontWeight: FontWeight.bold)),
        SizedBox(height: 2),
        Text(actionType.unitPrice,
            style: body1.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
