import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/manager_project/history_project.dart';
import 'package:farmgate/src/model/manager_project/mem_partner_project_response.dart';
import 'package:farmgate/src/screens/contact/widget/text_form_field_widget.dart';
import 'package:farmgate/src/screens/manager_project/manager_project_detail/confirm_transaction/cubit/confirm_transaction_cubit.dart';
import 'package:farmgate/src/widgets/app_progress_hub.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class ConfirmTransactionScreen
    extends CubitWidget<ConfirmTransactionCubit, ConfirmTransactionState> {
  final int request;

  ConfirmTransactionScreen({this.request});

  final double _margin = 10.0;

  static provider({int id}) {
    return BlocProvider(
      create: (_) => ConfirmTransactionCubit(),
      child: ConfirmTransactionScreen(request: id),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<ConfirmTransactionCubit>().getDetailTrainsaction(request);
    super.afterFirstLayout(context);
  }

  @override
  Widget builder(BuildContext context, ConfirmTransactionState state) {
    final Size size = MediaQuery.of(context).size;
    return AppProgressHUB(
      inAsyncCall: state.data.isLoading,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
              child: state.data.historyTransaction != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: whiteColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'detail_product'.tr, //Chi tiết hàng hóa
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                      style: titleNew.copyWith(fontSize: 16),
                                    ),
                                    SizedBox(height: 10),
                                    // _buildTypeOfProduct(),
                                    _buildTextType(
                                        title: 'choose_type_product',
                                        value: state
                                            .data.historyTransaction.typeGoods),
                                    SizedBox(height: 10),
                                    // _buildTextQuantityProduct(),
                                    _contentValue(
                                        title: 'quantity_product',
                                        value: currencyFormatter.format(
                                            double.parse(state
                                                .data
                                                .historyTransaction
                                                .amountSale))),
                                  ],
                                ),
                              )
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'method_transaction'
                                          .tr, // hình thức giao dịch
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                      style: titleNew.copyWith(fontSize: 16),
                                    ),
                                    SizedBox(height: 10),
                                    // _buildListMethodTransaction(context, state),
                                    _buildTextType(
                                        title: 'choose_method_transaction',
                                        value: state
                                            .data.historyTransaction.typeSale),
                                    SizedBox(height: 10),
                                    state.data.historyTransaction.typeSale ==
                                            'sell'.tr
                                        ? _contentValue(
                                            title: 'price_per_unit',
                                            value: currencyformatterSymbol
                                                .format(double.parse(state.data
                                                    .historyTransaction.price)))
                                        : SizedBox.shrink(),
                                    SizedBox(height: 10),
                                    _contentValue(
                                        title: 'reward_4c',
                                        value: currencyformatterSymbol.format(
                                            double.parse(state.data
                                                .historyTransaction.bonus4C))),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "detail_transaction"
                                          .tr, //Chi tiết giao dich
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                      style: titleNew.copyWith(fontSize: 16),
                                    ),
                                    SizedBox(height: 10),
                                    // _buildBuyer(context, state),
                                    Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: _buildMember(
                                                    context,
                                                    state
                                                        .data
                                                        .historyTransaction
                                                        .memberSale,
                                                    'seller'.tr),
                                              ),
                                              Icon(
                                                FontAwesomeIcons.exchangeAlt,
                                                color: beginGradientColor,
                                                size: 26,
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: _buildMember(
                                                    context,
                                                    state
                                                        .data
                                                        .historyTransaction
                                                        .memberBuy,
                                                    'buyer'.tr),
                                              )
                                            ]),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    _contentValue(
                                        title: 'date_of_transaction',
                                        value: fullDateFormatter.format(state
                                            .data.historyTransaction.dateSale)),
                                    SizedBox(height: 10),
                                    _contentValue(
                                        title: 'num_of_contract',
                                        value: state.data.historyTransaction
                                                .numberContract ??
                                            ""),
                                    SizedBox(height: 10),
                                    _contentValue(
                                        title: 'trip_number',
                                        value: state.data.historyTransaction
                                                .numberMove ??
                                            ""),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4),
                        state.data.historyTransaction.typeSale ==
                                'send_to_warehouse'.tr
                            ? SizedBox.shrink()
                            : Container(
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
                                            'total_transactions'.tr,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.end,
                                            style:
                                                titleNew.copyWith(fontSize: 16),
                                          ),
                                          SizedBox(height: 10),
                                          _buildRowTotalMoney(
                                              context,
                                              'total_reward_4c',
                                              double.parse(state
                                                  .data
                                                  .historyTransaction
                                                  .totalBonus4C)),
                                          SizedBox(height: 10),
                                          _buildRowTotalMoney(
                                              context,
                                              'total_price',
                                              double.parse(state
                                                      .data
                                                      .historyTransaction
                                                      .totalMoney) -
                                                  double.parse(state
                                                      .data
                                                      .historyTransaction
                                                      .totalBonus4C)),
                                          SizedBox(height: 10),
                                          _buildRowTotalMoney(
                                              context,
                                              'total',
                                              double.parse(state
                                                  .data
                                                  .historyTransaction
                                                  .totalMoney),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              colorMoney: Colors.black),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        SizedBox(height: 4),
                        state.data.historyTransaction.status == 'cancel'
                            ? Container(
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
                                            'reason_for_cancellation'.tr,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.end,
                                            style:
                                                titleNew.copyWith(fontSize: 16),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(width: 1),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    state
                                                        .data
                                                        .historyTransaction
                                                        .reason,
                                                    style: descNew.copyWith(
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox.shrink(),
                        state.data.historyTransaction.status == 'pending'
                            ? _builOrderAction(
                                context, state.data.historyTransaction)
                            : SizedBox.shrink(),
                      ],
                    )
                  : _shimmerConfirmTransaction(size)),
        ),
      ),
    );
  }

  Widget _builOrderAction(BuildContext context, HistoryTransaction item) {
    ConfirmTransactionCubit cubit = context.read<ConfirmTransactionCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Flexible(
          flex: 1,
          child: FlatButton(
              onPressed: () {
                _showReason(
                    context, cubit, item.id, false, item.transactionType);
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: new BorderRadius.all(Radius.circular(10))),
                child: Text(
                  'cancel'.tr,
                  style: title.copyWith(color: Colors.white),
                ),
              )),
        ),
        item.transactionType != 'sale'
            ? Flexible(
                flex: 1,
                child: FlatButton(
                    onPressed: () {
                      cubit.buyConfrim(item.id);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius:
                              new BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        'confirm'.tr,
                        style: title.copyWith(color: Colors.white),
                      ),
                    )),
              )
            : SizedBox.shrink()
      ]),
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

  Widget _buildTextType({String title, String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title.tr, style: textInput),
        Container(
          margin: EdgeInsets.only(right: _margin),
          height: 40,
          width: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(width: 0.5),
              color: appIconColor),
          child: Center(
            child: Text(
              value,
              style: textInput.copyWith(
                color: whiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _contentValue({String title, String value}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Text(
              title.tr,
              style: descNew.copyWith(color: Colors.grey),
            ),
            Expanded(
              child: AutoSizeText(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: descNew,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(color: greyColor),
      elevation: 1.0,
      title: Text(
        'confirm_transaction'.tr,
        style: headingBlack18,
      ),
      centerTitle: true,
    );
  }

  Widget _showReason(BuildContext context, ConfirmTransactionCubit cubit,
      int id, bool isConfrim, String type) {
    final TextEditingController _txtContentController = TextEditingController();
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
                  child: SingleChildScrollView(
                    child: Container(
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
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text('reason_for_cancellation'.tr,
                                style: textButton.copyWith(
                                    color: beginGradientColor)),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: TextFormFieldWidget(
                              maxLine: 8,
                              controller: _txtContentController,
                              hintText: 'content'.tr,
                              icon: null,
                              textCaptilization: TextCapitalization.sentences,
                            ),
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              cubit.send(id,
                                  _txtContentController.text.toString(), type);
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  gradient: linearGradient),
                              padding: EdgeInsets.all(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                  ));
            },
          );
        });
  }

  Widget _buildMember(context, MemberPartner member, String text) {
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

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(text, style: textInput),
            SizedBox(height: 10),
            AutoSizeText(
              '${member?.lastName ?? ''} ${member?.firstName ?? ''}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: titleNew,
            ),
            SizedBox(height: 10), //54
            AutoSizeText(
              _typeOfUser(member.permission),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: descNew,
            ),
            SizedBox(height: 10),
            AutoSizeText(
              member.phone,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: descNew,
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerConfirmTransaction(Size size) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: whiteColor,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 100,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: whiteColor,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
