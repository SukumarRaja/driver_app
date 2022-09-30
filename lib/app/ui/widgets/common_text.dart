//Packages
import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/constants.dart';

class CommonText extends StatelessWidget {
  const CommonText(
      {Key? key,
      this.text,
      this.size = AppConstants.smallFont,
      this.color = AppColors.tertiaryColor,
      this.fontWeight,
      this.decoration,
      this.decorationThickness,
      this.textAlign,
      this.overFlow})
      : super(key: key);
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final double? decorationThickness;
  final TextAlign? textAlign;
  final TextOverflow? overFlow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: textAlign,
      overflow: overFlow,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
        fontFamily: 'Oswald',
        decoration: decoration,
        decorationThickness: decorationThickness,
      ),
    );
  }
}
