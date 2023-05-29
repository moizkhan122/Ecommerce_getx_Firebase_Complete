import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble(DocumentSnapshot data){
  var t = data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  return Directionality(
    textDirection: data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
                        padding:const EdgeInsets.all(12),
                        margin:const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius:const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color:data['uid'] == currentUser!.uid ? redColor : darkFontGrey,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data['msg']}".text.color(Colors.white).size(15).make(),
                          10.heightBox,
                            time.text.color(Colors.white).size(15).make(),
                          ]),
                        ),
  );
}