
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Model/CategoryModel.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {

  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var isFAv = false.obs;

  var subcat = [];
    
    getSubcategory(title)async{
      subcat.clear();
      var data = await rootBundle.loadString("lib/services/Category_model.json");
      var decoded = categoryModelFromJson(data);
      var s = decoded.categories.where((element) => element.name == title).toList();

      for(var e in s[0].subCategories){
        subcat.add(e);
      }
    }

    changecolorIndex(index){
      colorIndex.value = index;
    }

    increasedQuantity(totalQuantity){
      if (quantity.value < totalQuantity) {
        quantity.value++; 
      }
    }
    
    decreasedQuantity(){
      if (quantity.value > 0) {
        quantity.value--; 
      }
    }

    totalprice(price){
      totalPrice.value = price * quantity.value; 
    }

    addToCart({
      title,img,sellerName,color,qty,tPrice,context 
    })async{
      await firestore.collection(cartCollections).doc().set({
        'title' : title,
        'img' : img,
        'sellerName' : sellerName,
        'color' : color,
        'qty' : qty,
        'tPrice' : tPrice,
        'added_by' : currentUser!.uid
      }).catchError((error){
        VxToast.show(context, msg: error.toString());
      });
    }

    //it is for when we move back after addding a product in cart so are all value are reseting
    resetvalue(){
      quantity.value = 0;
      totalPrice.value = 0;
      colorIndex.value = 0;
    }

    addToWishList(docId,context)async{
      await firestore.collection(productsCollections).doc(docId).set({
        'p_wishlist': FieldValue.arrayUnion([currentUser!.uid]),
      },
      SetOptions(merge: true)
      );
      isFAv(true);
       VxToast.show(context, msg: "Added in WishList");
    }

     removeFromWishList(docId,context)async{
      await firestore.collection(productsCollections).doc(docId).set({
        'p_wishlist': FieldValue.arrayRemove([currentUser!.uid]),
      },
      SetOptions(merge: true)
      );
      isFAv(false);
      VxToast.show(context, msg: "Removed from WishList");
    }

    checkIfFav(data){
      if (data['p_wishlist'].contains(currentUser!.uid)) {
          isFAv(true);
      } else {
        isFAv(false);
      }
    }
}