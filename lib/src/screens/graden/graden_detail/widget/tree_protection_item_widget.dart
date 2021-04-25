import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/graden_detail_response.dart';
import 'package:farmgate/src/model/graden/plant_protection_products.dart';
import 'package:farmgate/src/screens/graden/plantprotect/widget/plant_protect_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

// ignore: must_be_immutable
class TreeProtectionItemWidget extends StatelessWidget {
  final GardenPlantProtectionProduct plantProtect;
  final double marginLeft;
  const TreeProtectionItemWidget({Key key, this.plantProtect, this.marginLeft})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProtectionGarden protectionGarden = plantProtect.plantProtectionProduct;
    return GestureDetector(
      onTap: () {
        _showModalBottomSheet(plantProtect, context);
      },
      child: Container(
        margin: EdgeInsets.only(left: marginLeft),
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            height: 100.0,
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.0, right: 4.0, left: 4.0),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                protectionGarden.image),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${protectionGarden?.name ?? ''}',
                            maxLines: 2,
                            style: titleNew.copyWith(fontSize: 14.0),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.remove_red_eye_outlined,
                          size: 20.0,
                          color: appIconColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showModalBottomSheet(GardenPlantProtectionProduct plantProtectionProducts,
      BuildContext context) {
    showModalBottomSheet(
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
                child: PlantProtectItemWidget(
                    protectionGarden: plantProtectionProducts),
              );
            },
          );
        });
  }
}
