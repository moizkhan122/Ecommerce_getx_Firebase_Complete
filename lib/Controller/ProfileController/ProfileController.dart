
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImgPath = ''.obs;
  var isLoading = false.obs;
  var profileImagelink = '';

  var namecontroller = TextEditingController();
  var oldpasscontroller = TextEditingController();
  var newpasscontroller = TextEditingController();

  changeImage(context)async{
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70);
      if(img == null) return;
      profileImgPath.value = img.path;
    }on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
  //upload profile image on firebase storage
  uploadprofileImage()async{
    var filename = basename(profileImgPath.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImagelink = await ref.getDownloadURL();
  }

  //update profile
  updateProfile({name,password,imgUrl})async{
    var store = firestore.collection(userCollections).doc(currentUser!.uid);
    await store.set({
      'name':name,
      'password':password,
      'imgUrl' : imgUrl,
    },SetOptions(merge: true)
    );
    isLoading(false);
  }

  //updated new password in authentication
  changedAuthPassword({email,password,newpassword})async{
    final cred = EmailAuthProvider.credential(email: email, password: password);

    await currentUser!.reauthenticateWithCredential(cred).then((value){
      currentUser!.updatePassword(newpassword);
    }).catchError((error){
      print(error.toString());
    });
  }
}