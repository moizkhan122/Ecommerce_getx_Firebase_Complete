
import 'package:emart_app/consts/consts.dart';
 
Widget orderStatus({color,title,icon,showDone}){
  return ListTile(
    leading: Icon(icon ,size: 20,color: color,).box.border(color: color).roundedSM.padding(const EdgeInsets.all(5)).make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "$title".text.size(18).color(darkFontGrey).make(),
          showDone? Icon(Icons.done ,size: 18,color: color,):Container(),
        ]),
    ),
  );
}