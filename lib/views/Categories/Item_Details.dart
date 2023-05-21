import 'package:emart_app/Controller/ProductController/ProductController.dart';
import 'package:emart_app/Widgets/ourButton.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/views/ChatView/ChatView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ItemDetails extends StatelessWidget {
   ItemDetails({super.key, required this.title,this.data});

  final String title;
  dynamic data;
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: ()async{
        controller.resetvalue();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            controller.resetvalue();
            Get.back();
          }, 
          icon:const Icon(Icons.arrow_back)),
          title: title.text.color(darkFontGrey).fontFamily(bold).size(25).make(),
          actions: [
            IconButton(
              onPressed: (){}, 
              icon:const Icon(Icons.share)),
              IconButton(
              onPressed: (){}, 
              icon:const Icon(Icons.favorite_outline))
          ],
        ),
        body: Column(
          children: [
             Expanded(
              child: Padding( 
                padding:const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  physics:const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    VxSwiper.builder(
                      autoPlay: true,
                      height: 350,
                      aspectRatio: 16/9,
                      itemCount: data['p_imgs'].length, 
                      itemBuilder: (context, index) {
                        return Image.network(
                          width: double.infinity,
                          data["p_imgs"][index].toString(),fit: BoxFit.cover,);
                      },),
                      10.heightBox,
                      title.text.color(darkFontGrey).size(20).fontFamily(semibold).make(),
                      20.heightBox,
                      //for products rating from Veloxity X
                      VxRating(
                        onRatingUpdate: (value) {
                          
                        },
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        count: 5,
                        size: 25,
                        stepInt: true,
                        ),
                        10.heightBox,
                        "${data["p_price"]}".numCurrency.text.fontFamily(bold).color(redColor).size(18).make(),
                        10.heightBox,
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              "Seller".text.white.fontFamily(bold).size(17).make(),
                              "${data["p_seller"]}".text.color(darkFontGrey).fontFamily(bold).size(22).make(),
                            ],)),
                            const CircleAvatar(
                              backgroundColor: whiteColor,
                              child: Icon(Icons.message_rounded),
                            ).onTap(() {
                              Get.to(()=> const ChatView(),
                              arguments: [
                                data['p_seller'],
                                data['sellerId'],
                              ]
                              );
                            })
                          ],
                          ).box.color(textfieldGrey).height(60).rounded.padding(const EdgeInsets.symmetric(horizontal: 15)).make(),
                          10.heightBox,
                          Obx(
                            ()=>Column(
                              children: [
                                //color row
                                Row(
                                  children: [
                                    SizedBox(width: 100,
                                    child: "Hello".text.color(darkFontGrey).make(),
                                    ),
                                    Row(
                                      children: List.generate(
                                        data['p_colors'].length, 
                                        (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox().size(40,40).roundedFull.margin(const EdgeInsets.symmetric(horizontal: 5)).color(Color(data['p_colors'][index]).withOpacity(1.0)).make()
                                            .onTap(() {
                                              controller.changecolorIndex(index);
                                            }),
                                             //color vsible on tap changed 
                                             Visibility(
                                              visible: index == controller.colorIndex.value,
                                              child:const Icon(Icons.done,color: Colors.white,weight: 25)),
                                          ],
                                        )))
                                  ],).box.padding(const EdgeInsets.all(12)).make(),
                                  //quantity row
                                  Row(
                                  children: [
                                    SizedBox(width: 100,
                                    child: "Quantity".text.color(darkFontGrey).make(),
                                    ),
                                    Obx(
                                      ()=>Row(
                                        children: [
                                          IconButton(
                                            onPressed:(){
                                              controller.decreasedQuantity();
                                              controller.totalprice(int.parse(data['p_price']));
                                            }, 
                                            icon:const Icon(Icons.remove)),
                                            controller.quantity.value.text.color(darkFontGrey).size(20).fontFamily(bold).make(),
                                            IconButton(
                                            onPressed:(){
                                              controller.increasedQuantity(
                                                int.parse(data['p_quantity']));
                                                controller.totalprice(int.parse(data['p_price']));
                                            }, 
                                            icon:const Icon(Icons.add)),
                                            "(${data['p_quantity']} available)".text.color(textfieldGrey).size(18).fontFamily(bold).make(),
                                        ],),
                                    )
                                  ],).box.padding(const EdgeInsets.all(12)).make(),
                                  //
                                  Row(
                                  children: [
                                    SizedBox(width: 100,
                                    child: "Total".text.color(darkFontGrey).make(),
                                    ),
                                    "${controller.totalPrice.value}".numCurrency.text.color(redColor).make()
                                  ],).box.color(golden.withOpacity(0.4)).rounded.padding(const EdgeInsets.all(12)).make(),
                              2.heightBox
                              ],
                              ).box.white.shadowSm.make(),
                          ),
                            10.heightBox,
                                "Description :".text.color(darkFontGrey).fontFamily(semibold).make(),
                            10.heightBox,
                            "${data['p_desc']}"
                            .text.color(darkFontGrey).fontFamily(semibold).make(),
                          10.heightBox,
                          //button seccion
                          ListView(
                            physics:const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: List.generate(
                              itemDetailButtonList.length, 
                            (index) => Card(
                              child: ListTile(
                                title: itemDetailButtonList[index].text.color(darkFontGrey).make(),
                                trailing:const Icon(Icons.arrow_forward),
                              ),
                            )),
                          ),
                          20.heightBox,
                          productyoymaylike.text.color(darkFontGrey).fontFamily(semibold).make(),
                          10.heightBox,
                          SingleChildScrollView(
                            physics:const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(6, 
                                (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    5.heightBox,
                                    Image.asset(imgP1,width: 150,fit: BoxFit.cover,),
                                    10.heightBox,
                                    "Lenovo 64Gb".text.size(15).fontFamily(bold).color(redColor).make(),
                                    "\$100".text.size(15).fontFamily(bold).color(redColor).make(),
                                  ],).box.roundedSM.padding(const EdgeInsets.all(10)).white.margin(const EdgeInsets.symmetric(horizontal: 5)).make(),
                                  ),
                              ),
                            ),
                  ]),
                ),
                )
                ),
            10.heightBox,
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(title: "Add To cart",color: redColor,onpress: (){
                controller.addToCart(
                  color: data['p_colors'][controller.colorIndex.value],
                  context: context,
                  img: data['p_imgs'][0],
                  qty: controller.quantity.value,
                  sellerName: data['p_seller'],
                  tPrice: controller.totalPrice.value,
                  title: title,
                );
                VxToast.show(context, msg: "product Added To Cart");
              },txtColor: Colors.white),)
          ]),
      ),
    );
  }
}