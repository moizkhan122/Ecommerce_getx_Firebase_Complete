
import 'package:emart_app/consts/consts.dart';

class FirestoreServices {
  
    static getuser(uid){
      return firestore.collection(userCollections).where('id',isEqualTo: uid).snapshots();
    }

    //get product according t0 category
    static getCategory(category){
      return firestore.collection(productsCollections).where('p_category',isEqualTo: category).snapshots(); 
    }

     //get product according t0 Subcategory
    static getSubcategory(title){
      return firestore.collection(productsCollections).where('p_subCategory',isEqualTo: title).snapshots(); 
    }

    //get cart items
    static getCart(uid){
      return firestore.collection(cartCollections).where('added_by',isEqualTo: uid).snapshots();
    }

    //for delete product from document in cart
    static deleteDocument(docid){
      return firestore.collection(cartCollections).doc(docid).delete();
    }
     //get all my messages
    static getChatMessages(docId){
      return firestore.collection(chatCollections)
      .doc(docId).collection(messageCollections)
      .orderBy('created_on',descending: false)
      .snapshots();
    }

    //get orders
    static getAllOrders(){
      return firestore.collection(orderCollections).where('order_by',isEqualTo: currentUser!.uid).snapshots();
    }

    //get My WishList
    static getWishListProducts(){
      return firestore.collection(productsCollections).where('p_wishlist',arrayContains: currentUser!.uid).snapshots();
    }

    static getAllMessages(){
      return firestore.collection(chatCollections).where('fromId',isEqualTo: currentUser!.uid).snapshots();
    }

    static getCount()async{
      var res =await Future.wait([
        firestore.collection(cartCollections).where('added_by',isEqualTo: currentUser!.uid).get().then((value){
          return value.docs.length;
        }),
          firestore.collection(productsCollections).where('p_wishlist',arrayContains: currentUser!.uid).get().then((value){
             return value.docs.length;
          }),
          firestore.collection(orderCollections).where('order_by',isEqualTo: currentUser!.uid).get().then((value){
            return value.docs.length;
          }),
      ]);
      return res;
    }

    //get all products
    static getAllProducts(){
      return firestore.collection(productsCollections).snapshots();
    }

    //get all featured products
    static getFeaturedProducts(){
      return firestore.collection(productsCollections).where('p_featured',isEqualTo: true).snapshots();
    }
  //note if u are using future builder so u call .get method in firestore data get collection method if
  //u are using stream builder u call .snapshot for it.

  //get all Search products
    static getSearchProducts(title){
      return firestore.collection(productsCollections).get();
    }
}