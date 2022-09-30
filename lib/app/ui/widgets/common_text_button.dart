//Packages
import 'package:flutter/material.dart';

class CommonTextButton extends StatelessWidget {
  const CommonTextButton(
      {Key? key,
      this.text,
      this.size = 16.0,
      this.color = Colors.black,
      this.fontWeight,
      this.onTap})
      : super(key: key);
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? fontWeight;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text!,
        style: TextStyle(fontSize: size, color: color, fontWeight: fontWeight),
      ),
    );
  }
}
