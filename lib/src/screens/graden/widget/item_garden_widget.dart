import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/garden_menu.dart';
import 'package:farmgate/src/model/graden/graden_response.dart';
import 'package:farmgate/src/screens/graden/bloc/graden_cubit.dart';
import 'package:farmgate/src/widgets/image_network.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

// ignore: must_be_immutable
class ItemGradenWidget extends StatefulWidget {
  String herotag;
  MyGarden myGarden;
  ItemGradenWidget({Key key, this.herotag, this.myGarden}) : super(key: key);

  @override
  _ItemGradenWidgetState createState() => _ItemGradenWidgetState();
}

class _ItemGradenWidgetState extends State<ItemGradenWidget>
    with SingleTickerProviderStateMixin {
  AnimationController menuAnimation;
  GardenMenu gardenMenu = new GardenMenu();
  List<GardenMenu> menuItems = [];

  @override
  void initState() {
    menuItems = gardenMenu.getListMenu();
    menuAnimation = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    super.initState();
  }

  Widget flowMenuItem(GardenMenu gardenMenu, MyGarden myGarden) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: RawMaterialButton(
        fillColor: Colors.black.withOpacity(0.5),
        shape: CircleBorder(),
        onPressed: () {
          menuAnimation.status == AnimationStatus.completed
              ? menuAnimation.reverse()
              : menuAnimation.forward();
          if (gardenMenu.acitonType == ActionTypeMenu.view) {
            navigator.pushNamed(AppRoute.detailGardenScreen, arguments: {
              'img': widget.myGarden.getImage(),
              'id': widget.myGarden.id,
              'heroTag': widget.herotag,
              'data': widget.myGarden
            });
          } else if (gardenMenu.acitonType == ActionTypeMenu.edit) {
            _navigateToEditGarden();
          } else if (gardenMenu.acitonType == ActionTypeMenu.delete) {
            context.read<GradenCubit>().deleteGarden(myGarden);
          }
        },
        child: Icon(
          gardenMenu.icon,
          color: Colors.white,
          size: 20.0,
        ),
      ),
    );
  }

  void _navigateToEditGarden() async {
    await navigator.pushNamed(AppRoute.editGardenScreen,
        arguments: {'garden': widget.myGarden});
    context.read<GradenCubit>().getMyGarden();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigator.pushNamed(AppRoute.detailGardenScreen, arguments: {
          'img': widget.myGarden.getImage(),
          'id': widget.myGarden.id,
          'heroTag': widget.herotag,
          'data': widget.myGarden
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Stack(
          children: [
            Hero(
                tag: widget.herotag,
                child: ImageNetWork(
                    width: double.infinity,
                    height: 200,
                    borderRadius: 8,
                    imgUrl: widget.myGarden.getImage())),
            Container(
              width: double.infinity,
              height: 200,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 50,
              child: Flow(
                delegate: FlowMenuDelegate(menuAnimation: menuAnimation),
                children: menuItems
                    .map<Widget>((GardenMenu icon) =>
                        flowMenuItem(icon, widget.myGarden))
                    .toList(),
              ),
            ),
            Positioned(
              top: 65,
              left: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.myGarden.name,
                      textAlign: TextAlign.left,
                      style:
                          titleNew.copyWith(color: Colors.white, fontSize: 20)),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(widget.myGarden.description,
                        textAlign: TextAlign.left,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: descNew.copyWith(color: Colors.white)),
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  FlowMenuDelegate({this.menuAnimation}) : super(repaint: menuAnimation);

  final Animation<double> menuAnimation;

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) {
    return menuAnimation != oldDelegate.menuAnimation;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0.0;
    for (int i = 0; i < context.childCount; ++i) {
      dx = (context.getChildSize(i).width * i) * 3 / 4;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          dx * menuAnimation.value,
          0,
          0,
        ),
      );
    }
  }
}
