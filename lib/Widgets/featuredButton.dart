

import 'package:emart_app/consts/consts.dart';
//{String? title, icon, width, height, onpress}
Widget featuredButton({String? title, icon}){
  return Row(
    children: [
      Image.asset(icon,fit: BoxFit.cover,width: 60,),
      5.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.width(200).rounded.white.margin(const EdgeInsets.symmetric(horizontal: 5)).padding(const EdgeInsets.all(5)).roundedSM.outerShadowSm.make();
}