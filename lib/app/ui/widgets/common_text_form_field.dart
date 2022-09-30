import 'package:flutter/material.dart';

import '../themes/colors.dart';

class CommonTextFormField extends StatefulWidget {
  const CommonTextFormField(
      {Key? key,
      required this.hintText,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.maxLength,
      required this.validator,
      this.obscureText,
      this.suffixIcon,
      this.maxLines,
      this.radius = 25.0})
      : super(key: key);
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final int? maxLength;
  final int? maxLines;
  final String? Function(String?) validator;
  final bool? obscureText;
  final Widget? suffixIcon;
  final double radius;

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          color: AppColors.grey.withOpacity(.2)),
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        maxLines: widget.maxLines,
        cursorColor: AppColors.secondaryColor,
        obscureText: widget.obscureText! ? !makePasswordVisible : false,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        maxLength: widget.maxLength,
        validator: widget.validator,
        style: const TextStyle(
            fontFamily: 'Oswald', color: AppColors.secondaryColor),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: AppColors.primaryColor.withAlpha(90)),
          contentPadding: const EdgeInsets.all(15),
          border: InputBorder.none,
          suffixIcon: widget.suffixIcon ?? _getSuffixWidget(),
        ),
      ),
    );
  }

  bool makePasswordVisible = false;

  Widget _getSuffixWidget() {
    if (widget.obscureText!) {
      return ButtonTheme(
        minWidth: 30,
        height: 30,
        padding: const EdgeInsets.all(0),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(0),
          ),
          onPressed: () {
            setState(() {
              makePasswordVisible = !makePasswordVisible;
            });
          },
          child: Icon(
            (!makePasswordVisible) ? Icons.visibility_off : Icons.visibility,
            color: AppColors.secondaryColor.withOpacity(.5),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
