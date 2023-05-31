import 'package:emart_app/consts/consts.dart';

orderDetails({title1,titleValue1,title2,titleValue2,}) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                "$title1".text.size(16).color(darkFontGrey).make(),
                "$titleValue1".text.size(15).color(Colors.grey).make(),
              ],),
              Column(children: [
                "$title2".text.size(16).color(darkFontGrey).make(),
                "$titleValue2".text.size(15).color(Colors.grey).make(),
              ],),
            ],);
  }

  completeAdressWithAmount({adr1,adr2,adr3,adr4,adr5,adr6,adr7,totalAmount}) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Shipping Adress".text.size(18).color(darkFontGrey).make(),
                  5.heightBox,
                  "$adr1".text.size(16).color(Colors.grey).make(),
                  3.heightBox,
                  "$adr2".text.size(16).color(Colors.grey).make(),
                  3.heightBox,
                  "$adr3".text.size(16).color(Colors.grey).make(),
                  3.heightBox,
                  "$adr4".text.size(16).color(Colors.grey).make(),
                  3.heightBox,
                  "$adr5".text.size(16).color(Colors.grey).make(),
                  3.heightBox,
                  "$adr6".text.size(16).color(Colors.grey).make(),
                  3.heightBox,
                  "$adr7".text.size(16).color(Colors.grey).make(),
                  

                ],),
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                children: [
                "Total Amount".text.size(18).color(darkFontGrey).make(),
                80.heightBox,
                "$totalAmount".text.size(20).color(redColor).make(),
                ],)
            ],);
  }