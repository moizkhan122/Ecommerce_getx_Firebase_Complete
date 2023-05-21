
import 'dart:io';

import 'package:emart_app/Controller/ProfileController/ProfileController.dart';
import 'package:emart_app/Widgets/Bg_Widget.dart';
import 'package:emart_app/Widgets/customTextField_Widget.dart';
import 'package:emart_app/Widgets/ourButton.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
   EditProfile({super.key, this.data});

  final dynamic data;

  @override
  Widget build(BuildContext context) {
      var controllr = Get.find<ProfileController>();
      
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx( ()=>SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //profile pic picked from gellry end sett
                data['imgUrl']=='' && controllr.profileImgPath.isEmpty?
                Image.asset(imgProfile2,fit: BoxFit.cover,width: 80,).box.roundedFull.clip(Clip.antiAlias).make()
                : 
                data['imgUrl'] !='' && controllr.profileImgPath.isEmpty?
                Image.network(data['imgUrl'],fit: BoxFit.cover,width: 80,).box.roundedFull.clip(Clip.antiAlias).make()
              :
                Image.file(
                  File(controllr.profileImgPath.value),
                  width: 100,
                  fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make(),
                
                10.heightBox,
                ourButton(color: redColor,onpress: (){
                  //function to pic pic fom gellery
                  controllr.changeImage(context);
                },txtColor: Colors.white,title: "Changed"),
                const Divider(color: Colors.black),
                20.heightBox,
                customTextField(ispass: false,title: name,titleHint: nameHint,controller: controllr.namecontroller),
                10.heightBox,
                customTextField(ispass: true,title: oldpass,titleHint: passHint,controller: controllr.oldpasscontroller),
                10.heightBox,
                customTextField(ispass: true,title: newpass,titleHint: passHint,controller: controllr.newpasscontroller),
                20.heightBox,
                
                controllr.isLoading.value ?const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),)
                :SizedBox(
                  width: context.screenWidth - 60,
                  child: ourButton(color: redColor,onpress: ()async{
                    controllr.isLoading(true);
                    //check if user chnaged profile image so
                    if (controllr.profileImgPath.value.isNotEmpty) {
                    await controllr.uploadprofileImage();  
                    } else {
                      //if user dont changed profile image
                      controllr.profileImagelink = data['imgUrl'];
                    }
                    //check first is old password matches from database password then chnages
                    if (data['password'] == controllr.oldpasscontroller.text) {

                      await controllr.changedAuthPassword(
                        email: data['email'],
                        password: controllr.oldpasscontroller.text,
                        newpassword: controllr.newpasscontroller.text
                      );

                      await controllr.updateProfile(
                      imgUrl: controllr.profileImagelink,
                      name: controllr.namecontroller.text,
                      password: controllr.newpasscontroller.text,
                    );
                     // ignore: use_build_context_synchronously
                     VxToast.show(context, msg: "Updated");    
                    }else{
                      // ignore: use_build_context_synchronously
                      VxToast.show(context, msg: "Wrong Old Password");
                      controllr.isLoading(false);
                    }
                  
                  },title: "Saved",txtColor: Colors.white),
                )
              ],
            ).box.white.rounded.shadowSm.padding(const EdgeInsets.all(14)).margin(const EdgeInsets.only(top: 10,left: 12,right: 12)).make(),
        ),
        ),
      )
    );
  }
}