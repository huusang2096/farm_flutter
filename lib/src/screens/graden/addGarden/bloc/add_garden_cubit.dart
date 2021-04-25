import 'dart:convert';
import 'dart:io';

import 'package:farmgate/locator.dart';
import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/util.dart';
import 'package:farmgate/src/model/graden/add_garden_response.dart';
import 'package:farmgate/src/model/graden/boder_garden.dart';
import 'package:farmgate/src/model/graden/graden_response.dart';
import 'package:farmgate/src/model/graden/polygon_garden.dart';
import 'package:farmgate/src/model/place_response.dart';
import 'package:farmgate/src/model/review/ImageSelect.dart';
import 'package:farmgate/src/model/search_place_request.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simplest/simplest.dart';
import 'package:uuid/uuid.dart';

import 'add_garden_state.dart';

class AddGardenCubit extends BaseCubit<AddGardensState> {
  final locatorLocationService = locator<LocationService>();

  AddGardenCubit()
      : super(Initial(
            Data(imageSelects: [], myPlace: null, isLoading: false, list: [])));

  addImage(File file) async {
    List<ImageSelect> changeImageSelects = [...state.data.imageSelects];
    File compressedFile = file;
    if (file != null) {
      compressedFile =
          await FlutterNativeImage.compressImage(file.path, quality: 50);
    }
    ImageSelect imageSelect = new ImageSelect();
    imageSelect.url = compressedFile;
    imageSelect.id = Uuid().v4();
    changeImageSelects.insert(0, imageSelect);
    emit(ImageChange(state.data.copyWith(imageSelects: changeImageSelects)));
  }

  postData(String name, String description, String content) async {
    if (name.isEmpty) {
      snackbarService.showSnackbar(message: 'please_add_title_garden'.tr);
      return;
    }

    if (content.isEmpty) {
      snackbarService.showSnackbar(message: 'please_add_description_garden'.tr);
      return;
    }

    if (state.data.list.length == 0) {
      snackbarService.showSnackbar(message: 'please_add_border'.tr);
      return;
    }

    if (state.data.imageSelects.length == 1) {
      snackbarService.showSnackbar(message: 'please_add_image_garden'.tr);
      return;
    }

    List<File> files = [];
    state.data.imageSelects.forEach((element) {
      if (element.url != null) {
        files.add(element.url);
      }
    });

    try {
      emit(ImageChange(state.data.copyWith(isLoading: true)));
      AddGradenResponse addGradenResponse = await dataRepository.addGarden(
          name,
          description,
          state.data.myPlace.formattedAddress,
          json.encode(state.data.list),
          files);
      if (addGradenResponse != null) {
        emit(ImageChange(state.data.copyWith(isLoading: false)));
        navigator.pushReplacementNamed(AppRoute.detailGardenScreen, arguments: {
          'img': IMAGE_BASE_URL + addGradenResponse.data.image[0],
          'id': addGradenResponse.data.id,
          'heroTag': getRandomString(20),
          'data': addGradenResponse.data
        });
      }
    } catch (e) {
      emit(ImageChange(state.data.copyWith(isLoading: false)));
      handleAppError(e);
      logger.e(e);
    }
  }

  updateGarden(String name, String description, String content) async {
    if (name.isEmpty) {
      snackbarService.showSnackbar(message: 'please_add_title_post'.tr);
      return;
    }

    if (content.isEmpty) {
      snackbarService.showSnackbar(message: 'please_add_description_post'.tr);
      return;
    }

    if (state.data.list.length == 0) {
      snackbarService.showSnackbar(message: 'please_add_border'.tr);
      return;
    }

    if (state.data.imageSelects.length == 1) {
      snackbarService.showSnackbar(message: 'please_add_image'.tr);
      return;
    }

    List<File> files = [];
    state.data.imageSelects.forEach((element) {
      if (element.url != null) {
        files.add(element.url);
      }
    });

    try {
      String address = state.data.myPlace == null
          ? state.data.myGarden.address
          : state.data.myPlace.formattedAddress;
      emit(ImageChange(state.data.copyWith(isLoading: true)));
      AddGradenResponse addGradenResponse = await dataRepository.editGarden(
          state.data.myGarden.id,
          name,
          description,
          address,
          json.encode(state.data.list),
          files);
      if (addGradenResponse != null) {
        emit(ImageChange(state.data.copyWith(isLoading: false)));
        navigator.pushReplacementNamed(AppRoute.detailGardenScreen, arguments: {
          'img': IMAGE_BASE_URL + addGradenResponse.data.image[0],
          'id': addGradenResponse.data.id,
          'heroTag': getRandomString(20),
          'data': addGradenResponse.data
        });
      }
    } catch (e) {
      emit(ImageChange(state.data.copyWith(isLoading: false)));
      handleAppError(e);
      logger.e(e);
    }
  }

