
import 'package:emart_app/Controller/ChatController/ChatController.dart';
import 'package:emart_app/consts/consts.dart';
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
        title: "Title".text.size(15).fontFamily(bold).make()),
        body: Padding(
          padding:const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  senderBubble(),
                  senderBubble()
                ])),
              Row(
                children: [
                  Expanded(child: TextFormField(
                    decoration:const InputDecoration(
                      hintText: "Type message here....",
                      border: OutlineInputBorder(borderSide: BorderSide(color: textfieldGrey)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: textfieldGrey))
                    ),
                  )),
                  IconButton(
                    onPressed: (){},
                     icon:const Icon(Icons.send,color: redColor,)),
                ],
              ).box.height(80).padding(const EdgeInsets.all(12)).margin(const EdgeInsets.only(bottom: 5)).make()
          ]),
        ),
    );
  }
}