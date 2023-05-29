
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Controller/ChatController/ChatController.dart';
import 'package:emart_app/Widgets/loadingIndicator.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firebaseServices/firestoreServices/firestoreServices.dart';
import 'package:emart_app/views/ChatView/Components/sender_bubble.dart';
import 'package:get/get.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    
    var controller = Get.put(ChatController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${controller.friendName}".text.size(20).fontFamily(bold).color(darkFontGrey).make()),
        body: Padding(
          padding:const EdgeInsets.all(12),
        child: Column(
          children: [
            Obx(
              ()=>
              controller.isloading.value ? Center(child: loadingIndicator(),) :
               Expanded(
                child: StreamBuilder(
                  stream: FirestoreServices.getChatMessages(controller.chatDocId.toString()),
                  builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                        return Center(child: loadingIndicator(),);
                    } else if(snapshot.data!.docs.isEmpty) {
                        return Center(child: "Send a Message...".text.size(20).color(darkFontGrey).make(),);
                    }
                    else{
                      return ListView(
                        children: snapshot.data!.docs.mapIndexed((currentValue, index){
                          var data =  snapshot.data!.docs[index];
                          return Align(
                            alignment: data['uid'] == currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
                            child: senderBubble(data));
                        }).toList(),
                        );
                    }
                },) ),
            ),
              Row(
                children: [
                  Expanded(child: TextFormField(
                    controller: controller.msgController,
                    decoration:const InputDecoration(
                      hintText: "Type message here....",
                      border: OutlineInputBorder(borderSide: BorderSide(color: textfieldGrey)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: textfieldGrey))
                    ),
                  )),
                  IconButton(
                    onPressed: (){
                      controller.sendmsg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                     icon:const Icon(Icons.send,color: redColor,)),
                ],
              ).box.height(80).padding(const EdgeInsets.all(12)).margin(const EdgeInsets.only(bottom: 5)).make()
          ]),
        ),
    );
  }
}

/***/