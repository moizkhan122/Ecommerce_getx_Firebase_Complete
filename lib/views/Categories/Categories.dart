import 'package:emart_app/Controller/ProductController/ProductController.dart';
import 'package:emart_app/Widgets/Bg_Widget.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/views/Categories/CategoriesDetails.dart';
import 'package:get/get.dart';

class CategoriesView extends StatelessWidget {
   CategoriesView({super.key});

  var controller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: categories.text.white.make(),),
          body: Container(
            padding:const EdgeInsets.all(12),
            child: GridView.builder(
                      physics:const NeverScrollableScrollPhysics(),
                      itemCount: 9,
                      shrinkWrap: true,
                      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 8,
                        mainAxisExtent: 200,
                        mainAxisSpacing: 8,
                        crossAxisCount: 3),
                         itemBuilder: (context, index) {
                           return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(categoriesImgs[index],height: 100,width: 200,fit: BoxFit.cover,),
                                  10.heightBox,
                                  categoriesList[index].text.color(darkFontGrey).align(TextAlign.center).make()
                                ],).box.roundedSM.outerShadowSm.padding(const EdgeInsets.all(15)).white.make().onTap(() {
                                  controller.getSubcategory(categoriesList[index]);
                                  Get.to(()=> CategoriesDetails(title: categoriesList[index]));
                                });
                         },),
          ),
      ),
    );
  }
}