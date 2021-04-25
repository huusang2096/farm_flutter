import 'package:farmgate/src/common/config.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class MapTypeItemWidget extends StatefulWidget {
  final String mapTypeName;
  final String icon;
  final MapType mapType;
  final Function(MapType) onSelectMapType;
  const MapTypeItemWidget(
      {Key key,
      this.mapType,
      this.icon,
      this.onSelectMapType,
      this.mapTypeName})
      : super(key: key);

  @override
  _MapTypeItemWidgetState createState() => _MapTypeItemWidgetState();
}

class _MapTypeItemWidgetState extends State<MapTypeItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          widget.onSelectMapType(widget.mapType);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                child: Container(
                    padding: const EdgeInsets.all(12.0),
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      gradient: linearGradient,
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    child: SvgPicture.asset(
                      widget.icon,
                      color: Colors.white,
                    )),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              Expanded(
                child: Text(widget.mapTypeName, style: titleNew),
              ),
            ],
          ),
        ));
  }
}
