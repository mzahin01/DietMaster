import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_master/app/shared/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class MainPageController extends GetxController {
  Rx<User?> user = Rx(null);
  RxnString username = RxnString();

  TextEditingController geminiTextController = TextEditingController();
  String? filePath;

  @override
  void onInit() {
    FirebaseAuth.instance.authStateChanges().listen((User? u) {
      user.value = u;
      getUserName(u);
    });
    model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: Helper.gemeniApiKey,
    );
    super.onInit();
  }

  Future<void> getUserName(User? user) async {
    if (user == null) {
      return;
    }
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    username.value = data.data()?['name'];
  }

  GenerativeModel? model;

  final ImagePicker _picker = ImagePicker();
  final RxList<File> images = RxList.empty(growable: true);

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      images.add(File(pickedFile.path));
    }
  }

  Future<void> captureImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      images.add(File(pickedFile.path));
    }
  }

  void getRes() async {
    GenerateContentResponse? res = await model?.generateContent(
      [
        Content.text(
          geminiTextController.text,
        ),
        if (images.isNotEmpty)
          for (File image in images)
            Content.data('image/jpg', image.readAsBytesSync()),
      ],
    );
    if (res?.text != null) {
      Get.dialog(
        AlertDialog(
          title: const Text('Gemini Response'),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Text(
                res!.text!,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Close'),
            ),
          ],
        ),
        barrierDismissible: false,
      );
    } else {
      return null;
    }
  }
}
