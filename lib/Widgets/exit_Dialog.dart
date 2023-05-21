
import 'package:emart_app/Widgets/ourButton.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.size(20).color(darkFontGrey).fontFamily(bold).make(),
        const Divider(),
        10.heightBox,
        "Are u sure want to exit the App?".text.size(18).color(darkFontGrey).fontFamily(semibold).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ourButton(color: redColor,onpress: (){
              SystemNavigator.pop();
            },txtColor: whiteColor,title: "Yes"),
            ourButton(color: redColor,onpress: (){
              Navigator.pop(context);
            },txtColor: whiteColor,title: "No"),
          ],
        )
      ]
      ).box.rounded.color(Colors.white).padding(const EdgeInsets.all(12)).make(),
  );
}