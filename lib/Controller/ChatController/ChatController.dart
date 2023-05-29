
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Controller/HomeController/HomeController.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {

@override
  void onInit() {
    // TODO: implement onInit
    getChatId();
    super.onInit();
  }
  
    var chats = firestore.collection(chatCollections);

    var friendName = Get.arguments[0];
    var friendId = Get.arguments[1];

    var senderName = Get.find<HomeController>().username.value;
    var currentID = currentUser!.uid;

    var msgController = TextEditingController();

    dynamic chatDocId;

    var isloading = false.obs;

    getChatId()async{
      isloading(true);
      await chats
      .where('users',isEqualTo: {friendId : null, currentID:null})
      .limit(1)
      .get().
      then((QuerySnapshot snapshot){
        //if they already chat
        if (snapshot.docs.isNotEmpty) {
          chatDocId = snapshot.docs.single.id;
        }else{
          //if they chat first time
          chats.add({
            'created_on' : null,
            'last_msg' : '',
            'users' : {friendId:null,currentID:null},
            'toId' : '',
            'fromId' : '',
            'friend_name' : friendName,
            'sender_name' : senderName
          }).then((value){
            chatDocId = value.id;
          });
        }
        print(chatDocId);
      });
      isloading(false);
    }
 
    sendmsg(String msg)async{
      if (msg.trim().isNotEmpty) {
          chats.doc(chatDocId).update({
            'created_on' : FieldValue.serverTimestamp(),
            'last_msg' : msg,
            'toId' : friendId,
            'fromId' : currentID
          });

          chats.doc(chatDocId).collection(messageCollections).doc().set({
            'created_on' : FieldValue.serverTimestamp(),
            'msg' : msg,
            'uid' : currentID
          });
      }
    }
}