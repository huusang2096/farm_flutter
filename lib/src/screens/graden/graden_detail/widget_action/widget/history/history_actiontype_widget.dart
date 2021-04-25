import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/garden_history_action_response.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/widget/history/history_action_text_widget.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/widget/history/inputProduct/history_product_widget.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_history_action/bloc/history_action_cubit.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

import 'history_action_list_widget.dart';

class HistoryActionTypeWidget
    extends CubitWidget<HistoryActionCubit, HistoryActionState> {
  HistoryActionModel item;
  HistoryActionTypeWidget(this.item);

  static provider({HistoryActionModel item}) {
    return BlocProvider(
      create: (context) => HistoryActionCubit(),
      child: HistoryActionTypeWidget(item),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    super.afterFirstLayout(context);
  }

  @override
  Widget builder(BuildContext context, HistoryActionState state) {
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
              padding: EdgeInsets.only(left: 16),
              child: Text(item.detailType.name.tr,
                  style: titleNew.copyWith(color: Colors.black)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 8, bottom: 16),
              child: Text(
                  'history_des'
                      .tr
                      .trArgs(['${item.detailType.name ?? ''}', ' ']),
                  style: titleBar.copyWith(color: Colors.black)),
            ),
            Container(height: 5, color: backgroundColor),
            Expanded(
              child: ListView.builder(
                primary: true,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                addAutomaticKeepAlives: true,
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  HistoryActionModel historyActionModel = item;
                  if (historyActionModel.detailType.actions
                          .elementAt(index)
                          .unitPrice ==
                      "Công") {
                    return HistoryProductItemWidget(
                        item.detailType.actions.elementAt(index),
                        index,
                        item.detailType.image);
                  } else if (historyActionModel.detailType.actions
                          .elementAt(index)
                          .inputType ==
                      "input_product") {
                    return HistoryActionListWidget(
                        item.detailType.actions.elementAt(index),
                        index,
                        item.detailType.image);
                  } else {
                    return HistoryActionInputTextWidget(
                        item.detailType.actions.elementAt(index), index);
                  }
                },
                itemCount: item.detailType.actions.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
