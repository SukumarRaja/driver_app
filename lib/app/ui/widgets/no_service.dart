import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../themes/constants.dart';
import 'common_text.dart';

class ServerError extends StatelessWidget {
  const ServerError({Key? key, required this.emptyMsg}) : super(key: key);
  final String emptyMsg;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset("assets/svgs/no_service.svg"),
        CommonText(
          text: emptyMsg,
          size: AppConstants.mediumFont,
        )
      ],
    );
  }
}
