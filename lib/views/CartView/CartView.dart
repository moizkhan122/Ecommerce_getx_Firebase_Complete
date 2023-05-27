import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Controller/CartController/CartController.dart';
import 'package:emart_app/Widgets/loadingIndicator.dart';
import 'package:emart_app/Widgets/ourButton.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firebaseServices/firestoreServices/firestoreServices.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(color: redColor,onpress: (){},
        title: "Proceed To checkout",txtColor: whiteColor,)),
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: "My Cart".text.size(20).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: loadingIndicator());
          } else if(snapshot.data!.docs.isEmpty){
              return "Cart is Empty".text.size(25).color(darkFontGrey).make();
          }else{
            var data = snapshot.data!.docs;
            controller.calculateTotal(data);
            return Padding(
        padding:const EdgeInsets.all(12),
        child: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.network("${data[index]['img']}"),
                    title: "${data[index]['title']} (x${data[index]['qty']})".text.make(),
                    subtitle: "${data[index]['tPrice']}".text.make(),
                    trailing: IconButton(
                      onPressed: (){
                        //deleting product from ducment
                        FirestoreServices.deleteDocument(data[index].id);
                      }, 
                      icon:const Icon(Icons.delete,color: redColor,)),
                  ),
                );
              },)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Total price".text.color(darkFontGrey).size(18).make(),
                Obx(
                  ()=> "${controller.totalprice.value}".numCurrency.text.color(darkFontGrey).size(18).make()),
              ],
            ).box.padding(const EdgeInsets.all(12)).color(golden).make(),
            10.heightBox,
           
        ],)
        );
          }
      },)
    );
  }
}