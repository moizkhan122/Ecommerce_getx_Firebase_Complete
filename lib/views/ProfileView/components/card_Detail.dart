
import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget cardDetails({width,String? count, String? title}){
  return  Column(
    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        count!.text.size(15).fontFamily(semibold).color(darkFontGrey).make(),
                        3.heightBox,
                        title!.text.size(15).fontFamily(semibold).color(darkFontGrey).make(),
                      ],
                      )
                      .box.rounded.width(width).height(70).white.padding(const EdgeInsets.all(6)).make();
}