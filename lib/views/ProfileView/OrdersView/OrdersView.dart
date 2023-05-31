import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Widgets/loadingIndicator.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firebaseServices/firestoreServices/firestoreServices.dart';
import 'package:emart_app/views/ProfileView/OrdersView/OrderDetails/OrderDetails.dart';
import 'package:get/get.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: "My Orders".text.size(20).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
              return Center( child: loadingIndicator());
          } else if(snapshot.data!.docs.isEmpty){
              return Center(child: "No Orders yet!".text.size(20).color(darkFontGrey).make(),);
          }else{
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder:(context, index) {
                  return ListTile(
                    leading: "${index+1}".text.size(20).color(darkFontGrey).fontFamily(bold).make(),
                    title : "${data[index]['order_code']}".text.size(18).color(darkFontGrey).make(),
                    subtitle : "${data[index]['total_Ammount']}".text.size(18).color(darkFontGrey).make(),
                    trailing: IconButton(
                      onPressed: (){
                        Get.to(()=> OrderDetailsView(data: data[index]));
                      }, 
                      icon:const Icon(Icons.arrow_forward_ios,size: 18,color: darkFontGrey,)),
                  );
              }, );
          }
      },),
    );
  }
}