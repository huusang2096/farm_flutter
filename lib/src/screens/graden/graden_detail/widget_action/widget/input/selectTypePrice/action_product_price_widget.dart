import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/validations.dart';
import 'package:farmgate/src/model/graden/action.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

import 'select_price_type_widget.dart';

const Color _colorRedAccent = Colors.redAccent;
const Color _colorGrey = Colors.grey;

class ActionProductPriceWidget extends StatefulWidget {
  ActionModel actionModel;
  String type;
  String image;
  int index = 0;
  ActionProductPriceWidget(this.actionModel, this.index, this.type, this.image);

  @override
  _ActionProductPriceWidget createState() => _ActionProductPriceWidget();
}

class _ActionProductPriceWidget extends State<ActionProductPriceWidget>
    with AutomaticKeepAliveClientMixin {
  final Validations _validations = Validations();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.actionModel.inputData ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildTextFieldContent(
          hintTextKey: widget.actionModel.unitName,
          controller: _controller,
          validator: _validations.validateName,
          inputType: TextInputType.number,
          textRight: widget.actionModel.unitPrice,
        ),
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          addAutomaticKeepAlives: true,
          itemCount: widget.actionModel.inputProduct.length,
          itemBuilder: (context, index) {
            InputProduct actiontype =
                widget.actionModel.inputProduct.elementAt(index);
            return SelectPriceTyeWidget(
              actionType: actiontype,
              onSelectActionType: (actionType) {
                widget.actionModel.inputProduct.forEach((data) {
                  if (data.id == actionType.id) {
                    data.isSelect = 1;
                  } else {
                    data.isSelect = 0;
                  }
                  setState(() {
                    widget.actionModel.unitPrice = actionType.unitPrice;
                  });
                });
              },
            );
          },
        )
      ],
    );
  }

  Widget _buildTextFieldContent(
      {@required String hintTextKey,
      @required TextEditingController controller,
      int minLine = 1,
      int maxLine = 1,
      @required Function validator,
      String textRight,
      TextInputType inputType,
      bool obscureText = false,
      bool readOnly = false}) {
    return Row(
      children: [
        Column(
          children: [
            ClipRRect(
                child: Container(
              width: 30.0,
              height: 30.0,
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: linearGradient,
                borderRadius: BorderRadius.circular(60.0),
              ),
              child: Text(
                widget.index.toString(),
                textAlign: TextAlign.center,
                style: titleBar,
              ),
            )),
            FDottedLine(
              color: appIconColor,
              height: 60,
            ),
          ],
        ),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 6),
            height: 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: hintTextKey.tr + ": ",
                        style: body1.copyWith(color: Colors.black)),
                    TextSpan(
                        text: '*',
                        style: body1.copyWith(color: _colorRedAccent))
                  ]),
                ),
                SizedBox(height: 10),
                TextFormField(
                  obscureText: obscureText,
                  textInputAction: TextInputAction.done,
                  controller: controller,
                  validator: validator,
                  minLines: minLine,
                  maxLines: maxLine,
                  readOnly: readOnly,
                  style: textInput,
                  keyboardType: inputType ?? TextInputType.text,
                  autocorrect: true,
                  onChanged: (value) {
                    widget.actionModel.inputData = value;
                  },
                  decoration: InputDecoration(
                    suffixIcon: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            textRight,
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
                      borderSide: BorderSide(color: appIconColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: _colorGrey),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
