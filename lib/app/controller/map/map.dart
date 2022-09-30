import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import '../../config/config.dart';
import '../../services/geo_hash_function.dart';
import '../../services/point_out_lat_lng.dart';
import 'package:http/http.dart' as http;


class MapController extends GetxController {
  static MapController get to => Get.put(MapController());

  GoogleMapController? mapController;
  Location location = Location();
  GeoHasher geo = GeoHasher();
  final GlobalKey iconKey = GlobalKey();
  final GlobalKey iconDropKey = GlobalKey();
  Map<String, dynamic> driverReq = {};
  Map<String, dynamic> userDetails = {};

  Set<Polyline> polyline = {};

  dynamic center;
  dynamic loc;
  dynamic pinLocationIcon;
  dynamic userLocationIcon;

  dynamic waitingTime;
  dynamic waitingBeforeTime;
  dynamic waitingAfterTime;
  dynamic arrivedTimer;
  dynamic rideTimer;
  late PermissionStatus permission;

  final _marker = <Marker>[].obs;

  get marker => _marker.value;

  set marker(value) {
    _marker.value = value;
  }

  final _polyList = <LatLng>[].obs;

  get polyList => _polyList.value;

  set polyList(value) {
    _polyList.value = value;
  }

  final _chatList = [].obs;

  get chatList => _chatList.value;

  set chatList(value) {
    _chatList.value = value;
  }

  // final _cancelReasonsList = [].obs;
  //
  // get cancelReasonsList => _cancelReasonsList.value;
  //
  // set cancelReasonsList(value) {
  //   _cancelReasonsList.value = value;
  // }
  List cancelReasonsList = [];

  final _mapStyle = "".obs;

  get mapStyle => _mapStyle.value;

  set mapStyle(value) {
    _mapStyle.value = value;
  }

  final _logout = false.obs;

  get logout => _logout.value;

  set logout(value) {
    _logout.value = value;
  }

  final _cancelReasonText = "".obs;

  get cancelReasonText => _cancelReasonText.value;

  set cancelReasonText(value) {
    _cancelReasonText.value = value;
  }

  final _notifyCompleted = false.obs;

  get notifyCompleted => _notifyCompleted.value;

  set notifyCompleted(value) {
    _notifyCompleted.value = value;
  }

  final _getStartOtp = false.obs;

  get getStartOtp => _getStartOtp.value;

  set getStartOtp(value) {
    _getStartOtp.value = value;
  }

  final _driverOtp = "".obs;

  get driverOtp => _driverOtp.value;

  set driverOtp(value) {
    _driverOtp.value = value;
  }

  final _sosLoaded = false.obs;

  get sosLoaded => _sosLoaded.value;

  set sosLoaded(value) {
    _sosLoaded.value = value;
  }

  final _cancelRequest = false.obs;

  get cancelRequest => _cancelRequest.value;

  set cancelRequest(value) {
    _cancelRequest.value = value;
  }

  final _pickAnimateDone = false.obs;

  get pickAnimateDone => _pickAnimateDone.value;

  set pickAnimateDone(value) {
    _pickAnimateDone.value = value;
  }

  final _dropAnimateDone = false.obs;

  get dropAnimateDone => _dropAnimateDone.value;

  set dropAnimateDone(value) {
    _dropAnimateDone.value = value;
  }

  final _serviceEnabled = false.obs;

  get serviceEnabled => _serviceEnabled.value;

  set serviceEnabled(value) {
    _serviceEnabled.value = value;
  }

  final _state = "".obs;

  get state => _state.value;

  set state(value) {
    _state.value = value;
  }

  final _cancelReason = "".obs;

  get cancelReason => _cancelReason.value;

  set cancelReason(value) {
    _cancelReason.value = value;
  }

  final _locationDenied = false.obs;

  get locationDenied => _locationDenied.value;

  set locationDenied(value) {
    _locationDenied.value = value;
  }

  final _gettingPerm = 0.obs;

  get gettingPerm => _gettingPerm.value;

  set gettingPerm(value) {
    _gettingPerm.value = value;
  }

  final _errorOtp = false.obs;

  get errorOtp => _errorOtp.value;

  set errorOtp(value) {
    _errorOtp.value = value;
  }

  final _showSos = false.obs;

