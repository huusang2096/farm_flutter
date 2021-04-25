import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/action.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectPriceTyeWidget extends StatelessWidget {
  final InputProduct actionType;
  final String type;
  final String image;
  final Function(InputProduct) onSelectActionType;
  const SelectPriceTyeWidget(
      {Key key,
      this.actionType,
      this.type,
      this.onSelectActionType,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onSelectActionType(actionType);
        },
        child: Row(
          children: [
            SizedBox(width: 15),
            FDottedLine(
              color: appIconColor,
              height: 40,
            ),
            SizedBox(width: 20),
            actionType.isSelect == 1
                ? Icon(
                    Icons.check_box,
                    color: appIconColor,
                  )
                : Icon(Icons.check_box_outline_blank, color: appIconColor),
            SizedBox(width: 10),
            Text(
              actionType.name,
              style: descNew,
            ),
          ],
        ));
  }
}
