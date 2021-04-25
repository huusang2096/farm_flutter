import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/style.dart';
import 'package:farmgate/src/common/validations.dart';
import 'package:farmgate/src/model/graden/tree_list.dart';
import 'package:farmgate/src/screens/graden/tree/bloc/tree_cubit.dart';
import 'package:farmgate/src/screens/graden/tree/bloc/tree_state.dart';
import 'package:farmgate/src/widgets/rouned_flat_button.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

const Color _colorRedAccent = Colors.redAccent;
const Color _colorGrey = Colors.grey;

class TreeItemFormFieldWidget extends StatefulWidget {
  final TreeList treeList;
  final int gardenId;
  final Function(
      int gardenId,
      int treeId,
      String amount,
      String seeding,
      String plantMethod,
      int year,
      String area,
      String owner,
      String statusGarden) onSave;
  TreeItemFormFieldWidget({this.treeList, this.gardenId, this.onSave});

  @override
  _TreeItemFormFieldWidgetState createState() =>
      _TreeItemFormFieldWidgetState();
}

class _TreeItemFormFieldWidgetState extends State<TreeItemFormFieldWidget> {
  DateTime _timePlant = DateTime.now();

  final _dateFormat = DateFormat('yyyy-MM-dd');

  final Validations _validations = Validations();

  TextEditingController _dateContr,
      _treeTypeContr,
      _treeSeedContr,
      _treeQuantityContr,
      _treeMethodContr,
      _acreageContr,
      _statusGardenContr,
      _ownerGardenContr;

  @override
  void initState() {
    _dateContr =
        TextEditingController(text: _dateFormat.format(new DateTime.now()));
    _treeTypeContr =
        TextEditingController(text: widget.treeList?.treeTypes?.name ?? '');
    _treeSeedContr = TextEditingController(text: '');
    _treeQuantityContr = TextEditingController(text: '');
    _treeMethodContr = TextEditingController(text: '');
    _acreageContr = TextEditingController(text: '');
    _statusGardenContr = TextEditingController(text: '');
    _ownerGardenContr = TextEditingController(text: '');
    super.initState();
  }

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
                      imageUrl: widget.treeList.image,
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
                    widget.treeList.name ?? '',
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
                  // _buildRowItemTree(
                  //     title: 'tree_type',
                  //     value: treeList.treeTypes.name ?? '',
                  //     index: '0'),
                  // _buildRowItemTree(
                  //     title: 'tree_time',
                  //     value: fullDateFormatter
                  //             .format(DateTime.parse(treeList.createdAt)) ??
                  //         DateFormat('dd-MM-yyyy').format(DateTime.now()),
                  //     index: '1'),

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
        _buildTextFieldContent(
          hintTextKey: 'tree_type',
          controller: _treeTypeContr,
          validator: _validations.validateName,
          index: 0,
        ),
        _buildTextFieldContent(
          hintTextKey: 'tree_seed',
          controller: _treeSeedContr,
          validator: _validations.validateName,
          index: 1,
        ),
        _buildTextFieldContent(
          hintTextKey: 'tree_quantity',
          controller: _treeQuantityContr,
          validator: _validations.validateName,
          index: 2,
        ),
        _buildDateContent(
            hintTextKey: 'tree_year',
            controller: _dateContr,
            validator: _validations.validateData,
            onPress: () => _showDatePicker(context),
            suffixIcon: Icons.date_range,
            pathSvg: 'assets/images/tree.svg',
            index: 3),
        _buildTextFieldContent(
          hintTextKey: 'tree_method',
          controller: _treeMethodContr,
          validator: _validations.validateName,
          index: 4,
        ),
        _buildTextFieldContent(
            hintTextKey: 'acreage',
            controller: _acreageContr,
            validator: _validations.validateName,
            index: 5,
            textRight: 'km2'),
        _buildTextFieldContent(
          hintTextKey: 'status_garden',
          controller: _statusGardenContr,
          validator: _validations.validateName,
          index: 6,
        ),
        _buildTextFieldContent(
          hintTextKey: 'owner_garden',
          controller: _ownerGardenContr,
          validator: _validations.validateName,
          index: 7,
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 10, bottom: 10),
          height: 60,
          child: Center(
            child: RounedFlatButton(
              onPress: () => widget.onSave(
                  widget.gardenId,
                  widget.treeList.id,
                  _treeQuantityContr.text ?? '',
                  _treeSeedContr.text ?? '',
                  _treeMethodContr.text ?? '',
                  _dateFormat?.parse(_dateContr.text)?.year ?? _timePlant.year,
                  _acreageContr.text ?? '',
                  _ownerGardenContr.text ?? '',
                  _statusGardenContr.text ?? ''),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      'done'.tr,
                      style: textButton,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Icon(
                      FontAwesomeIcons.arrowAltCircleRight,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  )
                ],
              ),
              color: Colors.white,
              borderRadius: 30,
              height: 50,
              width: 160,
            ),
          ),
        ),
      ],
    );
  }

  void _showDatePicker(BuildContext context) {
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
                            setState(() {
                              _dateContr.text =
                                  _dateFormat.format(_timePlantSelect);
                              _timePlant = _timePlantSelect;
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
      bool readOnly = false,
      @required int index}) {
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
      @required int index}) {
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

  @override
  void dispose() {
    _dateContr.dispose();
    _treeTypeContr.dispose();
    _treeSeedContr.dispose();
    _treeQuantityContr.dispose();
    _treeMethodContr.dispose();
    _acreageContr.dispose();
    _statusGardenContr.dispose();
    _ownerGardenContr.dispose();
    super.dispose();
  }

  @override
  Widget builder(BuildContext context, TreeState state) {
    // TODO: implement builder
    throw UnimplementedError();
  }
}