  get showSos => _showSos.value;

  set showSos(value) {
    _showSos.value = value;
  }

  final _showWaitingInfo = false.obs;

  get showWaitingInfo => _showWaitingInfo.value;

  set showWaitingInfo(value) {
    _showWaitingInfo.value = value;
  }

  final _isLoading = false.obs;

  get isLoading => _isLoading.value;

  set isLoading(value) {
    _isLoading.value = value;
  }

  final _reqCancelled = false.obs;

  get reqCancelled => _reqCancelled.value;

  set reqCancelled(value) {
    _reqCancelled.value = value;
  }

  final _heading = 0.0.obs;

  get heading => _heading.value;

  set heading(value) {
    _heading.value = value;
  }

  final _userReject = false.obs;

  get userReject => _userReject.value;

  set userReject(value) {
    _userReject.value = value;
  }

  final _bottom = 0.obs;

  get bottom => _bottom.value;

  set bottom(value) {
    _bottom.value = value;
  }

  final _duration = 0.0.obs;

  get duration => _duration.value;

  set duration(value) {
    _duration.value = value;
  }

  final _internet = false.obs;

  get internet => _internet.value;

  set internet(value) {
    _internet.value = value;
  }

  final _sosData = [].obs;

  get sosData => _sosData.value;

  set sosData(value) {
    _sosData.value = value;
  }

  var client =
  MqttServerClient.withPort(AppConfig.mqttUrl, '', AppConfig.mqttPort);

  mapCreation(GoogleMapController controller) {
    mapController = controller;
    mapController!.setMapStyle(mapStyle);
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

//getting permission and current location

  getPermissionAndCurrentLocation() async {
    permission = await location.hasPermission();
    serviceEnabled = await location.serviceEnabled();

    if (permission == PermissionStatus.denied ||
        permission == PermissionStatus.deniedForever ||
        serviceEnabled == false) {
      gettingPerm++;
      if (gettingPerm >= 2) {
        locationDenied = true;
      }
      state = '2';
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
              desiredAccuracy: geolocator.LocationAccuracy.low);
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

      state = '3';
      isLoading = false;
    }
  }

  cancelReq() {
    reqCancelled = true;
    Future.delayed(const Duration(seconds: 2), () {
      reqCancelled = false;
      userReject = false;
    });
  }

  getPolyLines() async {
    polyList.clear();
    String pickLat = driverReq['pick_lat'].toString();
    String pickLng = driverReq['pick_lng'].toString();
    String dropLat = driverReq['drop_lat'].toString();
    String dropLng = driverReq['drop_lng'].toString();
    try {
      var response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/directions/json?destination=$pickLat%2C$pickLng&origin=$dropLat%2C$dropLng&avoid=ferries|indoor&transit_mode=bus&mode=driving&key=${AppConfig.googleMapKey}'));
      if (response.statusCode == 200) {
        var steps = jsonDecode(response.body)['routes'][0]['overview_polyline']
        ['points'];

        decodeEncodedPolyline(steps);
      } else {
        debugPrint(response.body);
      }
    } catch (e) {
      if (e is SocketException) {
        // CommonController.to.internet = false;
      }
    }

    return polyList;
  }

  List<PointOutLatLng> decodeEncodedPolyline(String encoded) {
    polyline.clear();
    List<PointOutLatLng> poly = [];
    // int index = 0, len = encoded.length;
    // int lat = 0, lng = 0;
    //
    // while (index < len) {
    //   int b, shift = 0, result = 0;
    //   do {
    //     b = encoded.codeUnitAt(index++) - 63;
    //     result |= (b & 0x1f) << shift;
    //     shift += 5;
    //   } while (b >= 0x20);
    //   int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    //   lat += dlat;
    //
    //   shift = 0;
    //   result = 0;
    //   do {
    //     b = encoded.codeUnitAt(index++) - 63;
    //     result |= (b & 0x1f) << shift;
    //     shift += 5;
    //   } while (b >= 0x20);
    //   int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    //   lng += dlng;
    //   LatLng p = LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
    //   polyList.add(p);
    // }
    // polyline.add(Polyline(
    //   polylineId: const PolylineId('1'),
    //   visible: true,
    //   color: const Color(0xffFD9898),
    //   width: 4,
    //   points: polyList,
    // ));
    // valueNotifierHome.incrementNotifier();
    return poly;
  }

