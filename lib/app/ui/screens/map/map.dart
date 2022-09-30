import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:patient_app/app/ui/widgets/common_text.dart';
import '../../../controller/map/map.dart';
import '../../themes/colors.dart';
import '../../widgets/drawer/drawer.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GetBuilder(
        init: MapController(),
        initState: (_) {
          MapController.to.checkDriverRequestStatus();
          MapController.to.getPermissionAndCurrentLocation();
        },
        builder: (data) {
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
                              child: Obx(
                                () => GoogleMap(
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    MapController.to.mapController = controller;
                                    MapController.to.mapController!
                                        .setMapStyle(MapController.to.mapStyle);
                                  },
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(51.516667, 12.388889),
                                    zoom: 11.0,
                                  ),
                                  markers:
                                      Set<Marker>.from(MapController.to.marker),
                                  polylines: MapController.to.polyline,
                                  minMaxZoomPreference:
                                      const MinMaxZoomPreference(0.0, 20.0),
                                  myLocationButtonEnabled: true,
                                  compassEnabled: false,
                                  buildingsEnabled: false,
                                  zoomControlsEnabled: false,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),


                  (MapController.to.locationDenied == true)
                      ? Positioned(
                      child: Container(
                        height: media.height * 1,
                        width: media.width * 1,
                        color: Colors.transparent.withOpacity(0.6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(media.width * 0.05),
                              width: media.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2.0,
                                        spreadRadius: 2.0,
                                        color:
                                        Colors.black.withOpacity(0.2))
                                  ]),
                              child: Column(
                                children: [
                                  SizedBox(
                                      width: media.width * 0.8,
                                      child: CommonText(text: "Location",)),
                                  SizedBox(height: media.width * 0.05),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                          onTap: () async {
                                            // await perm.openAppSettings();
                                          },
                                          child: CommonText(text: "Settings",)),
                                      InkWell(
                                          onTap: () async {
                                            // setState(() {
                                            //   _locationDenied = false;
                                            //   _isLoading = true;
                                            // });
                                            //
                                            // getLocs();
                                          },
                                          child: CommonText(text: "Done",))
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ))
                      : Container(),


                  (MapController.to.getStartOtp == true &&
                      MapController.to.driverReq.isNotEmpty)
                      ? Positioned(
                    top: 0,
                    child: Container(
                      height: media.height * 1,
                      width: media.width * 1,
                      color: Colors.transparent.withOpacity(0.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: media.width * 0.8,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // setState(() {
                                    //   getStartOtp = false;
                                    // });
                                  },
                                  child: Container(
                                    height: media.height * 0.05,
                                    width: media.height * 0.05,
                                    decoration: const BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.cancel,
                                        color: AppColors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: media.width * 0.025),
                          Container(
                            padding:
                            EdgeInsets.all(media.width * 0.05),
                            width: media.width * 0.8,
                            height: media.width * 0.7,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10),
                                color: AppColors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 2)
                                ]),
                            child: Column(
                              children: [
                                CommonText(text: "DrriverOtp",),
                                SizedBox(height: media.width * 0.05),
                                CommonText(text: "Enter Otp",),

                                SizedBox(
                                  height: media.width * 0.05,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: media.width * 0.12,
                                      color: AppColors.white,
                                      child: TextFormField(
                                        onChanged: (val) {
                                          // if (val.length == 1) {
                                          //   setState(() {
                                          //     _otp1 = val;
                                          //     driverOtp = _otp1 +
                                          //         _otp2 +
                                          //         _otp3 +
                                          //         _otp4;
                                          //     FocusScope.of(context)
                                          //         .nextFocus();
                                          //   });
                                          // }
                                        },
                                        keyboardType:
                                        TextInputType.number,
                                        maxLength: 1,
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            counterText: '',
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                    Colors.black,
                                                    width: 1.5,
                                                    style: BorderStyle
                                                        .solid))),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: media.width * 0.12,
                                      color: AppColors.white,
                                      child: TextFormField(
                                        onChanged: (val) {
                                          // if (val.length == 1) {
                                          //   setState(() {
                                          //     _otp2 = val;
                                          //     driverOtp = _otp1 +
                                          //         _otp2 +
                                          //         _otp3 +
                                          //         _otp4;
                                          //     FocusScope.of(context)
                                          //         .nextFocus();
                                          //   });
                                          // } else {
                                          //   setState(() {
                                          //     FocusScope.of(context)
                                          //         .previousFocus();
                                          //   });
                                          // }
                                        },
                                        keyboardType:
                                        TextInputType.number,
                                        maxLength: 1,
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            counterText: '',
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                    Colors.black,
                                                    width: 1.5,
                                                    style: BorderStyle
                                                        .solid))),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: media.width * 0.12,
                                      color: AppColors.white,
                                      child: TextFormField(
                                        onChanged: (val) {
                                          // if (val.length == 1) {
                                          //   setState(() {
                                          //     _otp3 = val;
                                          //     driverOtp = _otp1 +
                                          //         _otp2 +
                                          //         _otp3 +
                                          //         _otp4;
                                          //     FocusScope.of(context)
                                          //         .nextFocus();
                                          //   });
                                          // } else {
                                          //   setState(() {
                                          //     FocusScope.of(context)
                                          //         .previousFocus();
                                          //   });
                                          // }
                                        },
                                        keyboardType:
                                        TextInputType.number,
                                        maxLength: 1,
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            counterText: '',
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                    Colors.black,
                                                    width: 1.5,
                                                    style: BorderStyle
                                                        .solid))),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: media.width * 0.12,
                                      color: AppColors.white,
                                      child: TextFormField(
                                        onChanged: (val) {
                                          // if (val.length == 1) {
                                          //   setState(() {
                                          //     _otp4 = val;
                                          //     driverOtp = _otp1 +
                                          //         _otp2 +
                                          //         _otp3 +
                                          //         _otp4;
                                          //     FocusScope.of(context)
                                          //         .nextFocus();
                                          //   });
                                          // } else {
                                          //   setState(() {
                                          //     FocusScope.of(context)
                                          //         .previousFocus();
                                          //   });
                                          // }
                                        },
                                        keyboardType:
                                        TextInputType.number,
                                        maxLength: 1,
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            counterText: '',
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                    Colors.black,
                                                    width: 1.5,
                                                    style: BorderStyle
                                                        .solid))),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: media.width * 0.04,
                                ),
                                (MapController.to.errorOtp == true)
                                    ? CommonText(
                                  text: 'Please Enter Valid Otp',

                                )
                                    : Container(),
                                SizedBox(height: media.width * 0.02),
                                // Button(
                                //   onTap: () async {
                                //     if (driverOtp.length != 4) {
                                //       setState(() {});
                                //     } else {
                                //       setState(() {
                                //         _errorOtp = false;
                                //         _isLoading = true;
                                //       });
                                //       var val = await tripStart();
                                //       if (val != 'success') {
                                //         setState(() {
                                //           _errorOtp = true;
                                //           _isLoading = false;
                                //         });
                                //       } else {
                                //         setState(() {
                                //           _isLoading = false;
                                //           getStartOtp = false;
                                //         });
                                //       }
                                //     }
                                //   },
                                //   text: AppTranslations()
                                //       .languages[CommonController.to
                                //       .chooseLanguage]
                                //   ['text_confirm'],
                                //   color: (driverOtp.length != 4)
                                //       ? Colors.grey
                                //       : AppColors.buttonColor,
                                //   borcolor: (driverOtp.length != 4)
                                //       ? Colors.grey
                                //       : AppColors.buttonColor,
                                // )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                      : Container(),


                  (MapController.to.cancelRequest == true &&
                      MapController.to.driverReq.isNotEmpty)
                      ? Positioned(
                      child: Container(
                        height: media.height * 1,
                        width: media.width * 1,
                        color: Colors.transparent.withOpacity(0.6),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(media.width * 0.05),
                              width: media.width * 0.9,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius:
                                  BorderRadius.circular(12)),
                              child: Column(children: [
                                Container(
                                  height: media.width * 0.18,
                                  width: media.width * 0.18,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffFEF2F2)),
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: media.width * 0.14,
                                    width: media.width * 0.14,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffFF0000)),
                                    child: const Center(
                                      child: Icon(
                                        Icons.cancel_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: MapController.to
                                      .cancelReasonsList
                                      .asMap()
                                      .map((i, value) {
                                    return MapEntry(
                                        i,
                                        InkWell(
                                          onTap: () {
                                            // setState(() {
                                            //   _cancelReason =
                                            //   cancelReasonsList[i]
                                            //   ['reason'];
                                            // });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(
                                                media.width * 0.01),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height:
                                                  media.height *
                                                      0.05,
                                                  width: media.width *
                                                      0.05,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape
                                                          .circle,
                                                      border: Border.all(
                                                          color: Colors
                                                              .black,
                                                          width:
                                                          1.2)),
                                                  alignment: Alignment
                                                      .center,
                                                  child: (MapController.to
                                                      .cancelReason ==
                                                      MapController.to
                                                          .cancelReasonsList[
                                                      i][
                                                      'reason'])
                                                      ? Container(
                                                    height: media
                                                        .width *
                                                        0.03,
                                                    width: media
                                                        .width *
                                                        0.03,
                                                    decoration:
                                                    const BoxDecoration(
                                                      shape: BoxShape
                                                          .circle,
                                                      color: Colors
                                                          .black,
                                                    ),
                                                  )
                                                      : Container(),
                                                ),
                                                SizedBox(
                                                  width: media.width *
                                                      0.05,
                                                ),
                                                SizedBox(
                                                  width: media.width *
                                                      0.65,
                                                  child: Text(
                                                    MapController.to
                                                        .cancelReasonsList[
                                                    i]['reason'],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ));
                                  })
                                      .values
                                      .toList(),
                                ),
                                InkWell(
                                  onTap: () {
                                    // setState(() {
                                    //   _cancelReason = 'others';
                                    // });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(
                                        media.width * 0.01),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: media.height * 0.05,
                                          width: media.width * 0.05,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.2)),
                                          alignment: Alignment.center,
                                          child: (MapController.to
                                              .cancelReason ==
                                              'others')
                                              ? Container(
                                            height:
                                            media.width * 0.03,
                                            width:
                                            media.width * 0.03,
                                            decoration:
                                            const BoxDecoration(
                                              shape:
                                              BoxShape.circle,
                                              color: Colors.black,
                                            ),
                                          )
                                              : Container(),
                                        ),
                                        SizedBox(
                                          width: media.width * 0.05,
                                        ),
                                       CommonText(text: "others",)
                                      ],
                                    ),
                                  ),
                                ),
                                (MapController.to.cancelReason ==
                                    'others')
                                    ? Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0,
                                      media.width * 0.025,
                                      0,
                                      media.width * 0.025),
                                  padding: EdgeInsets.all(
                                      media.width * 0.05),
                                  width: media.width * 0.9,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.primaryColor,
                                          width: 1.2),
                                      borderRadius:
                                      BorderRadius.circular(
                                          12)),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "cacel reason",),
                                    maxLines: 4,
                                    minLines: 2,
                                    onChanged: (val) {
                                      // setState(() {
                                      //   cancelReasonText = val;
                                      // });
                                    },
                                  ),
                                )
                                    : Container(),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: const [
                                    // Button(
                                    //     color: AppColors.white,
                                    //     textcolor: AppColors.buttonColor,
                                    //     width: media.width * 0.39,
                                    //     onTap: () async {
                                    //       client.disconnect();
                                    //       setState(() {
                                    //         _isLoading = true;
                                    //       });
                                    //       if (_cancelReason != '') {
                                    //         if (_cancelReason ==
                                    //             'others') {
                                    //           await cancelRequestDriver(
                                    //               cancelReasonText);
                                    //           setState(() {
                                    //             cancelRequest = false;
                                    //           });
                                    //         } else {
                                    //           await cancelRequestDriver(
                                    //               _cancelReason);
                                    //           setState(() {
                                    //             cancelRequest = false;
                                    //           });
                                    //         }
                                    //       }
                                    //       setState(() {
                                    //         _isLoading = false;
                                    //       });
                                    //     },
                                    //     text: AppTranslations()
                                    //         .languages[CommonController.to
                                    //         .chooseLanguage]
                                    //     ['text_cancel']),
                                    // Button(
                                    //     width: media.width * 0.39,
                                    //     onTap: () {
                                    //       setState(() {
                                    //         cancelRequest = false;
                                    //       });
                                    //     },
                                    //     text: AppTranslations()
                                    //         .languages[CommonController.to
                                    //         .chooseLanguage]
                                    //     ['tex_dontcancel'])
                                  ],
                                )
                              ]),
                            ),
                          ],
                        ),
                      ))
                      : Container(),

                  (MapController.to.state == "")
                      ? const Positioned(top: 0, child: Text("Loading"))
                      : Container(),
                ],
              ),
            ),
          );
        });
  }
}
