
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

    //for circuler indicator progress bar
    var isloading = false.obs;

    //edit controller for login Screen
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
  
    //user login method
    Future<UserCredential?> loginMethod({context})async{
      UserCredential? userCredential;

      try {
        userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, 
          password: passwordController.text
          );
      } on FirebaseAuthException catch (e) {
        VxToast.show(context, msg: e.toString());
      }
      return userCredential;
    }

    //user Sign up method
    Future<UserCredential?> signUpMethod({email,password,context})async{
      UserCredential? userCredential;

      try {
        await auth.createUserWithEmailAndPassword(
          email: email, 
          password: password
          );
      } on FirebaseAuthException catch (e) {
        VxToast.show(context, msg: e.toString());
      }
      return userCredential;
    }

    //Storing User Data
    storeUserData({name,password,email})async{ 
      DocumentReference store =  firestore.collection(userCollections).doc(currentUser!.uid);
      store.set({
        'id' : currentUser!.uid,
        'name':name,
        'password':password,
        'email':email,
        'imgUrl':'',
        'cart_count':'00',
        'wishlist_count':'00',
        'order_count':'00',
      });
    } 

    //SignOut method
    signOut(context)async{
      try {
        await auth.signOut();
      } catch (e) {
       VxToast.show(context, msg: e.toString());
      }
    }
}