  Future<BitmapDescriptor> getCustomIcon(GlobalKey iconKeys) async {
    Future<Uint8List> _capturePng(GlobalKey iconKeys) async {
      dynamic pngBytes;

      try {
        RenderRepaintBoundary boundary = iconKeys.currentContext!
            .findRenderObject() as RenderRepaintBoundary;
        ui.Image image = await boundary.toImage(pixelRatio: 2.0);
        ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
        pngBytes = byteData!.buffer.asUint8List();
        return pngBytes;
      } catch (e) {
        debugPrint(e.toString());
      }
      return pngBytes;
    }

    Uint8List imageData = await _capturePng(iconKeys);

    return BitmapDescriptor.fromBytes(imageData);
  }

  addDropMarker() async {
    BitmapDescriptor testIcon =
    await getCustomIcon(MapController.to.iconDropKey);

    MapController.to.marker.add(Marker(
        markerId: const MarkerId('3'),
        icon: testIcon,
        position: LatLng(MapController.to.driverReq['drop_lat'],
            MapController.to.driverReq['drop_lng'])));

    if (MapController.to.polyline
        .where((element) => element.polylineId == const PolylineId('1'))
        .isEmpty) {
      MapController.to.getPolyLines();
    }
  }

  addMarker() async {
    if (MapController.to.driverReq.isNotEmpty) {
      BitmapDescriptor testIcon = await getCustomIcon(MapController.to.iconKey);
      MapController.to.marker.add(Marker(
          markerId: const MarkerId('2'),
          icon: testIcon,
          position: LatLng(MapController.to.driverReq['pick_lat'],
              MapController.to.driverReq['pick_lng'])));
    }
  }

  setPinLocationIcon() {
    if (marker
        .where((element) => element.markerId == const MarkerId('1'))
        .isNotEmpty &&
        pinLocationIcon != null) {
      var lst = marker
          .firstWhere((element) => element.markerId == const MarkerId('1'));
      var ind = marker.indexOf(lst);
      marker[ind] = Marker(
          markerId: const MarkerId('1'),
          position: center,
          rotation: heading,
          icon: pinLocationIcon,
          anchor: const Offset(0.5, 0.5));
      if (driverReq.isEmpty || driverReq['is_trip_start'] == 1) {
        mapController!.animateCamera(CameraUpdate.newLatLng(center));
      }
    } else if (marker
        .where((element) => element.markerId == const MarkerId('1'))
        .isEmpty &&
        pinLocationIcon != null) {
      marker.add(Marker(
          markerId: const MarkerId('1'),
          rotation: heading,
          position: center,
          icon: pinLocationIcon,
          anchor: const Offset(0.5, 0.5)));
    }
  }

