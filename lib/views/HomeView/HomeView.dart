
import 'package:emart_app/Widgets/HomeButton.dart';
import 'package:emart_app/Widgets/featuredButton.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search,color: Colors.grey,),
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
                    GridView.builder(
                      physics:const NeverScrollableScrollPhysics(),
                      itemCount: 6,
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
                                  Image.asset(
                                    imgP5,
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,),
                                  const Spacer(),
                                  "Lenovo 64Gb".text.size(15).fontFamily(bold).color(redColor).make(),
                                  10.heightBox,
                                  "\$100".text.size(15).fontFamily(bold).color(redColor).make(),
                                ],).box.roundedSM.padding(const EdgeInsets.all(15)).white.make();
                         },)
                    ],),
                ),
              )
          ]),
      ),
    );
  }
}