
import 'package:emart_app/res/routes/routesNames.dart';
import 'package:emart_app/views/AuthViews/LoginView/LoginView.dart';
import 'package:emart_app/views/AuthViews/SignUpView/SignUpView.dart';
import 'package:emart_app/views/HomeView/Homee.dart';
import 'package:emart_app/views/Splashviews/SplashViews.dart';
import 'package:get/get.dart';

class AppRoutes {

    static approutes() => [
      GetPage(
        name: RoutesName.splashScreen, 
        page: ()=> const SplashView(),
        transitionDuration: const Duration(milliseconds: 250),
        transition: Transition.leftToRight
        ),

        GetPage(
        name: RoutesName.loginScreen, 
        page: ()=> LoginView (),
        transitionDuration: const Duration(milliseconds: 250),
        transition: Transition.leftToRight
        ),

        GetPage(
        name: RoutesName.signUpScreen, 
        page: ()=> const SIgnUpView(),
        transitionDuration: const Duration(milliseconds: 250),
        transition: Transition.leftToRight
        ),

        GetPage(
        name: RoutesName.homeView, 
        page: ()=>const Homee(),
        transitionDuration: const Duration(milliseconds: 250),
        transition: Transition.leftToRight
        ),
    ];
}