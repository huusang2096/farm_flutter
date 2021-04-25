import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'package:simplest/simplest.dart';

import 'config.dart';

Future<BitmapDescriptor> createBitmapDescriptor(
    BuildContext context, String assetImage,
    {int width = 70}) async {
  final Uint8List markerIcon =
      await getBytesFromAsset(context, assetImage, width);
  return BitmapDescriptor.fromBytes(markerIcon);
}

Future<Uint8List> getBytesFromAsset(
    BuildContext context, String path, int width) async {
  ByteData data = await DefaultAssetBundle.of(context).load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
      .buffer
      .asUint8List();
}

String layout = 'list';
String _chars =
    'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

String calculatePolygonArea(List<LatLng> coordinates) {
  List<mp.LatLng> listPoints = [];
  coordinates.forEach((point) {
    listPoints.add(new mp.LatLng(point.latitude, point.longitude));
  });
  return new NumberFormat("#,###")
      .format(mp.SphericalUtil.computeArea(listPoints));
}

String timeAgoSinceDate(String timestamp) {
  var now = new DateTime.now();
  var date = DateTime.parse(timestamp);
  var difference = now.difference(date);

  if (difference.inDays > 8) {
    return dayFormatter.format(date);
  } else if ((difference.inDays / 7).floor() >= 1) {
    return '1';
  } else if (difference.inDays >= 2) {
    return '${difference.inDays}';
  } else if (difference.inDays >= 1) {
    return '1';
  } else if (difference.inHours >= 2) {
    return '${difference.inHours}';
  } else if (difference.inHours >= 1) {
    return '1';
  } else if (difference.inMinutes >= 2) {
    return '${difference.inMinutes} ';
  } else if (difference.inMinutes >= 1) {
    return '1';
  } else if (difference.inSeconds >= 3) {
    return '${difference.inSeconds}';
  } else {
    return 'just_now';
  }
}

String lableTimeDate(String timestamp, {bool numericDates = true}) {
  var now = new DateTime.now();
  var date = DateTime.parse(timestamp);
  var difference = now.difference(date);

  if (difference.inDays > 8) {
    return "";
  } else if ((difference.inDays / 7).floor() >= 1) {
    return 'week_ago'.tr;
  } else if (difference.inDays >= 2) {
    return 'days_ago'.tr;
  } else if (difference.inDays >= 1) {
    return 'day_ago'.tr;
  } else if (difference.inHours >= 2) {
    return 'hours_ago'.tr;
  } else if (difference.inHours >= 1) {
    return 'hour_ago'.tr;
  } else if (difference.inMinutes >= 2) {
    return 'minutes_ago'.tr;
  } else if (difference.inMinutes >= 1) {
    return 'minute_ago'.tr;
  } else if (difference.inSeconds >= 3) {
    return 'seconds_ago'.tr;
  } else {
    return '';
  }
}

String time(String time) {
  return timeAgoSinceDate(time) + " " + lableTimeDate(time);
}
