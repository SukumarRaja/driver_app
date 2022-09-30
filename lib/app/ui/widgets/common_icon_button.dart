import 'package:flutter/material.dart';

class CommonIconButton extends StatelessWidget {
  const CommonIconButton(
      {Key? key,
      required this.onTap,
      required this.icon,
      this.iconColor,
      this.iconSize})
      : super(key: key);
  final Function() onTap;
  final IconData icon;
  final Color? iconColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ));
  }
}
