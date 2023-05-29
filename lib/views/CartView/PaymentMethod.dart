import 'package:emart_app/Controller/CartController/CartController.dart';
import 'package:emart_app/Widgets/loadingIndicator.dart';
import 'package:emart_app/Widgets/ourButton.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/views/HomeView/HomeView.dart';
import 'package:emart_app/views/HomeView/Homee.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: "Make payment Method".text.size(20).color(Colors.black).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(
          ()=> Column(
            children: List.generate(paymentMethodImg.length, 
            (index) => GestureDetector(
              onTap: (){
                controller.changePaymentIndex(index);
              },
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    style: BorderStyle.solid,
                     color: controller.paymentIndex.value == index ? redColor : Colors.transparent,
                     width: 5
                  )
                ),
                margin:const EdgeInsets.only(bottom: 8),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.asset(paymentMethodImg[index],fit: BoxFit.cover,height: 120,width: double.infinity,
                    colorBlendMode:controller.paymentIndex.value == index ? BlendMode.darken : BlendMode.color,
                    color:controller.paymentIndex.value == index ? Colors.black.withOpacity(0.4):Colors.transparent,
                    ),
                     controller.paymentIndex.value == index ? Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        activeColor: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        value: true, 
                        onChanged: (value) {
                          
                        },),
                    ): Container(),
                    Positioned(
                      bottom: 10,
                      right: 5,
                      child: paymentMethods[index].text.white.size(18).make()),
                  ],
                ),
              ),
            )),
          ),
        ),
      ),
      bottomNavigationBar: controller.placingOrder.value ? Center(child: loadingIndicator(),)
      : ourButton(
        color: redColor,
        onpress: ()async{
          await controller.placedMyOrder(
            orderPaymentMethod: paymentMethods[controller.paymentIndex.value], 
            totalAmount: controller.totalprice);
            await controller.clearCart();
            // ignore: use_build_context_synchronously
            VxToast.show(context, msg: "ordered PLaced");
            Get.offAll(const Homee());
        },
        title: "Place my order",
        txtColor: whiteColor
      ),
    );
  }
}