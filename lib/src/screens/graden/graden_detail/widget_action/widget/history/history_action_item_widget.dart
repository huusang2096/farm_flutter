import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/action.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

// ignore: must_be_immutable
class HistoryActionItemWidget extends StatefulWidget {
  final InputProduct actionType;
  final String type;
  final Function(InputProduct) onSelectActionType;
  const HistoryActionItemWidget(
      {Key key, this.actionType, this.type, this.onSelectActionType})
      : super(key: key);

  @override
  _HistoryActionItemWidgetState createState() =>
      _HistoryActionItemWidgetState();
}

class _HistoryActionItemWidgetState extends State<HistoryActionItemWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onSelectActionType(widget.actionType);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(60.0),
                child: CachedNetworkImage(
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.cover,
                  imageUrl: widget.type,
                ),
              ),
              widget.actionType.isSelect == 1
                  ? ClipRRect(
                      child: Container(
                          width: 60.0,
                          height: 60.0,
                          padding: EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/check_icon.svg',
                            color: Colors.white,
                          )))
                  : SizedBox.shrink(),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
          ),
          Expanded(
            child: Text(
              widget.actionType.name,
              style: descNew,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  String _buildIconPath(String type) {
    String iconPath = "";

    switch (type) {
      case "waterring":
        iconPath = Images.gardenIconWatering;
        break;
      case "cut":
        iconPath = Images.gardenIconCutBranch;
        break;
      case "fertilize":
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
