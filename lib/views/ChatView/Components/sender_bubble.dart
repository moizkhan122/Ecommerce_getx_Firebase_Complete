import 'package:emart_app/consts/consts.dart';

Widget senderBubble(){
  return Container(
                      padding:const EdgeInsets.all(5),
                      margin:const EdgeInsets.only(bottom: 12),
                      decoration:const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        color: redColor,
                      ),
                      child: Column(
                        children: [
                          "Message here".text.color(Colors.black).size(15).make(),
                        10.heightBox,
                          "10:45 PM".text.color(Colors.black).size(15).make(),
                        ]),
                      );
}