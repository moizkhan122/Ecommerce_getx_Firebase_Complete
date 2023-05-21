

import 'package:emart_app/Controller/firebase_services/AuthController.dart';
import 'package:emart_app/Widgets/AppLogo_Widget.dart';
import 'package:emart_app/Widgets/Bg_Widget.dart';
import 'package:emart_app/Widgets/customTextField_Widget.dart';
import 'package:emart_app/Widgets/ourButton.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/AuthViews/LoginView/LoginView.dart';
import 'package:emart_app/views/HomeView/HomeView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SIgnUpView extends StatefulWidget {
  const SIgnUpView({super.key});

  @override
  State<SIgnUpView> createState() => _SIgnUpViewState();
}

class _SIgnUpViewState extends State<SIgnUpView> {
  bool? ischeck = false;
  var controller = Get.put(AuthController());

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var reTypePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //using velocity X define 10 percent hight from Top for responsive and adject nay device
                (context.screenHeight * 0.1).heightBox,
                applogoWidget(),
                10.heightBox,//height from velocityx
                "Join the $appname".text.fontFamily(bold).white.size(20).make(),
                15.heightBox,
                Obx(()=> Column(
                    children: [
                      customTextField(title: name,titleHint: nameHint,controller: nameController,ispass: false),
                      customTextField(title: email,titleHint: emailHint,controller: emailController,ispass: false),
                      customTextField(title: password,titleHint: passHint,controller: passwordController,ispass: true),
                      customTextField(title: retypepass,titleHint: passHint,controller: reTypePasswordController,ispass: true),
                      5.heightBox,
                       Align(
                        alignment: Alignment.bottomRight,
                         child: TextButton(
                            onPressed: (){}, 
                            child: forgetPass.text.size(18).make()),
                       ),
                        5.heightBox,
                        Row(
                          children: [
                            Checkbox(
                              activeColor: redColor,
                              checkColor: whiteColor,
                              value: ischeck, 
                              onChanged: (value) {
                                setState(() {
                                  ischeck = value;
                                });
                              },),
                              Expanded(
                                child: RichText(
                                  text:const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "I Agree to the ",
                                        style: TextStyle(
                                          fontFamily: bold,
                                          color: fontGrey
                                        )
                                        ),
                                        TextSpan(
                                        text: termEndCond,
                                        style: TextStyle(
                                          fontFamily: bold,
                                          color: redColor
                                        )
                                        ),
                                        TextSpan(
                                        text: " &",
                                        style: TextStyle(
                                          fontFamily: bold,
                                          color: fontGrey
                                        )
                                        ),
                                        TextSpan(
                                        text: privacyPolicy,
                                        style: TextStyle(
                                          fontFamily: bold,
                                          color: redColor
                                        )
                                        ),
                                    ]
                                  )),
                              ),
                          ],),
                          5.heightBox,
                       controller.isloading.value ?const CircularProgressIndicator(
                       valueColor: AlwaysStoppedAnimation(redColor), 
                       ):ourButton(
                        title: signup, color:ischeck == true ?redColor : lightGrey,onpress: ()async{
                          controller.isloading(true);
                          if (ischeck != false) {
                            try {
                              await controller.signUpMethod(
                                context: context,
                                email: emailController.text.toString(),
                                password: passwordController.text.toString()
                              ).then((value){
                                return controller.storeUserData(
                                  email: emailController.text,
                                  name: nameController.text,
                                  password: passwordController.text
                                );
                              }).then((value){
                                Get.offAll(()=> LoginView());
                              });
                            } catch (e) {
                              auth.signOut();
                              VxToast.show(context, msg: e.toString());
                              controller.isloading(false);
                            }
                          }
                        },txtColor: whiteColor
                        ).box.width(context.screenWidth - 50).make(),
                        10.heightBox,
                        //wrapping into Gesture detector in velocity X
                        RichText(
                                  text:const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: alreadyhaveacc,
                                        style: TextStyle(
                                          fontFamily: bold,
                                          color: fontGrey
                                        )
                                        ),
                                        TextSpan(
                                        text: login,
                                        style: TextStyle(
                                          fontFamily: bold,
                                          color: redColor
                                        )
                                        ),
                                    ]
                                  )).onTap(() {
                                    Get.back();
                                  }),
                    ],
                  ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
                ),
              ],),
          )),
      ));
  }
}