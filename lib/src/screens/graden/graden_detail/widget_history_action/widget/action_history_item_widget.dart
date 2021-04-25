import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/garden_history_action_response.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/widget/history/history_actiontype_widget.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/widget/input/edit_actiontype_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class ActionHistoryItemWidget extends StatelessWidget {
  HistoryActionModel item;

  ActionHistoryItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    String tree = item.detailType.actions
        .firstWhere((action) => action.inputType == 'input_tree')
        .inputData;
    bool isEdit = isCheckEdit(item);

    String _buildIconPath(String type) {
      String iconPath = "";

      switch (type) {
        case "watering":
          iconPath = Images.gardenIconWatering;
          break;
        case "cut_branches":
          iconPath = Images.gardenIconCutBranch;
          break;
        case "fertilization":
          iconPath = Images.gardenIconFerilizer;
          break;
        case "harvest":
          iconPath = Images.gardenIconHarvest;
          break;
        case "processing":
          iconPath = Images.gardenIconFoodProcessing;
          break;
      }
      return iconPath;
    }

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
            mainAxisAlignment: MainAxisAlignment.start,
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
                    Text(item.detailType.name, style: titleNew),
                    tree == null ? SizedBox.shrink() : SizedBox(height: 5),
                    tree == null
                        ? SizedBox.shrink()
                        : Text(tree ?? "",
                            textAlign: TextAlign.left, style: descNew),
                    SizedBox(height: 2),
                    Text(
                        fullDateFormatter
                            .format(DateTime.parse(item.createdAt)),
                        textAlign: TextAlign.left,
                        style: descNew),
                  ],
                ),
              ),
              isEdit
                  ? IconButton(
                      onPressed: () {
                        _showEditActionType(context, item);
                      },
                      icon: Icon(
                        Icons.edit,
                        color: appBarColor,
                        size: 25.0,
                      ),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }

  bool isCheckEdit(HistoryActionModel item) {
    try {
      var now = new DateTime.now();
      var date = DateTime.parse(item.createdAt);
      var difference = now.difference(date);
      return difference.inDays <= 7;
    } catch (e) {
      return false;
    }
  }

  Future<Widget> _showEditActionType(
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
                  child:
                      EditActionTypeWidget.provider(action: item, gardenId: 1));
            },
          );
        });
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
