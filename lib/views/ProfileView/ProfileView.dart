import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Controller/ProfileController/ProfileController.dart';
import 'package:emart_app/Controller/firebase_services/AuthController.dart';
import 'package:emart_app/Widgets/Bg_Widget.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/services/firebaseServices/firestoreServices/firestoreServices.dart';
import 'package:emart_app/views/AuthViews/LoginView/LoginView.dart';
import 'package:emart_app/views/ChatView/MessagingView.dart';
import 'package:emart_app/views/ProfileView/OrdersView/OrdersView.dart';
import 'package:emart_app/views/ProfileView/components/card_Detail.dart';
import 'package:emart_app/views/ProfileView/edit_profile.dart';
import 'package:emart_app/views/ProfileView/wishListView.dart/WIshListView.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProfileViewView extends StatelessWidget {
  const ProfileViewView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    
    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getuser(currentUser!.uid),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),
              );
            }
            else if (snapshot.data!.docs.isEmpty) {
      // Handle case where there are no documents in the collection that match the query criteria
      return const Center(child:  Text('No data available'));
      }
            else{
              var data = snapshot.data!.docs.first;
              return Column(
          children: [
            15.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: (){
                    controller.namecontroller.text = data['name'];
            
                    Get.to( EditProfile(data: data,));
                  }, 
                  icon:const Icon(Icons.edit,size: 20,color: Colors.white,))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                
                data['imgUrl'] == ''?
                Image.asset(imgProfile2,fit: BoxFit.cover,width: 80,).box.roundedFull.clip(Clip.antiAlias).make()
              : Image.network(data['imgUrl'],fit: BoxFit.cover,width: 80,).box.roundedFull.clip(Clip.antiAlias).make(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "${data['name']}".text.fontFamily(semibold).white.size(19).make(),
                    "Moizkhan@gmail.com".text.fontFamily(semibold).size(16).white.make(),
                  ],)),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side:const BorderSide(
                        color: Colors.white
                      )
                    ),
                    onPressed: ()async{
                      await Get.put(AuthController()).signOut(context);
                      Get.offAll(()=> LoginView());
                       // ignore: use_build_context_synchronously
                       VxToast.show(
                        bgColor: redColor,
                        textColor: Colors.white,
                        context, msg: "Logout succesfull");
                    },
                    child: "Logout".text.white.fontFamily(semibold).size(17).make())
              ],),
            ),
            10.heightBox,
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              cardDetails(count: "00",title: "In your Cart",width: context.screenWidth/3.4),
              cardDetails(count: "12",title: "In your Wishlist",width: context.screenWidth/3.4),
              cardDetails(count: "23",title: "In your order",width: context.screenWidth/3.4),
            ],),
            10.heightBox,
            //button section
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const Divider(color: darkFontGrey,);
              },
              itemCount: profileButtonList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: (){
                    switch (index) {
                      case 0:
                        Get.to(()=> const WishListView());
                        break;
                        case 1:
                        Get.to(()=> const OrdersView());
                        break;
                        case 2:
                        Get.to(()=> const MessageView());
                        break;
                      default:
                    }
                  },
                  leading: Image.asset(profileButtonIcon[index],width: 20,),
                  title: profileButtonList[index].text.fontFamily(semibold).make(),
                );
              }, 
              
              ).box.rounded.white.shadowSm.padding(const EdgeInsets.symmetric(horizontal: 16)).margin(const EdgeInsets.all(10)).make().box.color(redColor).make(),

          ],
        );

            }
        },)
       )
    );
  }
}