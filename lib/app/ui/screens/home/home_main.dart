import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/main/main.dart';
import '../../themes/colors.dart';


class HomeMain extends StatefulWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  List<Widget> widgets = [
   //To crate pages, means bottom navigating menus

  ];

  @override
  void initState() {
    super.initState();
    // ProfileController.to.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.primaryColor,
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: AppColors.primaryColor,
          ),
          child: Obx(
                () => FloatingNavbar(
              onTap: (int val) =>
                  setState(() => MainController.to.changeIndex = val),
              currentIndex: MainController.to.changeIndex,
              items: [
                FloatingNavbarItem(icon: Icons.list, title: 'Appointments'),
                FloatingNavbarItem(icon: Icons.home_filled, title: 'Home'),
                FloatingNavbarItem(icon: Icons.person, title: 'Profile'),
              ],
            ),
          ),
        ),
        body: Obx(() => widgets[MainController.to.changeIndex]));
  }
}
