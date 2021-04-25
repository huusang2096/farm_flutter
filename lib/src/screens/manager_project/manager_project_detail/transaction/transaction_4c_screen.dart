import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/manager_project/my_project_response.dart';
import 'package:farmgate/src/screens/manager_project/manager_project_detail/transaction/cubit/transaction_4c_cubit.dart';
import 'package:farmgate/src/widgets/app_progress_hub.dart';
import 'package:farmgate/src/widgets/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simplest/simplest.dart';

class Transaction4cScreen
    extends CubitWidget<Transaction4cCubit, Transaction4cState> {
  DateTime _timeTransaction = DateTime.now();
  final Color _colorRedAccent = Colors.redAccent;
  final _dateFormat = DateFormat('yyyy-MM-dd');
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _dateOfTransactionController =
      TextEditingController();
  final TextEditingController _numOfContractController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _tripNumberController = TextEditingController();
  final TextEditingController _reward4cController = TextEditingController();

  final _listTypeOfProduct = ['nhan'.tr, 'fresh_fruit'.tr, 'dried_fruit'.tr];
  final _listMethodTransaction = ['sell'.tr, 'send_to_warehouse'.tr];
  double totalReward4c = 0;
  double totalPrice = 0;
  double total = 0;
  Project project;

  Transaction4cScreen(this.project);

  static provider(Project project) {
    return BlocProvider(
      create: (_) => Transaction4cCubit(),
      child: Transaction4cScreen(project),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<Transaction4cCubit>().getMemberPartnerProject(project.id);
    super.afterFirstLayout(context);
  }

  @override
  Widget builder(BuildContext context, Transaction4cState state) {
    totalReward4c = (double.parse(_reward4cController.text.isEmpty
            ? '0'
            : _reward4cController.text.replaceAll('.', ''))) *
        (double.parse(_quantityController.text.isEmpty
            ? '0'
            : _quantityController.text.replaceAll('.', '')));

    totalPrice = ((double.parse(_priceController.text.isEmpty
            ? '0'
            : _priceController.text.replaceAll('.', '')))) *
        (double.parse(_quantityController.text.isEmpty
            ? '0'
            : _quantityController.text.replaceAll('.', '')));

    total = totalReward4c + totalPrice;

    _dateOfTransactionController.text = _dateFormat.format(_timeTransaction);
    Widget _buildAppBar(BuildContext context) {
      return AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: greyColor),
        elevation: 1.0,
        title: Text(
          'create_transaction'.tr,
          style: headingBlack18,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(
                Icons.check,
                color: beginGradientColor,
                size: 30,
              ),
              onPressed: () {
                String typeGoods =
                    _listTypeOfProduct[state.data.isSelectedTypeOfProduct];
                String typeSale = _listMethodTransaction[
                    state.data.isSelectedMethodTransaction];

                context.read<Transaction4cCubit>().submit(
                    project.id,
                    _numOfContractController.text,
                    _quantityController.text.replaceAll('.', ''),
                    _priceController.text.replaceAll('.', ''),
                    _tripNumberController.text,
                    _reward4cController.text.replaceAll('.', ''),
                    _dateOfTransactionController.text,
                    typeGoods,
                    typeSale,
                    totalReward4c.toString(),
                    total.toString());
              },
            ),
          )
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(context),
      body: AppProgressHUB(
        inAsyncCall: state.data.isLoading,
        child: SafeArea(
          child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Chi tiết hàng hoá",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.end,
                                        style: titleNew.copyWith(fontSize: 16),
                                      ),
                                      SizedBox(height: 10),
                                      _buildListTypeOfProduct(context, state),
                                      SizedBox(height: 10),
                                      _buildRowTextPriceController(
                                          title: 'quantity_product',
                                          controller: _quantityController,
                                          textInputType: TextInputType.number,
                                          unitPrice: 'kg'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4),
                          Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hình thức giao dich",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.end,
                                        style: titleNew.copyWith(fontSize: 16),
                                      ),
                                      SizedBox(height: 10),
                                      _buildListMethodTransaction(
                                          context, state),
                                      SizedBox(height: 10),
                                      state.data.isSelectedMethodTransaction ==
                                              0
                                          ? _buildRowTextPriceController(
                                              title: 'price_per_unit',
                                              controller: _priceController,
                                              textInputType:
                                                  TextInputType.number,
                                              unitPrice: 'đ/kg')
                                          : SizedBox.shrink(),
                                      SizedBox(height: 10),
                                      _buildRowTextPriceController(
                                          title: 'reward_4c',
                                          controller: _reward4cController,
                                          textInputType: TextInputType.number,
                                          textInputAction: TextInputAction.done,
                                          unitPrice: 'đ/kg'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4),
                          Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Chi tiết giao dich",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.end,
                                        style: titleNew.copyWith(fontSize: 16),
                                      ),
                                      SizedBox(height: 10),
                                      _buildBuyer(context, state),
                                      SizedBox(height: 20),
                                      GestureDetector(
                                        onTap: () {
                                          _showDatePicker(context);
                                        },
                                        child: AbsorbPointer(
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            textAlign: TextAlign.end,
                                            controller:
                                                _dateOfTransactionController,
                                            style: textInput,
                                            keyboardType: TextInputType.text,
                                            autocorrect: false,
                                            decoration: InputDecoration(
                                              prefix: Text(
                                                'date_of_transaction'.tr,
                                                style: textInput.copyWith(
                                                    color: Colors.grey),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: _colorRedAccent,
                                                    width: 1.0),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 10.0),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: beginGradientColor,
                                                    width: 1.6),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: beginGradientColor,
                                                    width: 0.7),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      _buildRowTextController(
                                        title: 'num_of_contract',
                                        controller: _numOfContractController,
                                        textInputType: TextInputType.text,
                                      ),
                                      SizedBox(height: 10),
                                      _buildRowTextController(
                                        title: 'trip_number',
                                        controller: _tripNumberController,
                                        textInputType: TextInputType.text,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4),
                          state.data.isSelectedMethodTransaction == 0
                              ? Container(
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "TỔng giao dich",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                              style: titleNew.copyWith(
                                                  fontSize: 16),
                                            ),
                                            SizedBox(height: 10),
                                            _buildRowTotalMoney(
                                                context,
                                                'total_reward_4c',
                                                totalReward4c),
                                            SizedBox(height: 10),
                                            _buildRowTotalMoney(context,
                                                'total_price', totalPrice),
                                            SizedBox(height: 10),
                                            _buildRowTotalMoney(
                                                context, 'total', total,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                colorMoney: Colors.black),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox.shrink(),
                          SizedBox(height: 10),
                        ],
                      )))),
        ),
      ),
    );
  }

  Widget _buildRowTotalMoney(BuildContext context, String title, double total,
      {FontWeight fontWeight, double fontSize, Color color, Color colorMoney}) {
    return Row(
      children: [
        Text(title.tr,
            style: TextStyle(
                color: color ?? Colors.black,
                fontSize: fontSize ?? 16,
                fontWeight: fontWeight ?? FontWeight.w400)),
        SizedBox(width: 5),
        Expanded(
          child: AutoSizeText(
            currencyformatterSymbol.format(total),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: TextStyle(
                color: colorMoney ?? Colors.black,
                fontSize: fontSize ?? 16,
                fontWeight: fontWeight ?? FontWeight.w400),
          ),
        ),
      ],
    );
  }

  Widget _buildBuyer(context, state) {
    String userTypeText = 'farm'.tr;

    String _typeOfUser(int userType) {
      switch (userType) {
        case 2:
          return userTypeText = 'farm'.tr;
        case 3:
          return userTypeText = 'farmer_4c'.tr;
        case 4:
          return userTypeText = 'host'.tr;
        case 5:
          return userTypeText = 'manager'.tr;
        default:
          return userTypeText = 'none'.tr;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('id_buyer'.tr, style: textInput),
        SizedBox(height: 10),
        state.data.members == null
            ? Text(
                'empty_member'.tr,
                style: textInput,
              )
            : ListView.separated(
                primary: true,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = state.data.members.elementAt(index);
                  final fullName =
                      '${item?.lastName ?? ''} ${item?.firstName ?? ''}';
                  _typeOfUser(item?.permission ?? 1);
                  return InkWell(
                      onTap: () {
                        context.read<Transaction4cCubit>().onSelectItem(item);
                      },
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                        image: item.avatarUrl != null
                                            ? CachedNetworkImageProvider(
                                                item.avatarUrl ?? '')
                                            : new AssetImage(
                                                Images.defaultAvatar),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  item.id == state.data?.partnerSelect?.id ?? -1
                                      ? Container(
                                          height: 60,
                                          width: 60,
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.5),
                                            shape: BoxShape.circle,
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/images/check_icon.svg',
                                            color: Colors.white,
                                          ))
                                      : SizedBox.shrink()
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fullName,
                                  style: titleNew,
                                ),
                                SizedBox(height: 10),
                                Text("Thành viên : " + userTypeText,
                                    style: descNew),
                              ],
                            ),
                          ),
                        ],
                      ));
                },
                separatorBuilder: (context, index) => Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: DottedLine(color: Colors.grey, height: 1),
                  ),
                ),
                itemCount: state.data.members.length,
              ),
      ],
    );
  }

  Widget _buildListTypeOfProduct(
      BuildContext context, Transaction4cState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('choose_type_product'.tr, style: textInput),
        SizedBox(height: 10),
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            primary: true,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _listTypeOfProduct.length,
            itemBuilder: (context, index) {
              final item = _listTypeOfProduct.elementAt(index);
              double margin = 10;
              return GestureDetector(
                  onTap: () => context
                      .read<Transaction4cCubit>()
                      .isSelectedTypeOfProduct(index),
                  child: Container(
                      margin: EdgeInsets.only(right: margin),
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(width: 0.5),
                        color: state.data.isSelectedTypeOfProduct == index
                            ? appIconColor
                            : whiteColor,
                      ),
                      child: Center(
                          child: Text(
                        item,
                        style: textInput.copyWith(
                          color: state.data.isSelectedTypeOfProduct == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ))));
            },
          ),
        ),
      ],
    );
  }

  Widget _buildListMethodTransaction(
      BuildContext context, Transaction4cState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('choose_method_transaction'.tr, style: textInput),
        SizedBox(height: 10),
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            primary: true,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _listMethodTransaction.length,
            itemBuilder: (context, index) {
              final item = _listMethodTransaction.elementAt(index);
              double margin = 10;
              return GestureDetector(
                  onTap: () => context
                      .read<Transaction4cCubit>()
                      .isSelectedMethodTransaction(index),
                  child: Container(
                      margin: EdgeInsets.only(right: margin),
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(width: 0.5),
                        color: state.data.isSelectedMethodTransaction == index
                            ? appIconColor
                            : whiteColor,
                      ),
                      child: Center(
                          child: Text(
                        item,
                        style: textInput.copyWith(
                          color: state.data.isSelectedMethodTransaction == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ))));
            },
          ),
        ),
      ],
    );
  }

  _showDatePicker(BuildContext context) {
    DateTime _timeTransactionSelect = _timeTransaction;

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
                          style:
                              textButton.copyWith(color: beginGradientColor)),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height:
                          MediaQuery.of(context).copyWith().size.height * 0.3,
                      child: CupertinoDatePicker(
                        maximumDate: DateTime.now(),
                        initialDateTime: _timeTransaction,
                        onDateTimeChanged: (DateTime newDate) {
                          _timeTransactionSelect = newDate;
                        },
                        minuteInterval: 1,
                        mode: CupertinoDatePickerMode.date,
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        _dateOfTransactionController.text =
                            _dateFormat.format(_timeTransactionSelect);
                        _timeTransaction = _timeTransactionSelect;
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
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildRowTextController(
      {String title,
      TextEditingController controller,
      TextInputType textInputType,
      TextInputAction textInputAction,
      String unitPrice}) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: controller,
      style: textInput,
      keyboardType: textInputType,
      autocorrect: false,
      decoration: InputDecoration(
        hintStyle: descNew.copyWith(color: Colors.grey),
        hintText: title.tr,
        suffixIcon: Center(
          widthFactor: 1.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              unitPrice ?? "",
            ),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _colorRedAccent, width: 1.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: beginGradientColor, width: 1.6),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: beginGradientColor, width: 0.7),
        ),
      ),
    );
  }

  Widget _buildRowTextPriceController(
      {String title,
      TextEditingController controller,
      TextInputType textInputType,
      TextInputAction textInputAction,
      String unitPrice}) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: controller,
      style: textInput,
      keyboardType: textInputType,
      inputFormatters: [
        CurrencyTextInputFormatter(
          locale: 'vi_VN',
          decimalDigits: 0,
          symbol: '',
        )
      ],
      autocorrect: false,
      decoration: InputDecoration(
        hintStyle: descNew.copyWith(color: Colors.grey),
        hintText: title.tr,
        suffixIcon: Center(
          widthFactor: 1.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              unitPrice ?? "",
            ),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _colorRedAccent, width: 1.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: beginGradientColor, width: 1.6),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: beginGradientColor, width: 0.7),
        ),
      ),
    );
  }
}
