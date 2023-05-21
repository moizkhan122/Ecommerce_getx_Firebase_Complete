
import 'package:emart_app/Widgets/AppLogo_Widget.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/res/routes/routesNames.dart';
import 'package:emart_app/views/AuthViews/LoginView/LoginView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  changeScreen(){
    Future.delayed(Duration(seconds: 4), (){
       //Get.to( Get.toNamed(RoutesName.loginScreen));
       auth.authStateChanges().listen((User? user) { 
            if (user == null && mounted) {
              Get.toNamed(RoutesName.loginScreen);
            } else {
              Get.toNamed(RoutesName.homeView);
            }
       });
    } 
    ,);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Column(children: [
        Align(
          alignment: Alignment.topLeft,
          child: Image.asset(icSplashBg,width: 200,)),
          20.heightBox,
          applogoWidget(),
          10.heightBox,
          appname.text.fontFamily(bold).size(30).white.make(),
          5.heightBox,
          appversion.text.white.make(),
          Spacer(),
          credits.text.fontFamily(bold).size(25).white.make(),
          30.heightBox,
      ]),
    );
  }
}