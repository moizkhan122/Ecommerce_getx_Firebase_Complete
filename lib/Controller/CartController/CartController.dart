
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Controller/HomeController/HomeController.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  
    var addressController = TextEditingController();
    var cityController = TextEditingController();
    var stateController = TextEditingController();
    var postalController = TextEditingController();
    var phoneController = TextEditingController();

    var totalprice = 0.obs;

    var paymentIndex = 0.obs;

    late dynamic productSnapshot;

    var products = [];
    var placingOrder = false.obs; 

    calculateTotal(data){
      totalprice.value = 0;
      for (var i = 0; i < data.length; i++) {
        totalprice.value = totalprice.value + int.parse(data[i]["tPrice"].toString());
      }
    }

    changePaymentIndex(index){
      paymentIndex.value = index;
    }

    placedMyOrder({required orderPaymentMethod,required totalAmount})async{
      placingOrder(true);
      await getproductDetails();
      await firestore.collection(orderCollections).doc().set({
        'order_code' : '12345678',
        'order_date' : FieldValue.serverTimestamp(),
        'order_by' : currentUser!.uid,
        'order_by_name' : Get.find<HomeController>().username.value,
        'order_by_email' : currentUser!.email,
        'order_by_address' : addressController.text,
        'order_by_state' : stateController.text,
        'order_by_city' : cityController.text,
        'order_by_phone' : phoneController.text,
        'order_by_PostalCode' : postalController.text,
        'shipping_method' : 'Home Delivery',
        'payment_method' : orderPaymentMethod,
        'order_place' : true,
        'order_confirmed': false,
        'order_delivered' : false,
        'order_on_delivery' : false,
        'total_Ammount' : totalprice.value,
        'orders' : FieldValue.arrayUnion(products)
      });
      placingOrder(false);
    }

    //it will get the products details end pass in placeOrder method for data
    getproductDetails(){
      products.clear();
      for (var i = 0; i < productSnapshot.length; i++) {
        products.add({
          'color' : productSnapshot[i]['color'],
          'img' : productSnapshot[i]['img'],
          'qty' : productSnapshot[i]['qty'],
          'title' : productSnapshot[i]['title'],
          'venderId' : productSnapshot[i]['vender_id'],
          'tPrice' : productSnapshot[i]['tPrice']
        });
      }
    }

    clearCart(){
      for (var i = 0; i < productSnapshot.length; i++) {
        firestore.collection(cartCollections).doc(productSnapshot[i].id).delete();
      }
    }
}