import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/action.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/widget/input/inputProduct/input_product_widget.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color _colorRedAccent = Colors.redAccent;
const Color _colorGrey = Colors.grey;

class ActionInputProductWidget extends StatefulWidget {
  ActionModel actionModel;
  String type;
  String image;
  int index = 0;
  ActionInputProductWidget(this.actionModel, this.index, this.type, this.image);

  @override
  _ActionProductPriceWidget createState() => _ActionProductPriceWidget();
}

class _ActionProductPriceWidget extends State<ActionInputProductWidget>
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
              FDottedLine(
                color: appIconColor,
                height: 30,
              ),
            ],
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 6),
              height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  SizedBox(height: 10)
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
            return InputProductItemWidget(
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
