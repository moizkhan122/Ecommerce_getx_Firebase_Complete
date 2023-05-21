
import 'package:emart_app/consts/consts.dart';

Widget ourButton({String? title, onpress, color, txtColor}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.all(11)
    ),
    onPressed: onpress,
    child: title!.text.color(txtColor).make());
}