import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:shared_preferences/shared_preferences.dart';

class MapController extends GetxController {
  static MapController get to => Get.put(MapController());

  GoogleMapController? mapController;
  Location location = Location();
  late PermissionStatus permission;

  dynamic center;
  dynamic loc;
  dynamic pinLocationIcon;
  dynamic fcm;
  dynamic pref;

  Set<Polyline> polyline = {};




  final _serviceEnabled = false.obs;

  get serviceEnabled => _serviceEnabled.value;

  set serviceEnabled(value) {
    _serviceEnabled.value = value;
  }

  final _gettingPerm = 0.obs;

  get gettingPerm => _gettingPerm.value;

  set gettingPerm(value) {
    _gettingPerm.value = value;
  }

  final _locationDenied = false.obs;

  get locationDenied => _locationDenied.value;

  set locationDenied(value) {
    _locationDenied.value = value;
  }

  final _isLoading = false.obs;

  get isLoading => _isLoading.value;

  set isLoading(value) {
    _isLoading.value = value;
  }

  final _state = "".obs;

  get state => _state.value;

  set state(value) {
    _state.value = value;
  }

  final _heading = 0.0.obs;

  get heading => _heading.value;

  set heading(value) {
    _heading.value = value;
  }

  final _marker = <Marker>[].obs;

  get marker => _marker.value;

  set marker(value) {
    _marker.value = value;
  }

  final _mapStyle = "".obs;

  get mapStyle => _mapStyle.value;

  set mapStyle(value) {
    _mapStyle.value = value;
  }

  final _internet = false.obs;

  get internet => _internet.value;

  get http => null;

  set internet(value) {
    _internet.value = value;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
  mapCreation(GoogleMapController controller) {
    mapController = controller;
    mapController!.setMapStyle(mapStyle);
  }
  getDetailsOfDevice() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      internet = false;
    } else {
      internet = true;
    }
    try {
      rootBundle.loadString('assets/map_style.json').then((value) {
        MapController.to.mapStyle = value;
      });
      // var token = await FirebaseMessaging.instance.getToken();
      // fcm = token;
      fcm = "";
      pref = await SharedPreferences.getInstance();
    } catch (e) {
      if (e is SocketException) {
        internet = false;
      }
    }
  }

  getPermissionAndCurrentLocation() async {
    permission = await location.hasPermission();
    serviceEnabled = await location.serviceEnabled();
    if (permission == PermissionStatus.denied ||
        permission == PermissionStatus.deniedForever ||
        serviceEnabled == false) {
      if (gettingPerm >= 2) {
        locationDenied = true;
      }
      state = "2";
      isLoading = false;
    } else if (permission == PermissionStatus.granted ||
        permission == PermissionStatus.grantedLimited) {
      final Uint8List markerIcon =
          await getBytesFromAsset('assets/images/top-taxi.png', 40);
      if (center == null) {
        var locs = await geolocator.Geolocator.getLastKnownPosition();
        if (locs != null) {
          center = LatLng(locs.latitude, locs.longitude);
          heading = locs.heading;
        } else {
          loc = await geolocator.Geolocator.getCurrentPosition(
              desiredAccuracy: geolocator.LocationAccuracy.high);
          center = LatLng(double.parse(loc.latitude.toString()),
              double.parse(loc.longitude.toString()));
          heading = loc.heading;
        }
      }
      pinLocationIcon = BitmapDescriptor.fromBytes(markerIcon);
      if (marker.isEmpty) {
        marker = [
          Marker(
              markerId: const MarkerId('1'),
              rotation: heading,
              position: center,
              icon: pinLocationIcon,
              anchor: const Offset(0.5, 0.5))
        ];
      }
    }
    state = "3";
    isLoading = false;
  }
}
