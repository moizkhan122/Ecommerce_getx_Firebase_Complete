
import 'package:emart_app/consts/consts.dart';

class FirestoreServices {
  
    static getuser(uid){
      return firestore.collection(userCollections).where('id',isEqualTo: uid).snapshots();
    }

    //get product according t0 category
    static getCategory(category){
      return firestore.collection(productsCollections).where('p_category',isEqualTo: category).snapshots(); 
    }

    //get cart items
    static getCart(uid){
      return firestore.collection(cartCollections).where('added_by',isEqualTo: uid).snapshots();
    }

    //for delete product from document in cart
    static deleteDocument(docid){
      return firestore.collection(cartCollections).doc(docid).delete();
    }
}