  addGarden(MyGarden myGarden) {
    List<ImageSelect> imageSelects = [];
    myGarden.image.forEach((element) {
      imageSelects.add(new ImageSelect(imageUrl: element, id: Uuid().v4()));
    });
    imageSelects.add(new ImageSelect(url: null));
    emit(AddGarden(state.data.copyWith(
        myGarden: myGarden,
        imageSelects: imageSelects,
        list: myGarden.locationPolygon)));
  }

  addBoder(BoderGarden boderGarden) async {
    List<LatLng> listData = boderGarden.list;
    List<LocationPolygon> list = [];
    listData.forEach((element) {
      list.add(new LocationPolygon(
          lat: element.latitude.toString(), lng: element.longitude.toString()));
    });

    LatLng position = computeCentroid(list);

    final place = await getPlaceByLatLng(
        latitude: position.latitude, longitude: position.longitude);

    emit(AddBoder(state.data
        .copyWith(list: list, myPlace: place, time: new DateTime.now())));
  }

  LatLng computeCentroid(List<LocationPolygon> points) {
    double latitude = 0;
    double longitude = 0;
    int n = points.length;

    points.forEach((point) {
      latitude += point.lat.parseDouble();
      longitude += point.lng.parseDouble();
    });
    return new LatLng(latitude / n, longitude / n);
  }

  Future<Place> getPlaceByLatLng({double latitude, double longitude}) async {
    try {
      String latLng = latitude.toString() + "," + longitude.toString();
      Place place = new Place();
      final searchPlaceRequest = new SearchPlaceRequest(
        key: apiKey,
        language: language,
        region: region,
        latLng: latLng,
      );
      final response =
          await dataRepository.searchPlaceByLatLng(searchPlaceRequest);

      final listResults = response.results ?? [];
      if (response.results.length > 0) {
        place.formattedAddress = listResults.first.formattedAddress ?? "";
        place.lat = latitude;
        place.lng = longitude;
        place.name = listResults.first.formattedAddress ?? "";
      } else {
        place.formattedAddress = "TP Hồ Chí Minh";
        place.lat = latitude;
        place.lng = longitude;
        place.name = "";
      }
      return place;
    } catch (e) {
      handleAppError(e);
      if (state.data.myPlace.lat != null) {
        final place = state.data.myPlace;
        return Place(
            name: place.name,
            formattedAddress: place.formattedAddress,
            lat: place.lat,
            lng: place.lng);
      }
      return Place();
    }
  }

  deleteImage(ImageSelect imageSelect) {
    List<ImageSelect> changeImageSelects = [...state.data.imageSelects];
    changeImageSelects.remove(imageSelect);
    emit(ImageChange(state.data.copyWith(imageSelects: changeImageSelects)));
  }

  addMultiImage(List<Asset> images) async {
    try {
      List<ImageSelect> changeImageSelects = [...state.data.imageSelects];
      await Future.forEach(images, (asset) async {
        final byteData = await asset.getThumbByteData(700, 700);
        final tempFile =
            File('${(await getTemporaryDirectory()).path}/${asset.name}');
        final file = await tempFile.writeAsBytes(
          byteData.buffer
              .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
        );
        ImageSelect imageSelect = new ImageSelect();
        imageSelect.url = file;
        imageSelect.id = Uuid().v4();
        changeImageSelects.insert(0, imageSelect);
      });
      emit(ImageChange(state.data.copyWith(imageSelects: changeImageSelects)));
    } catch (e) {
      logger.e(e);
    }
  }
}
