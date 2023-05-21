
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  
  @override
  void onInit() {
    getusername();
    super.onInit();
  }
  var currentNavbarIndex = 0.obs;

  var username = ''.obs;

  getusername()async{
    var n = await firestore.collection(userCollections).where('id',isEqualTo: currentUser!.uid).get().then((value){
      if (value.docs.isNotEmpty) {
          return value.docs.single['name'];
      }
    });
    username.value = n;
  }
}