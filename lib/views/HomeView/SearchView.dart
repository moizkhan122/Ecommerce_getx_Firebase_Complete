import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Widgets/loadingIndicator.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firebaseServices/firestoreServices/firestoreServices.dart';
import 'package:emart_app/views/Categories/Item_Details.dart';
import 'package:get/get.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key,this.titlee});

  final String? titlee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(title: titlee?.text.size(20).color(darkFontGrey).make()),
      body: FutureBuilder(
        future: FirestoreServices.getSearchProducts(titlee),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: loadingIndicator(),);
        } else if(snapshot.data!.docs.isEmpty){
          return Center(child: "No Search Results Found".text.color(darkFontGrey).size(20).make(),);
        }else{
          var data = snapshot.data!.docs;
          //filter products and show on search screen view
          var filterProducts = data.where((element) => element['p_name'].toString()
          .toLowerCase().contains(titlee!.toLowerCase()),)
          .toList();
          
          return GridView(
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 300,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 8,
                        crossAxisCount: 2),
                        children: filterProducts.mapIndexed(
                          (currentValue, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  5.heightBox,
                                  Image.network(
                                    filterProducts[index]['p_imgs'][1],
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,),
                                  const Spacer(),
                                  "${filterProducts[index]['p_name']}".text.size(15).fontFamily(bold).color(redColor).make(),
                                  10.heightBox,
                                  "${filterProducts[index]['p_price']}".text.size(15).fontFamily(bold).color(redColor).make(),
                                ],).box.roundedSM.shadowMd.padding(const EdgeInsets.all(15)).white.make().onTap(() {
                                  Get.to(
                                    ItemDetails(
                                      title: "${filterProducts[index]['p_name']}",data: filterProducts[index],));
                                }))
                          .toList(),
            );
        }
      },),
    );
  }
}