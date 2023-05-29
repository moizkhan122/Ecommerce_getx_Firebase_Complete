
import 'package:emart_app/Controller/CartController/CartController.dart';
import 'package:emart_app/Widgets/customTextField_Widget.dart';
import 'package:emart_app/Widgets/ourButton.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/CartView/PaymentMethod.dart';
import 'package:get/get.dart';

class ShippinView extends StatelessWidget {
  const ShippinView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: "Shipping Details".text.size(20).color(Colors.black).make(),
      ),
      body: Form(child: Builder(
        builder: (context) {
        return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            customTextField(titleHint: "Address",ispass: false,title: "Address",controller: controller.addressController),
            customTextField(titleHint: "City",ispass: false,title: "City",controller: controller.cityController),
            customTextField(titleHint: "State",ispass: false,title: "State",controller: controller.stateController),
            customTextField(titleHint: "postal Code",ispass: false,title: "postal Code",controller: controller.postalController),
            customTextField(titleHint: "Phone",ispass: false,title: "Phone",controller: controller.phoneController),
          ]),
      );
      },)),
      bottomNavigationBar: ourButton(
        color: redColor,
        onpress: (){
          if (controller.addressController.text.length>10 ||
              controller.cityController.text.length>5 ||
              controller.stateController.text.length>5 ||
              controller.postalController.text.length>5 ||
              controller.phoneController.text.length>10
              ) {
                Get.to(const PaymentMethod());
          }else{
            VxToast.show(context, msg: "Please Fill the Form");
          }
        },
        title: "Continue",
        txtColor: whiteColor
      ),
    );
  }
}