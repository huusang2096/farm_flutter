import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/validations.dart';
import 'package:farmgate/src/model/graden/action.dart';
import 'package:farmgate/src/model/graden/graden_detail_response.dart';
import 'package:farmgate/src/model/graden/tree_list.dart';
import 'package:farmgate/src/model/place_response.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

const Color _colorRedAccent = Colors.redAccent;
const Color _colorGrey = Colors.grey;

class ActionInputNumberWidget extends StatefulWidget {
  ActionModel actionModel;
  int index = 0;
  final int idGarden;
  ActionInputNumberWidget(this.actionModel, this.index, this.idGarden);

  @override
  _ActionInputNumberWidgetState createState() =>
      _ActionInputNumberWidgetState();
}

class _ActionInputNumberWidgetState extends State<ActionInputNumberWidget>
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
    return _buildBody(context: context);
  }

  Widget _showDatePicker(BuildContext context) {
    DateTime timeBirthDaySelect = new DateTime.now();

    showModalBottomSheet(
        elevation: 10,
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        backgroundColor: Colors.white,
        builder: (BuildContext builder) {
          return StatefulBuilder(
            builder: (context, state) {
              return AnimatedPadding(
                  padding: MediaQuery.of(context).viewInsets,
                  duration: const Duration(milliseconds: 10),
                  curve: Curves.decelerate,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width: 60,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                            Container(
                              width: 60,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 20),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                  gradient: linearGradient,
                                ),
                                child: Icon(Icons.close, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text('year'.tr,
                              style: textButton.copyWith(
                                  color: beginGradientColor)),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height:
                              MediaQuery.of(context).copyWith().size.height *
                                  0.3,
                          child: CupertinoDatePicker(
                            maximumDate: DateTime.now(),
                            initialDateTime: timeBirthDaySelect,
                            onDateTimeChanged: (DateTime newDate) {
                              timeBirthDaySelect = newDate;
                            },
                            minuteInterval: 1,
                            mode: CupertinoDatePickerMode.dateAndTime,
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _controller.text =
                                  fullDateFormatter.format(timeBirthDaySelect);
                              widget.actionModel.inputData =
                                  fullDateFormatter.format(timeBirthDaySelect);
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green, gradient: linearGradient),
                            padding: EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(),
                                Text(
                                  'save_and_next'.tr,
                                  style: textButton,
                                ),
                                Icon(Icons.navigate_next,
                                    color: Colors.white, size: 28)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ));
            },
          );
        });
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
              color: beginGradientColor,
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
                      borderSide: BorderSide(color: beginGradientColor),
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

  Widget _buildDateContent(
      {@required String hintTextKey,
      @required TextEditingController controller,
      int minLine = 1,
      int maxLine = 1,
      @required Function validator,
      TextInputType inputType,
      bool obscureText = false,
      @required Function onPress,
      @required IconData suffixIcon,
      @required String pathSvg}) {
    return GestureDetector(
      onTap: () => onPress(),
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
                  color: beginGradientColor,
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
                        suffixIcon: pathSvg != null
                            ? Container(
                                width: 1.0,
                                height: 1.0,
                                padding: EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  pathSvg,
                                  fit: BoxFit.cover,
                                ))
                            : Icon(suffixIcon, color: beginGradientColor),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _colorRedAccent),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _colorRedAccent),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: beginGradientColor),
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
    bool obscureText = false,
  }) {
    return GestureDetector(
      onTap: () {
        Place myPlace = null;
        Navigator.of(context)
            .pushNamed(AppRoute.userPlaceScreen)
            .then((value) => {
                  if (value != null)
                    {
                      myPlace = value,
                      _controller.text = myPlace.formattedAddress,
                      widget.actionModel.inputData = myPlace.formattedAddress,
                    }
                });
      },
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
                  color: beginGradientColor,
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
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: beginGradientColor),
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
        ),
      ),
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
              maxLines: 2, style: titleBar.copyWith(color: beginGradientColor)),
        ),
      ]);
    } else if (type == "input_time") {
      return _buildDateContent(
          hintTextKey: widget.actionModel.unitName,
          controller: _controller,
          validator: _validations.validateName,
          onPress: () => _showDatePicker(context),
          suffixIcon: Icons.date_range,
          pathSvg: 'assets/images/calendar_input.svg');
    } else if (type == "input_location") {
      return _buildLocationContent(
        hintTextKey: widget.actionModel.unitName,
        controller: _controller,
        validator: _validations.validateName,
      );
    } else if (type == "input_tree") {
      return _buildDateContent(
          hintTextKey: widget.actionModel.unitName,
          controller: _controller,
          validator: _validations.validateData,
          onPress: () => navigator.pushNamed(AppRoute.treeShowAllAndPickTree,
                  arguments: {'idGarden': widget.idGarden}).then((value) {
                final mapData = value as Map;
                if (mapData != null) {
                  final tree = mapData['tree'] as TreeListGarden;

                  _controller.text = tree?.tree?.name ?? '';
                  widget.actionModel.inputData = tree?.tree?.name ?? '';
                }
              }),
          suffixIcon: Icons.date_range,
          pathSvg: 'assets/images/tree.svg');
    } else {
      return _buildTextFieldContent(
        hintTextKey: widget.actionModel.unitName,
        controller: _controller,
        validator: _validations.validateName,
        inputType:
            type == "input_number" ? TextInputType.number : TextInputType.text,
        textRight: widget.actionModel.unitPrice,
      );
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
