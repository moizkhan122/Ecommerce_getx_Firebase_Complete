import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/ProfileView/OrdersView/OrderDetails/components/orderDetails.dart';
import 'package:emart_app/views/ProfileView/OrdersView/OrderDetails/components/orderStatus.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetailsView extends StatelessWidget {
   OrderDetailsView({super.key,required this.data});

  dynamic data;
  @override
  Widget build(BuildContext context) {
    var t = data['order_date'] == null ? DateTime.now() : data['order_date'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: "My order Details".text.size(20).color(darkFontGrey).make(),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(color: Colors.red,icon: Icons.done,title: "Placed",showDone: data['order_place']),
              orderStatus(color: Colors.blue,icon: Icons.thumb_up_alt_sharp,title: "confirmed",showDone: data['order_confirmed']),
              orderStatus(color: Colors.yellow,icon: Icons.car_crash,title: "delivered",showDone: data['order_delivered']),
              orderStatus(color: Colors.purple,icon: Icons.done_all_rounded,title: "on delivered",showDone: data['order_on_delivery']),
        
              const Divider(color: darkFontGrey,),
              Column(children: [
                orderDetails(title1: "Order Code",titleValue1: data['order_code'],title2: "Shipping Method",titleValue2: data['shipping_method']),
              5.heightBox,
              orderDetails(title1: "Order Date",titleValue1: time,title2: "payment method",titleValue2: data['payment_method']),
              5.heightBox,
              orderDetails(title1: "payment Status",titleValue1: "Un Send",title2: "Delievery Status",titleValue2: "Order Placed"),
            10.heightBox,
              completeAdressWithAmount(
                adr1: data['order_by_name'],
                adr2: data['order_by_phone'],
                adr3: data['order_by_email'],
                adr4: data['order_by_state'],
                adr5: data['order_by_address'],
                adr6: data['order_by_city'],
                adr7: data['order_by_state'],
                totalAmount: data['total_Ammount']
                ),
            ],).box.padding(EdgeInsets.all(15)).color(whiteColor).shadowMd.make(),
            7.heightBox,
            "Ordered Product".text.size(20).make(),
            10.heightBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics:const BouncingScrollPhysics(),
                  itemCount: data['orders'].length,
                  itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            "${data['orders'][index]['title']}".text.size(16).make(),
                            "x${data['orders'][index]['qty']}".text.color(redColor).size(15).make(),
                            Image.network(data['orders'][index]['img'],height: 50,width: 80,),
                          ],),
                          Column(
                          children: [
                            "${data['orders'][index]['tPrice']}".text.size(16).make(),
                            "Not Refundable".text.color(redColor).size(15).make(),
                          ],),
                      ],),
                  );
                },),
              )
            ]).box.height(200).padding(const EdgeInsets.all(15)).color(whiteColor).shadowMd.make(),
            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  "Sub Total".text.size(18).color(darkFontGrey).make(),
                  5.heightBox,
                  "Tax".text.size(18).color(darkFontGrey).make(),
                   5.heightBox,
                   "Shipping Cost".text.size(18).color(darkFontGrey).make(),
                    5.heightBox,
                    "Discount".text.size(18).color(darkFontGrey).make(),
                    const Divider(color: darkFontGrey,thickness: 15),
                    "Grand Total".text.size(18).color(darkFontGrey).make(),
                ]),
                100.widthBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                     "Rs: ${data['total_Ammount']}".text.size(18).color(darkFontGrey).make(),
                     5.heightBox,
                      "0%".text.size(18).color(darkFontGrey).make(),
                      5.heightBox,
                      "0%".text.size(18).color(darkFontGrey).make(),
                       5.heightBox,
                       "0%".text.size(18).color(darkFontGrey).make(),
                       const Divider(color: darkFontGrey,thickness: 15),
                        "Rs: ${data['total_Ammount']}".text.size(18).color(redColor).make(),
                  ],)
              ],),
              20.heightBox
            ],
          ),
        ),
      ),
    );
  }
}