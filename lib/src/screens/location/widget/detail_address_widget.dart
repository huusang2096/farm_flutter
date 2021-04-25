import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/screens/location/cubit/user_place_cubit.dart';
import 'package:flutter/material.dart';

class DetailAddress extends StatelessWidget {
  const DetailAddress({
    Key key,
    this.isDisable,
    this.size,
    this.onPressLocation,
    this.onPressAddress,
    this.state,
  }) : super(key: key);
  final bool isDisable;
  final Size size;
  final UserPlaceState state;
  final Function onPressLocation;
  final Function onPressAddress;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 30.0,
      right: 30.0,
      top: 0.0,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(0),
          width: size.width * 0.8,
          height: size.height * 0.08,
          decoration: BoxDecoration(
              borderRadius: new BorderRadius.all(Radius.circular(8)),
              gradient: linearGradient),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    onPressLocation();
                  },
                  child: Container(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    width: 40.0,
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      onPressAddress();
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        state.myPlace.formattedAddress ?? "",
                        maxLines: 2,
                        style: textInput.copyWith(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
