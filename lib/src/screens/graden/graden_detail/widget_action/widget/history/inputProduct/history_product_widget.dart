import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'history_product_item_widget.dart';

const Color _colorRedAccent = Colors.redAccent;
const Color _colorGrey = Colors.grey;

class HistoryProductItemWidget extends StatefulWidget {
  ActionModel actionModel;
  String image;
  int index = 0;
  HistoryProductItemWidget(this.actionModel, this.index, this.image);

  @override
  _ActionProductPriceWidget createState() => _ActionProductPriceWidget();
}

class _ActionProductPriceWidget extends State<HistoryProductItemWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(children: [
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
            ],
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: widget.actionModel.unitName + ": ",
                          style: body1.copyWith(color: Colors.black)),
                      TextSpan(
                          text: '*',
                          style: body1.copyWith(color: _colorRedAccent))
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ]),
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          addAutomaticKeepAlives: true,
          itemCount: widget.actionModel.inputProduct.length,
          itemBuilder: (context, index) {
            InputProduct actiontype =
                widget.actionModel.inputProduct.elementAt(index);
            return HistoryInputProductItemWidget(
              actionType: actiontype,
            );
          },
        )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
