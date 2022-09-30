import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../../../controller/auth/auth.dart';
import '../../themes/colors.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Easy Booking",
            body: 'The man who never reads lives only one.',
            image: buildImage(imgName: "on_board_one"),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'Patient Caring',
            body:
                'The app embraces users with a tour of its Salon and gives an inadequate explanation of the features and abilities',
            image: buildImage(imgName: "on_board_two"),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'Professional Doctors',
            body: 'For enhanced reading experience',
            image: buildImage(imgName: "on_board_three"),
            decoration: getPageDecoration(),
          ),
        ],
        done: const Text('Done',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Oswald')),
        onDone: () => goToHome(),
        showSkipButton: true,
        skip: const Text('Skip',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Oswald')),
        onSkip: () => goToHome(),
        next: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
          size: 25,
        ),
        dotsDecorator: getDotDecoration(),
        dotsContainerDecorator: getContainerDecoration(),
        onChange: (index) {},
        // globalBackgroundColor: Theme.of(context).primaryColor,
        skipOrBackFlex: 0,
        nextFlex: 0,
        controlsPosition: const Position(bottom: 15, left: 10, right: 10),
        controlsMargin: const EdgeInsets.all(10),
        controlsPadding: const EdgeInsets.all(10),
        // isProgressTap: false,
        // isProgress: false,
        // showNextButton: false,
        // freeze: true,
        // animationDuration: 1000,
      );

  void goToHome() => AuthController.to.setOnBoardDataAfterScreenCompleted();

  Widget buildImage({required String imgName}) =>
      Center(child: SvgPicture.asset("assets/svgs/$imgName.svg"));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Colors.grey,
        activeColor: Colors.white,
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  Decoration getContainerDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.primaryColor,
        // gradient: const LinearGradient(
        //   colors: [
        //     AppColors.primaryColor,
        //     AppColors.secondaryColor,
        //   ],
        //   begin: Alignment.centerLeft,
        //   end: Alignment.centerRight,
        // )
      );

  PageDecoration getPageDecoration() => const PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Oswald'),
        bodyTextStyle: TextStyle(
            fontSize: 20, fontFamily: 'Oswald', color: AppColors.tertiaryColor),
        // bodyPadding: const EdgeInsets.all(10).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white,
      );
}
