import 'package:flutter/material.dart';
import 'package:patient_app/app/ui/widgets/common_text.dart';
import '../../themes/colors.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Container(
        color: AppColors.white,
        width: media.width * 0.8,
        child: Drawer(
          child: SizedBox(
            width: media.width * 0.7,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height:
                        media.width * 0.05 + MediaQuery.of(context).padding.top,
                  ),
                  SizedBox(
                    width: media.width * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: media.width * 0.2,
                          width: media.width * 0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: media.width * 0.025,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: media.width * 0.45,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: media.width * 0.3,
                                      child: const CommonText(
                                        text: "Name",
                                      )),
                                  //edit profile
                                  InkWell(
                                    onTap: () async {
                                      // var val = await Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const EditProfile()));
                                      // if (val) {
                                      //   setState(() {});
                                      // }
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      size: media.width * 0.18,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: media.width * 0.01,
                            ),
                            SizedBox(
                                width: media.width * 0.45,
                                child: const CommonText(
                                  text: "Email",
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: media.width * 0.1),
                    width: media.width * 0.7,
                    child: Column(
                      children: [
                        buildListTile(media,
                            text: "History", icon: "history", onPressed: () {}),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  InkWell buildListTile(Size media,
      {required String icon,
      required String text,
      required Function() onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(media.width * 0.025),
        child: Row(
          children: [
            Image.asset(
              'assets/images/$icon.png',
              fit: BoxFit.contain,
              width: media.width * 0.075,
            ),
            SizedBox(
              width: media.width * 0.025,
            ),
            SizedBox(width: media.width * 0.55, child: CommonText(text: text))
          ],
        ),
      ),
    );
  }
}
