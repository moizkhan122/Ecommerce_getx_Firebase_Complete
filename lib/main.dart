import 'package:emart_app/res/routes/routes.dart';
import 'package:emart_app/views/Splashviews/SplashViews.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'consts/consts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: darkFontGrey),
          color: Colors.transparent,elevation: 0),
        fontFamily: regular
      ),
      home: const SplashView(),
      getPages: 
        AppRoutes.approutes(),
      debugShowCheckedModeBanner: false,
    );
  }
}
