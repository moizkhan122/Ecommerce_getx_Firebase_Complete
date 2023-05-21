
import 'package:emart_app/consts/consts.dart';

Widget customTextField({String? title,String? titleHint,controller,ispass}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(redColor).fontFamily(semibold).size(20).make(),
      5.heightBox,
      TextFormField(
        obscureText: ispass,
        controller: controller,
        decoration:  InputDecoration(
          isDense: true,//for short textfield,
          hintText: titleHint,
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: textfieldGrey
          ),
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: redColor)
          )
        ),
      ),
      5.heightBox,
    ],);
}