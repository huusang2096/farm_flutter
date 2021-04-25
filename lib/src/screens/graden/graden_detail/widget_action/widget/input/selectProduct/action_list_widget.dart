import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/action.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/widget/input/selectProduct/action_item_widget.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class ActionListWidget extends StatefulWidget {
  ActionModel actionModel;
  String type;
  String image;
  int index = 0;
  ActionListWidget(this.actionModel, this.index, this.type, this.image);

  @override
  _ActionListWidgetState createState() => _ActionListWidgetState();
}

class _ActionListWidgetState extends State<ActionListWidget>
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
                widget.index.toString(),
                textAlign: TextAlign.center,
                style: titleBar,
              ),
            )),
            SizedBox(width: 10),
            Container(
              alignment: Alignment.center,
              height: 30,
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: widget.actionModel.unitName.tr + ": ",
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
                height: widget.actionModel.inputProduct.length * 50.0,
              ),
              SizedBox(width: 26),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  addAutomaticKeepAlives: true,
                  itemCount: widget.actionModel.inputProduct.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 8,
                      childAspectRatio: 2.5),
                  itemBuilder: (context, index) {
                    InputProduct actiontype =
                        widget.actionModel.inputProduct.elementAt(index);
                    return ActionItemWidget(
                      actionType: actiontype,
                      type: widget.type,
                      image: widget.image,
                      onSelectActionType: (actionType) {
                        widget.actionModel.inputData = "check";
                        widget.actionModel.inputProduct.forEach((data) {
                          if (data.id == actionType.id) {
                            data.isSelect = 1;
                          } else {
                            data.isSelect = 0;
                          }
                        });
                        setState(() {});
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
