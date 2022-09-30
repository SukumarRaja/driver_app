import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/app/controller/auth/auth.dart';
import 'package:patient_app/app/ui/themes/colors.dart';
import 'package:patient_app/app/ui/themes/constants.dart';
import 'package:patient_app/app/ui/widgets/common_button.dart';
import 'package:patient_app/app/ui/widgets/common_text.dart';
import 'package:patient_app/app/ui/widgets/common_text_form_field.dart';

import '../../widgets/common_icon_button.dart';
import '../../widgets/common_text_button.dart';
import '../map/map.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
        // backgroundColor: AppColors.primaryColor.withOpacity(0.1),
        body: SingleChildScrollView(
      child: Column(
        children: [
          Obx(() => AuthController.to.isSignUp == true
              ? SizedBox(
                  height: media.height * 0.05,
                )
              : const SizedBox()),
          Obx(() => AuthController.to.isSignUp == true
              ? Row(
                  children: [
                    SizedBox(
                      width: media.width * 0.04,
                    ),
                    CommonIconButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      iconColor: AppColors.primaryColor,
                      iconSize: 35,
                      onTap: () {
                        AuthController.to.isSignUp = false;
                      },
                    )
                  ],
                )
              : const SizedBox()),
          Obx(() => Container(
              height: AuthController.to.isSignUp == true
                  ? media.height * 0.15
                  : media.height * 0.35,
              width: media.width,
              decoration: const BoxDecoration(
                  // color: AppColors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => CommonText(
                        text: AuthController.to.isSignUp ? "" : "Welcome Back",
                        fontWeight: FontWeight.bold,
                        size: AppConstants.largeFont,
                      )),
                  SizedBox(
                    height: media.height * 0.02,
                  ),
                  Obx(() => CommonText(
                        text: AuthController.to.isSignUp ? "SignUp " : "Login",
                        fontWeight: FontWeight.bold,
                        size: AppConstants.largeFont,
                      )),
                  // SvgPicture.asset("assets/svgs/$imgName.svg")
                ],
              ))),
          Obx(() => AuthController.to.isSignUp == true
              ? buildSignUp(media)
              : buildSignIn(media))
        ],
      ),
    ));
  }

  Column buildSignUp(Size media) {
    return Column(
      children: [
        Form(
            child: Column(
          children: [
            CommonTextFormField(
                radius: 8.0,
                obscureText: false,
                maxLines: 1,
                hintText: "Enter Phone Number",
                validator: (data) {}),
            Obx(() => AuthController.to.isOtpSend == true
                ? CommonTextFormField(
                    radius: 8.0,
                    obscureText: true,
                    maxLines: 1,
                    hintText: "Enter Password",
                    validator: (data) {})
                : const SizedBox())
          ],
        )),
        SizedBox(
          height: media.width * 0.08,
        ),
        Obx(() => AuthController.to.isOtpSend == true
            ? CommonButton(
                text: "Verify Otp",
                onPressed: () {},
              )
            : CommonButton(
                text: "Send Otp",
                onPressed: () {},
              )),
        SizedBox(
          height: media.height * 0.04,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CommonText(
              text: "Didn't get Otp ? ",
            ),
            CommonTextButton(
              text: "Resend",
              color: AppColors.primaryColor,
              onTap: () {},
            ),
            SizedBox(
              width: media.width * 0.04,
            )
          ],
        ),
      ],
    );
  }

  Column buildSignIn(Size media) {
    return Column(
      children: [
        Form(
            child: Column(
          children: [
            CommonTextFormField(
                radius: 8.0,
                obscureText: false,
                maxLines: 1,
                hintText: "Enter Phone Number",
                validator: (data) {}),
            CommonTextFormField(
                radius: 8.0,
                obscureText: true,
                maxLines: 1,
                hintText: "Enter Password",
                validator: (data) {})
          ],
        )),
        SizedBox(
          height: media.width * 0.04,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CommonTextButton(
              text: "Forgot Password ? ",
              onTap: () {},
            ),
            SizedBox(
              width: media.width * 0.04,
            )
          ],
        ),
        SizedBox(
          height: media.height * 0.04,
        ),
        CommonButton(
          text: "Login",
          onPressed: () {
            Get.to(()=>MapPage());
          },
        ),
        SizedBox(
          height: media.height * 0.04,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CommonText(
              text: "Don't hava an account ",
            ),
            CommonTextButton(
              text: "SignUp ? ",
              color: AppColors.primaryColor,
              onTap: () {
                AuthController.to.isSignUp = true;
              },
            ),
            SizedBox(
              width: media.width * 0.04,
            )
          ],
        ),
      ],
    );
  }
}