  checkDriverRequestStatus() {
    addDropMarker();

    if (driverReq.isNotEmpty) {
      if (driverReq['is_trip_start'] != 1) {
        if (marker
            .where((element) => element.markerId == const MarkerId('2'))
            .isEmpty) {
          Future.delayed(const Duration(seconds: 2), () {
            addMarker();
          });
        }

        if (pickAnimateDone != true) {
          mapController!.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(driverReq['pick_lat'], driverReq['pick_lng']), 11.0));
          pickAnimateDone = true;
        }
        update();
      } else if (driverReq['is_trip_start'] == 1 &&
          driverReq['is_completed'] == 0) {
        if (marker
            .where((element) => element.markerId == const MarkerId('3'))
            .isEmpty &&
            driverReq['is_rental'] != true) {
          // addDropMarker();
        }
        if (marker
            .where((element) => element.markerId == const MarkerId('2'))
            .isEmpty) {
          addMarker();
        }

        if (dropAnimateDone == false && driverReq['is_rental'] != true) {
          mapController!.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(driverReq['drop_lat'], driverReq['drop_lng']), 11.0));
          dropAnimateDone = true;
        }
        update();
      } else if (driverReq['is_completed'] == 1 &&
          driverReq['requestBill'] != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (context) => const Invoice()),
          //         (route) => false);
        });
        update();
        pickAnimateDone = false;
        dropAnimateDone = false;
        marker
            .removeWhere((element) => element.markerId == const MarkerId('2'));
        marker
            .removeWhere((element) => element.markerId == const MarkerId('3'));
        polyline.removeWhere(
                (element) => element.polylineId == const PolylineId('1'));
      }
      update();
    } else {
      if (marker
          .where((element) => element.markerId == const MarkerId('2'))
          .isNotEmpty) {
        marker
            .removeWhere((element) => element.markerId == const MarkerId('2'));
        if (userReject == true) {
          cancelReq();
        }

        pickAnimateDone = false;
      }
    }
    update();
  }

  checkUserApproveStatus() {
    if (userDetails['approve'] == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const DocsProcess()),
        //         (route) => false);
      });
    }
  }

  driverStatus() async {
    isLoading = true;
    dynamic result;
    // try {
    //   var response = await http.post(
    //       Uri.parse(url + 'api/v1/driver/online-offline'),
    //       headers: {'Authorization': 'Bearer ' + bearerToken[0].token});
    //   if (response.statusCode == 200) {
    //     userDetails = jsonDecode(response.body)['data'];
    //     result = true;
    //     if (userDetails['active'] == false) {
    //       userInactive();
    //     } else {
    //       userActive();
    //     }
    //   } else {
    //     debugPrint(response.body);
    //     result = false;
    //   }
    // } catch (e) {
    //   if (e is SocketException) {
    //     internet = false;
    //     result = 'no internet';
    //   }
    // }
    return result;
  }

  openMap(lat, lng) async {
    // try {
    //   String googleUrl =
    //       'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    //
    //   if (await canLaunch(googleUrl)) {
    //     await launch(googleUrl);
    //   }
    // } catch (e) {
    //   if (e is SocketException) {
    //     internet = false;
    //   }
    // }
  }

  currentPositionUpdate() async {
    bool serviceEnabled;
    PermissionStatus permission;
    Location locs = Location();
    GeoHasher geo = GeoHasher();

    Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (userDetails.isNotEmpty) {
        serviceEnabled = await locs.serviceEnabled();
        permission = await locs.hasPermission();
        if (userDetails['active'] == true &&
            serviceEnabled == true &&
            permission == PermissionStatus.granted) {
          if (await locs.isBackgroundModeEnabled() == false) {
            await locs.enableBackgroundMode(enable: true);
            locs.changeNotificationOptions(iconName: '@mipmap/ic_launcher');
          }
          if (client.connectionStatus!.state !=
              MqttConnectionState.connected ||
             client.connectionStatus == null) {
            mqttForDocuments();
          }
          var pos = await Location.instance.getLocation();

          // Test if location services are enabled.

          center = LatLng(double.parse(pos.latitude.toString()),
              double.parse(pos.longitude.toString()));
          heading = pos.heading;
          // valueNotifierHome.incrementNotifier();
          final _position = FirebaseDatabase.instance.ref();

          try {
            _position.child('drivers/' + userDetails['id'].toString()).update({
              'bearing': pos.heading,
              'id': userDetails['id'],
              'g': geo.encode(double.parse(pos.longitude.toString()),
                  double.parse(pos.latitude.toString())),
              'is_active': userDetails['active'] == true ? 1 : 0,
              'is_available': userDetails['available'],
              'l': {'0': pos.latitude, '1': pos.longitude},
              'mobile': userDetails['mobile'],
              'name': userDetails['name'],
              'updated_at': ServerValue.timestamp,
              'vehicle_number': userDetails['car_number'],
              'vehicle_type_name': userDetails['car_make_name'],
              'vehicle_type': userDetails['vehicle_type_id']
            });
            if (driverReq.isNotEmpty) {
              if (driverReq['accepted_at'] != null &&
                  driverReq['is_completed'] == 0) {
                requestDetailsUpdate(
                    double.parse(pos.heading.toString()),
                    double.parse(pos.latitude.toString()),
                    double.parse(pos.longitude.toString()));
              }
            }
            // valueNotifierHome.incrementNotifier();
          } catch (e) {
            if (e is SocketException) {
              internet = false;
              // valueNotifierHome.incrementNotifier();
            }
          }
        } else if (userDetails['active'] == false &&
            serviceEnabled == true &&
            permission != PermissionStatus.denied) {
          var pos = await geolocator.Geolocator.getCurrentPosition();
          // valueNotifierHome.incrementNotifier();
          center = LatLng(double.parse(pos.latitude.toString()),
              double.parse(pos.longitude.toString()));
        }
      }
    });
  }

  requestDetailsUpdate(
      double bearing,
      double lat,
      double lng,
      ) async {
    // final _data = FirebaseDatabase.instance.ref();
    // if (driverReq['is_trip_start'] == 1 && driverReq['is_completed'] == 0) {
    //   if (totalDistance == null) {
    //     var _dist = await FirebaseDatabase.instance
    //         .ref()
    //         .child('requests/' + driverReq['id'])
    //         .child('distance')
    //         .get();
    //     var _array = await FirebaseDatabase.instance
    //         .ref()
    //         .child('requests/' + driverReq['id'])
    //         .child('lat_lng_array')
    //         .get();
    //
    //     if (_dist.value != null) {
    //       totalDistance = _dist.value;
    //     }
    //     if (_array.value != null) {
    //       latlngArray = jsonDecode(jsonEncode(_array.value));
    //       lastLat = latlngArray[latlngArray.length - 1]['lat'];
    //       lastLong = latlngArray[latlngArray.length - 1]['lng'];
    //     }
    //   }
    //   if (latlngArray.isEmpty) {
    //     latlngArray.add({'lat': lat, 'lng': lng});
    //     lastLat = lat;
    //     lastLong = lng;
    //   } else {
    //     var distance = await calculateDistance(lastLat, lastLong, lat, lng);
    //     if (distance >= 110.0) {
    //       latlngArray.add({'lat': lat, 'lng': lng});
    //       lastLat = lat;
    //       lastLong = lng;
    //
    //       if (totalDistance == null) {
    //         totalDistance = distance / 1000;
    //       } else {
    //         totalDistance = ((totalDistance * 1000) + distance) / 1000;
    //       }
    //     }
    //   }
    // }
    //
    // try {
    //   _data.child('requests/' + driverReq['id']).update({
    //     'bearing': bearing,
    //     'distance': (totalDistance == null) ? 0.0 : totalDistance,
    //     'id': userDetails['id'],
    //     'is_cancelled': (driverReq['is_cancelled'] == 0) ? false : true,
    //     'is_completed': (driverReq['is_completed'] == 0) ? false : true,
    //     'lat': lat,
    //     'lng': lng,
    //     'lat_lng_array': latlngArray,
    //     'request_id': driverReq['id'],
    //     'trip_arrived': (driverReq['is_driver_arrived'] == 0) ? "0" : "1",
    //     'trip_start': (driverReq['is_trip_start'] == 0) ? "0" : "1",
    //   });
    // } catch (e) {
    //   if (e is SocketException) {
    //     internet = false;
    //     valueNotifierHome.incrementNotifier();
    //   }
    // }
  }
