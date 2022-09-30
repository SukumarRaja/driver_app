import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../themes/constants.dart';
import 'common_text.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key, required this.emptyMsg}) : super(key: key);
  final String emptyMsg;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset("assets/svgs/no_data.svg"),
        CommonText(
          text: emptyMsg,
          size: AppConstants.mediumFont,
        )
      ],
    );
  }
}
