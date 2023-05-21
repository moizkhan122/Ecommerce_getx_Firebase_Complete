

import 'package:emart_app/consts/consts.dart';

Widget homeButton({String? title, icon, width, height, onpress}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon,fit: BoxFit.cover,width: 26,),
      5.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.size(width, height).rounded.white.make();
}