import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/graden_detail_response.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/widget/history/history_action_list_widget.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/widget/history/history_action_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class PlantProtectItemWidget extends StatelessWidget {
  final GardenPlantProtectionProduct protectionGarden;

  PlantProtectItemWidget({this.protectionGarden});

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: appIconColor,
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: protectionGarden.plantProtectionProduct.image,
                      memCacheWidth: 250,
                      imageBuilder: (ctx, imgProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imgProvider,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    protectionGarden.plantProtectionProduct.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 4.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: backgroundColor,
              ),
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
                  if (protectionGarden.data.actions
                          .elementAt(index)
                          .inputType ==
                      "input_product") {
                    return HistoryActionListWidget(
                        protectionGarden.data.actions.elementAt(index),
                        index,
                        protectionGarden.data.image);
                  } else {
                    return HistoryActionInputTextWidget(
                        protectionGarden.data.actions.elementAt(index), index);
                  }
                },
                itemCount: protectionGarden.data.actions.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
