
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Controller/HomeController/HomeController.dart';
import 'package:emart_app/Widgets/HomeButton.dart';
import 'package:emart_app/Widgets/featuredButton.dart';
import 'package:emart_app/Widgets/loadingIndicator.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/services/firebaseServices/firestoreServices/firestoreServices.dart';
import 'package:emart_app/views/Categories/Item_Details.dart';
import 'package:emart_app/views/HomeView/SearchView.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Container(
      padding:const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchController,
                decoration:  InputDecoration(
                  border: InputBorder.none,
                  suffixIcon:const Icon(Icons.search,color: Colors.grey,)
                  .onTap(() {
                    if (controller.searchController.text.isNotEmptyAndNotNull) {
                      Get.to(()=> SearchView(titlee: controller.searchController.text,));
                    }
                   }),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchEverything,
                  hintStyle: TextStyle(color:textfieldGrey)
                ),
              ),),
              Expanded(
                child: SingleChildScrollView(
                  physics:const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      5.heightBox,
                  VxSwiper.builder(
                    aspectRatio: 16/9,
                    autoPlay: true,
                    height: 150,
                    enlargeCenterPage: true,
                    itemCount: sliderList.length, 
                    itemBuilder: (context, index){
                      return Image.asset(sliderList[index],fit: BoxFit.cover,).box.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).rounded.make();
                    },),
                    8.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(2, (index) => homeButton(
                        height: context.screenHeight * 0.15,
                        width: context.screenWidth / 2.5,
                        title: index == 0 ? todayDeal : flashsale,
                        icon: index == 0 ? icTodaysDeal :icFlashDeal
                      ))),
                       10.heightBox,
                  VxSwiper.builder(
                    aspectRatio: 16/9,
                    autoPlay: true,
                    height: 150,
                    enlargeCenterPage: true,
                    itemCount: slider2List.length, 
                    itemBuilder: (context, index){
                      return Image.asset(slider2List[index],fit: BoxFit.cover,).box.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).rounded.make();
                    },),
                    8.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(3, (index) => homeButton(
                        height: context.screenHeight * 0.15,
                        width: context.screenWidth / 3.5,
                        title: index == 0 ? topcategories : index == 1 ? brands : topseller,
                        icon: index == 0 ? icCategories : index == 1 ? icBrands : icTopSeller,
                      ))),
                      5.heightBox,
                      Align(
                        alignment: Alignment.topLeft,
                        child: featuredcategories.text.size(18).color(darkFontGrey).fontFamily(semibold).make()),
                      10.heightBox,

                      //featured categories
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics:const BouncingScrollPhysics(),
                        child: Row(
                          children: List.generate(3, 
                          (index) => Column(
                            children: [
                              featuredButton(
                                title: featuredtitleList1[index],
                                icon: featuredImgList1[index],
                              ),
                              5.heightBox,
                              featuredButton(
                                title: featuredtitleList2[index],
                                icon: featuredImgList2[index]
                              )
                            ],)
                            ).toList(),
                        ),
                      ),
                      //featured products
                      20.heightBox,
                      Container(
                        width: double.infinity,
                        padding:const EdgeInsets.all(14),
                        decoration:const BoxDecoration(color: redColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          featuredProducts.text.size(18).fontFamily(semibold).white.make(),
                          7.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: StreamBuilder(
                              stream: FirestoreServices.getFeaturedProducts(),
                              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(child: loadingIndicator(),);
                                } else if(snapshot.data!.docs.isEmpty) {
                                  return Center(child: "No featured Products Here".text.size(20).color(darkFontGrey).make(),);
                                }
                                else{
                                  var featuredPro = snapshot.data!.docs;
                                  return Row(
                              children: List.generate(featuredPro.length, 
                              (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  5.heightBox,
                                  Image.network(
                                    featuredPro[index]['p_imgs'][0],
                                    width: 150,fit: BoxFit.cover,),
                                  10.heightBox,
                                  "${featuredPro[index]['p_name']}".text.size(15).fontFamily(bold).color(redColor).make(),
                                  "${featuredPro[index]['p_price']}".text.size(15).fontFamily(bold).color(redColor).make(),
                                ],).box.roundedSM.padding(const EdgeInsets.all(10)).white.margin(const EdgeInsets.symmetric(horizontal: 5)).make().onTap(() {
                                   Get.to(
                                    ItemDetails(
                                      title: "${featuredPro[index]['p_name']}",data: featuredPro[index],));
                                }),
                                ),
                            );
                                }
                            },)
                          ),
                          
                        ]),
                      ),
                      10.heightBox,
                       VxSwiper.builder(
                    aspectRatio: 16/9,
                    autoPlay: true,
                    height: 150,
                    enlargeCenterPage: true,
                    itemCount: slider2List.length, 
                    itemBuilder: (context, index){
                      return Image.asset(slider2List[index],fit: BoxFit.cover,).box.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).rounded.make();
                    },),
                    20.heightBox,
                    StreamBuilder(
                      stream: FirestoreServices.getAllProducts(),
                            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(child: loadingIndicator(),);
                              } else if(snapshot.data!.docs.isEmpty){
                                  return Center(child: "No Products here".text.size(20).color(darkFontGrey).make());
                              }else{

                        var allProducts = snapshot.data!.docs;
                      return GridView.builder(
                      physics:const NeverScrollableScrollPhysics(),
                      itemCount: allProducts.length,
                      shrinkWrap: true,
                      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 300,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 8,
                        crossAxisCount: 2),
                         itemBuilder: (context, index) {
                           return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  5.heightBox,
                                  Image.network(
                                    allProducts[index]['p_imgs'][1],
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,),
                                  const Spacer(),
                                  "${allProducts[index]['p_name']}".text.size(15).fontFamily(bold).color(redColor).make(),
                                  10.heightBox,
                                  "${allProducts[index]['p_price']}".text.size(15).fontFamily(bold).color(redColor).make(),
                                ],).box.roundedSM.padding(const EdgeInsets.all(15)).white.make().onTap(() {
                                  Get.to(
                                    ItemDetails(
                                      title: "${allProducts[index]['p_name']}",data: allProducts[index],));
                                });
                         },);
                    }
                    }
                    )
                    ],),
                ),
              )
          ]),
      ),
    );
  }
}

/**stream: FirestoreServices.getAllProducts(),
                            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(child: loadingIndicator(),);
                              } else if(snapshot.data!.docs.isEmpty){
                                  return Center(child: "No Products here".text.size(20).color(darkFontGrey).make());
                              }else{ */