import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/bloc/garden_action_cubit.dart';
import 'package:farmgate/src/widgets/app_progress_hub.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class OrderWidget extends CubitWidget<GardenActionCubit, GardenActionState> {
  static provider() {
    return BlocProvider(
      create: (context) => GardenActionCubit(),
      child: OrderWidget(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    super.afterFirstLayout(context);
  }

  @override
  Widget builder(BuildContext context, GardenActionState state) {
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
                child: Text("Hoa don",
                    style: titleNew.copyWith(color: Colors.black)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 8, bottom: 16),
                child: Text("Namdoan",
                    style: titleBar.copyWith(color: Colors.black)),
              ),
              Container(height: 5, color: backgroundColor),
              Expanded(
                child: AppProgressHUB(
                    inAsyncCall: state.data.isShow,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [],
                      ),
                    )),
              ),
            ],
          )),
    );
  }
}
