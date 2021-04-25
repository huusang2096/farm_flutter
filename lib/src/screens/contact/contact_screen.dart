import 'dart:async';

import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/screens/contact/cubit/contact_cubit.dart';
import 'package:farmgate/src/screens/contact/widget/contact_field_validatior.dart';
import 'package:farmgate/src/screens/contact/widget/text_form_field_widget.dart';
import 'package:farmgate/src/widgets/logo_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class ContactScreen extends CubitWidget<ContactCubit, ContactState> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtNameController = TextEditingController();
  final TextEditingController _txtAddressController = TextEditingController();
  final TextEditingController _txtContentController = TextEditingController();
  final TextEditingController _txtPhoneController = TextEditingController();
  final TextEditingController _txtEmailController = TextEditingController();
  final TextEditingController _txtSubjectController = TextEditingController();
  final ContactValidations _validations = ContactValidations();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor bitmapDescriptorSource, bitmapDescriptorDes;

  static provider() {
    return BlocProvider(
      create: (context) => ContactCubit(),
      child: ContactScreen(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<ContactCubit>().setCurrentLocation();
  }

  @override
  void listener(BuildContext context, ContactState state) {
    // TODO: implement listener
    if (state is SendContact) {
      _txtNameController.clear();
      _txtAddressController.clear();
      _txtContentController.clear();
      _txtPhoneController.clear();
      _txtEmailController.clear();
      _txtSubjectController.clear();
    }
  }

  @override
  Widget builder(BuildContext context, ContactState state) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: greyColor),
        title: LogoWidget(
          urlImg: Images.logoIcon,
          bottom: 0,
        ),
        centerTitle: true,
        elevation: 1.0,
        actions: [
          state.data.isLoading
              ? Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: SpinKitCircle(
                    color: appIconColor,
                    size: 28,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: Icon(
                      Icons.check,
                      color: appIconColor,
                      size: 30,
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        context.read<ContactCubit>().sendContact(
                            _txtNameController.text,
                            _txtContentController.text,
                            _txtEmailController.text,
                            address: state.data.myPlace?.formattedAddress ?? '',
                            phone: _txtPhoneController.text,
                            subject: _txtSubjectController.text);
                      }
                    },
                  ),
                ),
        ],
      ),
      body: _buildBody(context, state),
    );
  }

  buildGoogleMap() {
    final MarkerId markerIdSource = MarkerId("sourcePin");
    final Marker marker = Marker(
      markerId: markerIdSource,
      icon: bitmapDescriptorSource,
      position: LatLng(10.941991512400785, 106.82440422763561),
    );
    markers[markerIdSource] = marker;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: appIconColor,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: GoogleMap(
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
            new Factory<OneSequenceGestureRecognizer>(
              () => new EagerGestureRecognizer(),
            ),
          ].toSet(),
          markers: Set<Marker>.of(markers.values),
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(10.941991512400785, 106.82440422763561),
            zoom: 14.4746,
          ),
          onMapCreated: (GoogleMapController controller) async {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }

  _buildBody(BuildContext context, ContactState state) {
    Size _size = MediaQuery.of(context).size;
    Widget addressWidget;
    if (state.data.myPlace?.formattedAddress == null) {
      addressWidget = Row(
        children: [
          Container(
            child: Icon(
              FontAwesomeIcons.locationArrow,
              color: Colors.white,
              size: 25.0,
            ),
            width: 40.0,
          ),
          Expanded(
              child: Center(
            child: SpinKitCircle(
              color: Colors.white,
              size: 28.0,
            ),
          )),
        ],
      );
    } else {
      addressWidget = Row(
        children: [
          SizedBox(width: 8),
          Expanded(
            child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(AppRoute.userPlaceScreen)
                      .then((value) => {
                            if (value != null)
                              {context.read<ContactCubit>().placeChange(value)}
                          });
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    state.data.myPlace?.formattedAddress ?? "",
                    maxLines: 2,
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AppRoute.userPlaceScreen)
                  .then((value) => {
                        if (value != null)
                          {context.read<ContactCubit>().placeChange(value)}
                      });
            },
            child: Container(
              child: Icon(
                Icons.add_location,
                color: Colors.white,
                size: 25.0,
              ),
              width: 40.0,
            ),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: _size.width, height: 200, child: buildGoogleMap()),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'tel'.tr + ': (84-251) 382 2486',
                    style: body1,
                  ),
                  Text('fax'.tr + ': (84-251) 382 3747', style: body1),
                  Text('Email: info@tinnghiacorp.com.vn', style: body1),
                  SizedBox(
                    height: 20,
                  ),
                  Text('contact_us'.tr, style: titleLogin),
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: double.infinity,
                            height: _size.height * 0.08,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                gradient: linearGradient),
                            child: addressWidget),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormFieldWidget(
                          maxLine: 8,
                          controller: _txtContentController,
                          validator: _validations.validateContent,
                          hintText: 'content'.tr,
                          icon: null,
                          textCaptilization: TextCapitalization.sentences,
                        ),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}
