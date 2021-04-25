import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/action.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

// ignore: must_be_immutable
class ActionItemWidget extends StatelessWidget {
  final InputProduct actionType;
  final String type;
  final String image;
  final Function(InputProduct) onSelectActionType;
  const ActionItemWidget(
      {Key key,
      this.actionType,
      this.type,
      this.onSelectActionType,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSelectActionType(actionType);
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
                  imageUrl: image,
                ),
              ),
              actionType.isSelect == 1
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
              actionType.name,
              style: descNew,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
