import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Widgets/loadingIndicator.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firebaseServices/firestoreServices/firestoreServices.dart';
import 'package:emart_app/views/ChatView/ChatView.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: "My Messages".text.size(20).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
              return Center( child: loadingIndicator());
          } else if(snapshot.data!.docs.isEmpty){
              return Center(child: "No Message yet!".text.size(20).color(darkFontGrey).make(),);
          }else{
            var data = snapshot.data!.docs;
            return Padding(
          padding:const EdgeInsets.all(12),
          child: Column(
            children: [
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: (){
                      Get.to(()=>const ChatView(),
                      arguments: [
                        data[index]['friend_name'],
                        data[index]['toId']
                      ],
                      );  
                      },
                      leading:const CircleAvatar(
                        backgroundColor: redColor,
                        child: Icon(Icons.person,color: whiteColor,)),
                      title: "${data[index]['friend_name']}".text.make(),
                      subtitle: "${data[index]['last_msg']}".text.make(),
                  ),
                );
              },)
            ),
            10.heightBox,
           
        ],)
        );
          }
      },),
    );
  }
}