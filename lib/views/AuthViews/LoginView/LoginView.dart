
import 'package:emart_app/Controller/firebase_services/AuthController.dart';
import 'package:emart_app/Widgets/AppLogo_Widget.dart';
import 'package:emart_app/Widgets/Bg_Widget.dart';
import 'package:emart_app/Widgets/customTextField_Widget.dart';
import 'package:emart_app/Widgets/ourButton.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/res/routes/routesNames.dart';
import 'package:emart_app/views/HomeView/HomeView.dart';
import 'package:emart_app/views/HomeView/Homee.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
   LoginView({super.key});

  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              //using velocity X define 10 percent hight from Top for responsive and adject nay device
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,//height from velocityx
              "Log In To $appname".text.fontFamily(bold).white.size(20).make(),
              15.heightBox,
              Obx(
                () => Column(
                  children: [
                    customTextField(title: email,titleHint: emailHint,ispass: false,controller: controller.emailController),
                    customTextField(title: password,titleHint: passHint,ispass: true,controller: controller.passwordController),
                    5.heightBox,
                     Align(
                      alignment: Alignment.bottomRight,
                       child: TextButton(
                          onPressed: (){}, 
                          child: forgetPass.text.size(18).make()),
                     ),
                     5.heightBox,
                     controller.isloading.value ?const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                     ) : ourButton(
                      title: login, color: redColor,onpress: ()async{
                        controller.isloading(true);
                        // Get.toNamed(RoutesName.homeView);
                          await controller.loginMethod(context: context).then((value){
                            if (value!= null) {
                              VxToast.show(context, msg: logedIn);
                              Get.offAll(()=>const Homee());
                            }else{
                              controller.isloading(false);
                            }
                          });
                        }
                        ,txtColor: whiteColor
                      ).box.width(context.screenWidth - 50).make(),
                      5.heightBox,
                      createnewAcc.text.color(fontGrey).fontFamily(bold).size(17).make(),
                      ourButton(color: lightgolden, onpress: (){Get.toNamed(RoutesName.signUpScreen);}, title: signup, txtColor: redColor,
                      ).box.width(context.screenWidth - 50).make(),
                      10.heightBox,
                      loginWith.text.color(fontGrey).make(),
                      5.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, 
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: lightGrey,
                            radius: 25,
                            child: Image.asset(socialIconList[index],width: 30,)),
                        )),
                      )
                  ],
                ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
              ),
            ],)),
      ));
  }
}