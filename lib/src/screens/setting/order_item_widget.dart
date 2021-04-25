import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/garden_history_action_response.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/widget/history/history_actiontype_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class ActionHistoryItemWidget extends StatelessWidget {
  HistoryActionModel item;

  ActionHistoryItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => _showActionType(context, item),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: beginGradientColor)),
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CachedNetworkImage(
                  height: 60,
                  width: 60,
                  imageUrl: item.detailType.image,
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Nhân", style: titleNew),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget> _showActionType(
      BuildContext context, HistoryActionModel item) async {
    await showModalBottomSheet(
        elevation: 10,
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext builder) {
          return StatefulBuilder(
            builder: (context, state) {
              return AnimatedPadding(
                  padding: MediaQuery.of(context).viewInsets,
                  duration: const Duration(milliseconds: 10),
                  curve: Curves.decelerate,
                  child: HistoryActionTypeWidget.provider(item: item));
            },
          );
        });
  }
}
