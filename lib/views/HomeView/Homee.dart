
import 'package:emart_app/Controller/HomeController/HomeController.dart';
import 'package:emart_app/Widgets/exit_Dialog.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/CartView/CartView.dart';
import 'package:emart_app/views/Categories/Categories.dart';
import 'package:emart_app/views/HomeView/HomeView.dart';
import 'package:emart_app/views/ProfileView/ProfileView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homee extends StatelessWidget {
  const Homee({super.key});

  @override
  Widget build(BuildContext context) {

    final  controller = Get.put(HomeController());

    var navbarItems = [
      BottomNavigationBarItem(icon: Image.asset(icHome, width: 26,), label: home),
      BottomNavigationBarItem(icon: Image.asset(icCategories, width: 26,), label: categories),
      BottomNavigationBarItem(icon: Image.asset(icCart, width: 26,), label: cart),
      BottomNavigationBarItem(icon: Image.asset(icProfile, width: 26,), label: account),
    ];

    var navBody = [
      const HomeView(),
       CategoriesView(),
      const CartView(),
      const ProfileViewView(),
    ];
    return WillPopScope(
      onWillPop: ()async{
        showDialog(
          barrierDismissible: false,
          context: context, builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(child: navBody.elementAt(controller.currentNavbarIndex.value)),)
          ],
        ),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
          currentIndex: controller.currentNavbarIndex.value,
          selectedItemColor: redColor,
          selectedLabelStyle:const TextStyle(fontFamily: semibold),
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          items: navbarItems,
          onTap: (value) => controller.currentNavbarIndex.value = value,
          ),)
      ),
    );
  }
}