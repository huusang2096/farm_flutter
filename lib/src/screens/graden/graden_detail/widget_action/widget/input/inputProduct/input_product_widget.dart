import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/action.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';

const Color _colorRedAccent = Colors.redAccent;
const Color _colorGrey = Colors.grey;

// ignore: must_be_immutable
class InputProductItemWidget extends StatelessWidget {
  final InputProduct actionType;
  const InputProductItemWidget({Key key, this.actionType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 15),
        FDottedLine(
          color: appIconColor,
          height: 80,
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(actionType.name, style: body1.copyWith(color: Colors.black)),
              SizedBox(height: 4),
              TextFormField(
                textInputAction: TextInputAction.done,
                minLines: 1,
                maxLines: 1,
                keyboardType: TextInputType.number,
                style: textInput,
                autocorrect: true,
                controller:
                    new TextEditingController(text: actionType.price ?? ""),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    actionType.price = value;
                  }
                },
                decoration: InputDecoration(
                  suffixIcon: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          actionType.unitPrice,
                          style: descNew.copyWith(color: _colorGrey),
                        ),
                      ],
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _colorRedAccent),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _colorRedAccent),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: beginGradientColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _colorGrey),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
