import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Widgets/loadingIndicator.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firebaseServices/firestoreServices/firestoreServices.dart';

class WishListView extends StatelessWidget {
  const WishListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: "My WishList".text.size(20).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishListProducts(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
              return Center( child: loadingIndicator());
          } else if(snapshot.data!.docs.isEmpty){
              return Center(child: "No Message yet!".text.size(20).color(darkFontGrey).make(),);
          }else{
            var data = snapshot.data!.docs;
            return Padding(
        padding:const EdgeInsets.all(12),
        child: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.network("${data[index]['p_imgs'][0]}",width: 80,fit: BoxFit.cover,),
                    title: "${data[index]['p_name']} (x${data[index]['p_quantity']})".text.make(),
                    subtitle: "${data[index]['p_price']}".text.make(),
                    trailing: IconButton(
                      onPressed: ()async{
                        //deleting product from wishlist screen
                         await firestore.collection(productsCollections).doc(data[index].id).set({
                          'p_wishlist':FieldValue.arrayRemove([currentUser!.uid]),
                         },SetOptions(merge: true),
                         );
                      }, 
                      icon:const Icon(Icons.favorite,color: redColor,)),
                  ),
                );
              },)
            ),
            10.heightBox,
           
        ],)
        );
 
          }
      },),
    );
  }
}