
import 'package:get/get.dart';

class CartController extends GetxController {
  
    var totalprice = 0.obs;

    calculateTotal(data){
      totalprice.value = 0;
      for (var i = 0; i < data.length; i++) {
        totalprice.value = totalprice.value + int.parse(data[i]["tPrice"].toString());
      }
    }
}