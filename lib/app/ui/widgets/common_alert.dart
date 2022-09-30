import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/colors.dart';
import '../themes/constants.dart';
import 'common_text.dart';
commonAlertDialog(BuildContext context,
    {required String content, required Function() confirmButtonPressed}) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Container(
      height: 30,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.red),
      child: const Center(
        child: CommonText(
          text: "Cancel",
          color: AppColors.secondaryColor,
          size: AppConstants.smallFont,
        ),
      ),
    ),
    onPressed: () {
      if (kDebugMode) {
        print("print");
      }
      Get.back();
    },
  );
  Widget continueButton = TextButton(
    onPressed: confirmButtonPressed,
    child: Container(
      height: 30,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.green),
      child: const Center(
        child: CommonText(
          text: "Confirm",
          color: AppColors.secondaryColor,
          size: AppConstants.smallFont,
        ),
      ),
    ),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15.0),
      ),
    ),
    backgroundColor: Colors.grey.shade300,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
          size: 25,
        ),
        SizedBox(
          width: 10,
        ),
        CommonText(text: "Alert")
      ],
    ),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [CommonText(text: content)],
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}