import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/validations.dart';
import 'package:farmgate/src/model/graden/action.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

const Color _colorRedAccent = Colors.redAccent;
const Color _colorGrey = Colors.grey;

class HistoryActionInputTextWidget extends StatefulWidget {
  ActionModel actionModel;
  int index = 0;

  HistoryActionInputTextWidget(this.actionModel, this.index);

  @override
  _HistoryActionInputTextWidgetState createState() =>
      _HistoryActionInputTextWidgetState();
}

class _HistoryActionInputTextWidgetState
    extends State<HistoryActionInputTextWidget>
    with AutomaticKeepAliveClientMixin {
  final Validations _validations = Validations();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context: context);
  }

  Widget _buildTextFieldContent({
    @required String hintTextKey,
    @required TextEditingController controller,
    @required Function validator,
    String inputData,
    TextInputType inputType,
  }) {
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
              height: 50,
            ),
          ],
        ),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 6),
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: widget.actionModel.unitName.tr + ": ",
                        style: body1.copyWith(color: Colors.black)),
                    TextSpan(
                        text: '*',
                        style: body1.copyWith(color: Colors.redAccent))
                  ]),
                ),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: inputData,
                        style: body1.copyWith(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' '),
                    TextSpan(
                        text: widget.actionModel.unitPrice ?? '',
                        style: body1.copyWith(fontWeight: FontWeight.bold))
                  ]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductPriceFieldContent({
    String inputData,
    String inputProductUnit,
  }) {
    return Row(
      children: [
        Container(
          height: 80,
          child: Column(
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
                height: 50,
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 6),
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: widget.actionModel.unitName.tr + ": ",
                        style: body1.copyWith(color: Colors.black)),
                    TextSpan(
                        text: '*',
                        style: body1.copyWith(color: Colors.redAccent))
                  ]),
                ),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: inputProductUnit ?? '',
                        style: body1.copyWith(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' : '),
                    TextSpan(
                        text: inputData + " " + widget.actionModel.unitPrice,
                        style: body1.copyWith(fontWeight: FontWeight.bold)),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateContent({
    @required String hintTextKey,
    @required TextEditingController controller,
    @required Function validator,
    @required String inputData,
  }) {
    return GestureDetector(
      onTap: () {},
      child: AbsorbPointer(
        child: Row(
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
                  height: 50,
                ),
              ],
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 6),
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: widget.actionModel.unitName.tr + ": ",
                            style: body1.copyWith(color: Colors.black)),
                        TextSpan(
                            text: '*',
                            style: body1.copyWith(color: Colors.redAccent))
                      ]),
                    ),
                    SizedBox(height: 10),
                    Text(inputData,
                        style: body1.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationContent({
    @required String hintTextKey,
    @required TextEditingController controller,
    int minLine = 1,
    int maxLine = 1,
    @required Function validator,
    TextInputType inputType,
    @required String inputData,
    bool obscureText = false,
  }) {
    controller.text = inputData;
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
              height: 90,
            ),
          ],
        ),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 6),
            height: 120,
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
                  style: textInput,
                  keyboardType: inputType ?? TextInputType.text,
                  autocorrect: true,
                  decoration: InputDecoration(
                    suffixIcon: Container(
                        width: 1.0,
                        height: 1.0,
                        padding: EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          'assets/images/location_pin.svg',
                          fit: BoxFit.cover,
                        )),
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

  Widget _buildBody({BuildContext context}) {
    String type = widget.actionModel.inputType;
    if (type == "") {
      return Row(children: [
        ClipRRect(
            child: Container(
                width: 30.0,
                height: 30.0,
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  gradient: linearGradient,
                  borderRadius: BorderRadius.circular(60.0),
                ),
                child: SvgPicture.asset(
                  'assets/images/check_icon.svg',
                  color: Colors.white,
                ))),
        SizedBox(width: 10),
        Expanded(
          child: Text('complete_des'.tr,
              maxLines: 2, style: titleBar.copyWith(color: appIconColor)),
        ),
      ]);
    } else if (type == "input_time") {
      return _buildDateContent(
          hintTextKey: widget.actionModel.unitName,
          controller: _controller,
          validator: _validations.validateName,
          inputData: widget.actionModel.inputData ?? "");
    } else if (type == "input_location") {
      return _buildLocationContent(
          hintTextKey: widget.actionModel.unitName,
          controller: _controller,
          validator: _validations.validateName,
          inputData: widget.actionModel.inputData ?? "");
    } else if (type == "input_product_price") {
      final inputProductUnit = widget.actionModel.inputProduct
          .firstWhere((element) => element.isSelect == 1)
          .name;
      return _buildProductPriceFieldContent(
        inputProductUnit: inputProductUnit,
        inputData: widget.actionModel.inputData ?? "0",
      );
    } else {
      return _buildTextFieldContent(
        hintTextKey: widget.actionModel.unitName,
        controller: _controller,
        validator: _validations.validateName,
        inputType:
            type == "input_number" ? TextInputType.number : TextInputType.text,
        inputData: widget.actionModel.inputData ?? "0",
      );
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
