import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../controller/map/map.dart';
import '../../themes/colors.dart';
import '../../widgets/drawer/drawer.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: AppColors.white,
              height: media.height * 1,
              width: media.width * 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   padding: EdgeInsets.all(media.width * 0.05),
                  //   width: media.width * 0.6,
                  //   height: media.width * 0.3,
                  //   decoration: BoxDecoration(
                  //       color: AppColors.white,
                  //       boxShadow: [
                  //         BoxShadow(
                  //             blurRadius: 5,
                  //             color: Colors.black.withOpacity(0.2),
                  //             spreadRadius: 2)
                  //       ],
                  //       borderRadius: BorderRadius.circular(10)),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       const CommonText(
                  //         text: "Enable Location",
                  //       ),
                  //       Container(
                  //         alignment: Alignment.centerRight,
                  //         child: InkWell(
                  //           onTap: () {
                  //             // MapController.to.state = '';
                  //             // MapController.to
                  //             //     .getPermissionAndCurrentLocation();
                  //           },
                  //           child: const CommonText(
                  //             text: "Ok",
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   height: media.height * 1,
                  //   width: media.width * 1,
                  //   alignment: Alignment.center,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       SizedBox(
                  //         height: media.height * 0.31,
                  //         child: Image.asset(
                  //           'assets/images/allow_location_permission.png',
                  //           fit: BoxFit.contain,
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: media.width * 0.05,
                  //       ),
                  //       CommonText(
                  //         text: "Most Trusted Taxi Booking App",
                  //       ),
                  //       SizedBox(
                  //         height: media.width * 0.025,
                  //       ),
                  //       CommonText(
                  //         text: "To enjoy your ride experience",
                  //       ),
                  //       CommonText(
                  //         text: "Please allow us the following permissions",
                  //       ),
                  //       SizedBox(
                  //         height: media.width * 0.05,
                  //       ),
                  //       Container(
                  //         padding: EdgeInsets.fromLTRB(
                  //             media.width * 0.05, 0, media.width * 0.05, 0),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: [
                  //             SizedBox(
                  //                 width: media.width * 0.075,
                  //                 child:
                  //                     const Icon(Icons.location_on_outlined)),
                  //             SizedBox(
                  //               width: media.width * 0.025,
                  //             ),
                  //             SizedBox(
                  //                 width: media.width * 0.8,
                  //                 child: CommonText(
                  //                   text: "Allow Location - To book a taxi",
                  //                 )),
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: media.width * 0.02,
                  //       ),
                  //       Container(
                  //         padding: EdgeInsets.fromLTRB(
                  //             media.width * 0.05, 0, media.width * 0.05, 0),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: [
                  //             SizedBox(
                  //                 width: media.width * 0.075,
                  //                 child:
                  //                     const Icon(Icons.location_on_outlined)),
                  //             SizedBox(
                  //               width: media.width * 0.025,
                  //             ),
                  //             SizedBox(
                  //                 width: media.width * 0.8,
                  //                 child: CommonText(
                  //                   text:
                  //                       "Enable Background Location - to give you ride request even if your app is in background",
                  //                 )),
                  //           ],
                  //         ),
                  //       ),
                  //       Container(
                  //           padding: EdgeInsets.all(media.width * 0.05),
                  //           child: CommonButton(
                  //               text: "Allow",
                  //               onPressed: () async {
                  //                 // if (MapController.to
                  //                 //     .serviceEnabled ==
                  //                 //     false) {
                  //                 //   await MapController.to
                  //                 //       .location
                  //                 //       .requestService();
                  //                 // }
                  //                 // if (MapController.to
                  //                 //     .permission ==
                  //                 //     PermissionStatus
                  //                 //         .denied ||
                  //                 //     MapController.to
                  //                 //         .permission ==
                  //                 //         PermissionStatus
                  //                 //             .deniedForever) {
                  //                 //   await [
                  //                 //     perm.Permission
                  //                 //         .location,
                  //                 //     perm.Permission
                  //                 //         .locationAlways
                  //                 //   ].request();
                  //                 // }
                  //                 // MapController.to.isLoading =
                  //                 // true;
                  //                 // MapController.to
                  //                 //     .getPermissionAndCurrentLocation();
                  //               }))
                  //     ],
                  //   ),
                  // )
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: media.height * 1,
                        width: media.width * 1,
                          child: Obx(() =>
                              GoogleMap(
                                onMapCreated: (
                                    GoogleMapController controller) {
                                  MapController.to
                                      .mapController =
                                      controller;
                                  MapController.to
                                      .mapController!
                                      .setMapStyle(
                                      MapController.to
                                          .mapStyle);
                                },
                                initialCameraPosition:
                                CameraPosition(
                                  target: MapController.to
                                      .center,
                                  zoom: 11.0,
                                ),
                                markers: Set<Marker>.from(
                                    MapController.to.marker),
                                polylines: MapController.to
                                    .polyline,
                                minMaxZoomPreference:
                                const MinMaxZoomPreference(
                                    0.0, 20.0),
                                myLocationButtonEnabled:
                                true,
                                compassEnabled: false,
                                buildingsEnabled: false,
                                zoomControlsEnabled:
                                false,
                              ),),

                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