// PolylinePoints polylinePoints = PolylinePoints();
// // ignore: prefer_collection_literals
// Set<Marker> markers = Set();
// Map<PolylineId, Polyline> polyLines = {};
// LatLng startLocation = LatLng(27.6683619, 85.3101895);
// LatLng endLocation = LatLng(27.6688312, 85.3077329);
//
// startMarker(){
//   markers.add(Marker( //add start location marker
//     markerId: MarkerId(startLocation.toString()),
//     position: startLocation, //position of marker
//     infoWindow: InfoWindow( //popup info
//       title: 'Starting Point ',
//       snippet: 'Start Marker',
//     ),
//     icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//   ));
// }
//
// destinationMarker(){
//   markers.add(Marker( //add distination location marker
//     markerId: MarkerId(endLocation.toString()),
//     position: endLocation, //position of marker
//     infoWindow: InfoWindow( //popup info
//       title: 'Destination Point ',
//       snippet: 'Destination Marker',
//     ),
//     icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//   ));
// }
//
// getDirections() async {
//   List<LatLng> polylineCoordinates = [];
//
//   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//     AppConfig.googleMapKey,
//     PointLatLng(startLocation.latitude, startLocation.longitude),
//     PointLatLng(endLocation.latitude, endLocation.longitude),
//     travelMode: TravelMode.driving,
//   );
//
//   if (result.points.isNotEmpty) {
//     result.points.forEach((PointLatLng point) {
//       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//     });
//   } else {
//     print(result.errorMessage);
//   }
//   addPolyLine(polylineCoordinates);
// }
//
// addPolyLine(List<LatLng> polylineCoordinates) {
//   PolylineId id = PolylineId("poly");
//   Polyline polyline = Polyline(
//     polylineId: id,
//     color: Colors.deepPurpleAccent,
//     points: polylineCoordinates,
//     width: 8,
//   );
//   polyLines[id] = polyline;
// }



  mqttForDocuments() async {
    client.setProtocolV311();
    client.logging(on: true);
    client.keepAlivePeriod = 120;
    client.autoReconnect = true;
    //
    // try {
    //   await client.connect();
    // } on NoConnectionException catch (e) {
    //   debugPrint(e.toString());
    //   // Raised by the client when connection fails.
    //   client.disconnect();
    // }
    //
    // if (client.connectionStatus!.state == MqttConnectionState.connected) {
    //   debugPrint('connected');
    // } else {
    //   /// Use status here rather than state if you also want the broker return code.
    //
    //   client.disconnect();
    // }
    //
    // void onconnected() {
    //   debugPrint('connected');
    // }
    //
    // client.subscribe(
    //     'approval_status_' + userDetails['id'].toString(), MqttQos.atLeastOnce);
    // client.subscribe(
    //     'create_request_' + userDetails['id'].toString(), MqttQos.atLeastOnce);
    // client.subscribe(
    //     'request_handler_' + userDetails['id'].toString(), MqttQos.atLeastOnce);
    // client.subscribe(
    //     'new_message_' + userDetails['id'].toString(), MqttQos.atLeastOnce);
    //
    // client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) async {
    //   final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;
    //
    //   final pt =
    //   MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    //   if (c[0].topic == 'approval_status_' + userDetails['id'].toString()) {
    //     Map<String, dynamic> val =
    //     Map<String, dynamic>.from(jsonDecode(pt)['data']);
    //     if (userDetails['approve'] == val['approve']) {
    //       userDetails['declined_reason'] = val['declined_reason'];
    //
    //       valueNotifierHome.incrementNotifier();
    //     } else if (userDetails['approve'] != val['approve'] &&
    //         val['approve'] == true) {
    //       userDetails['approve'] = val['approve'];
    //       userDetails['declined_reason'] = val['declined_reason'];
    //       audioPlayer.play(audio);
    //       valueNotifierHome.incrementNotifier();
    //     } else if (userDetails['approve'] != val['approve'] &&
    //         val['approve'] == false) {
    //       userDetails['declined_reason'] = val['declined_reason'];
    //       userDetails['approve'] = val['approve'];
    //       audioPlayer.play(audio);
    //       valueNotifierHome.incrementNotifier();
    //     } else {}
    //   } else if (c[0].topic ==
    //       'request_handler_' + userDetails['id'].toString()) {
    //     await FirebaseDatabase.instance
    //         .ref()
    //         .child('requests/' + driverReq['id'])
    //         .update({'is_cancelled': true});
    //     driverReq = {};
    //     getUserDetails();
    //     if (jsonDecode(pt)['message'] != 'driver_cancelled_trip') {
    //       userReject = true;
    //       duration = 0;
    //       audioPlayer.play(audio);
    //     }
    //     getStartOtp = false;
    //
    //     audioPlayers.stop();
    //     audioPlayers.dispose();
    //     valueNotifierHome.incrementNotifier();
    //   } else if (c[0].topic == 'create_request_' + userDetails['id'].toString()) {
    //     Map<String, dynamic> val =
    //     Map<String, dynamic>.from(jsonDecode(pt)['result']['data']);
    //
    //     driverReq = val;
    //     valueNotifierHome.incrementNotifier();
    //     if (duration == 0 || duration == 0.0) {
    //       duration = 30;
    //       sound();
    //     }
    //   } else if (c[0].topic == 'new_message_' + userDetails['id'].toString()) {
    //     if (jsonDecode(pt)["success_message"] == "new_message") {
    //       chatList = jsonDecode(pt)['data'];
    //       audioPlayer.play(audio);
    //       valueNotifierHome.incrementNotifier();
    //     } else {
    //       audioPlayer.play(audio);
    //     }
    //   }
    // });

    // client.onConnected = onconnected;
  }

}
