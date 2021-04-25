import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/validations.dart';
import 'package:farmgate/src/model/graden/tree_list.dart';
import 'package:farmgate/src/widgets/rouned_flat_button.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

const Color _colorRedAccent = Colors.redAccent;
const Color _colorGrey = Colors.grey;

class TreeItemShowModalBottomSheetWidget extends StatelessWidget {
  final TreeList treeList;
  TreeItemShowModalBottomSheetWidget({this.treeList});

  DateTime _timePlant = DateTime.now();
  final _dateFormat = DateFormat('yyyy-MM-dd');
  final Validations _validations = Validations();
  final TextEditingController _dateContr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20),
                  width: 60,
                  height: 5,
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
                    margin: EdgeInsets.only(right: 20, top: 20),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      gradient: linearGradient,
                    ),
                    child: Icon(Icons.arrow_drop_down, color: Colors.white),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: appIconColor,
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: treeList.image,
                      memCacheWidth: 250,
                      imageBuilder: (ctx, imgProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imgProvider,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    treeList.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 4.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: backgroundColor,
              ),
            ),
            Container(height: 5, color: backgroundColor),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.0),
                scrollDirection: Axis.vertical,
                primary: true,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  _buildBody(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildRowItemTree(
            title: 'tree_type', //Giống cây
            value: treeList.treeTypes.name ?? '',
            index: '0'),
        _buildRowItemTree(
            title: 'tree_seed', //Loại cây
            // value: treeList.treeSeeds.name ?? '',
            value: '',
            index: '1'),
        _buildRowItemTree(
            title: 'tree_quantity', //số lượng cây trồng
            value: '',
            index: '2'),
        _buildRowItemTree(
            title: 'tree_year', //Năm cây trồng
            value: '',
            iconSuffix: Icons.date_range,
            index: '3'),
        _buildRowItemTree(
            title: 'tree_method', //phương thức trồng
            value: '',
            index: '4'),
        _buildRowItemTree(
            title: 'acreage', //diện tích
            value: '',
            index: '5',
            textSuffix: 'km2'),
        _buildRowItemTree(
          title: 'status_garden', //Hiện trạng vườn
          value: '',
          index: '6',
        ),
        _buildRowItemTree(
          title: 'owner_garden', //Chủ sở hữu
          value: '',
          index: '7',
        ),
      ],
    );
  }

  Widget _buildRowItemTree(
      {String title,
      String value,
      String index,
      IconData iconSuffix,
      String textSuffix}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
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
                index ?? '',
                textAlign: TextAlign.center,
                style: titleBar,
              ),
            )),
            SizedBox(width: 10),
            Container(
              height: 30,
              alignment: Alignment.center,
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: title.tr + ": ",
                      style: body1.copyWith(color: Colors.black)),
                  TextSpan(
                      text: '*', style: body1.copyWith(color: Colors.redAccent))
                ]),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              FDottedLine(
                color: appIconColor,
                height: 50.0,
              ),
              SizedBox(width: 26),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        value,
                        style: body1.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    iconSuffix != null
                        ? Icon(
                            iconSuffix,
                            color: beginGradientColor,
                            size: 28,
                          )
                        : textSuffix != null
                            ? Text(
                                textSuffix.tr,
                                style: descNew.copyWith(color: _colorGrey),
                              )
                            : SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _showDatePicker(BuildContext context) {
    DateTime _timePlantSelect = new DateTime.now();

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
                            initialDateTime: _timePlantSelect,
                            onDateTimeChanged: (DateTime newDate) {
                              _timePlantSelect = newDate;
                            },
                            minuteInterval: 1,
                            mode: CupertinoDatePickerMode.dateAndTime,
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            _dateContr.text =
                                _dateFormat.format(_timePlantSelect);
                            _timePlant = _timePlantSelect;
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
      bool readOnly = false,
      int index}) {
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
                // widget.index.toString(),
                index.toString() ?? '0',
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
                    // widget.actionModel.inputData = value;
                  },
                  decoration: InputDecoration(
                    suffixIcon: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            textRight ?? '',
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
      @required String pathSvg,
      int index}) {
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
                    // widget.index.toString(),
                    index.toString() ?? '0',
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
}
