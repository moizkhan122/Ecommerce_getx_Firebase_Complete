
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Controller/ProductController/ProductController.dart';
import 'package:emart_app/Widgets/Bg_Widget.dart';
import 'package:emart_app/Widgets/loadingIndicator.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firebaseServices/firestoreServices/firestoreServices.dart';
import 'package:emart_app/views/Categories/Item_Details.dart';
import 'package:get/get.dart';

class CategoriesDetails extends StatelessWidget {
 CategoriesDetails({super.key, required this.title});

  var controller = Get.find<ProductController>();
  final String title;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
       appBar: AppBar(
          title: title.text.white.make(),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getCategory(title),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            }
            else if(snapshot.data!.docs.isEmpty){
              return  Center(child: "No data Found".text.color(darkFontGrey).size(20).make(), 
              );
            }
            else{
              var data = snapshot.data!.docs;
              return Container(
          padding:const EdgeInsets.all(12),
          child: Column(
            children: [
              SingleChildScrollView(
                physics:const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    controller.subcat.length, 
                    (index) => "${controller.subcat[index]}".text.color(darkFontGrey).makeCentered().box.size(120, 55).rounded.margin(const EdgeInsets.symmetric(horizontal: 5)).white.make()
                    ),
                    ),
              ),
              20.heightBox,
              Expanded(
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                    physics:const BouncingScrollPhysics(),
                    itemCount: data.length,
                    shrinkWrap: true,
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 8,
                      mainAxisExtent: 250,
                      mainAxisSpacing: 8,
                      crossAxisCount: 2),
                       itemBuilder: (context, index) {
                         return  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                5.heightBox,
                                Image.network(
                                  data[index]['p_imgs'][0],
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.cover,),
                                "${data[index]['p_name']}".text.size(15).fontFamily(bold).color(redColor).make(),
                                10.heightBox,
                                "${data[index]['p_price']}".numCurrency.text.size(15).fontFamily(bold).color(redColor).make(),
                              ],).box.roundedSM.shadowSm.padding(const EdgeInsets.all(15)).white.make().onTap(() {
                                controller.checkIfFav(data[index]);
                                Get.to(ItemDetails(title: "${data[index]['p_name']}",data: data[index],));
                              });
                       },),
              )
            ]),
        );
            }
          },)
      ),
    );
  }
}