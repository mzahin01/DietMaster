import 'package:diet_master/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class MainPageView extends GetView<MainPageController> {
  const MainPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        floatingActionButton: controller.user.value != null
            ? FloatingActionButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Icon(Icons.logout),
              )
            : null,
        appBar: AppBar(
          title: const Text('Hello'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller.geminiTextController,
                  maxLines: null,
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: controller.pickImage,
                child: const Text('Pick Image from Gallery'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: controller.captureImage,
                child: const Text('Capture Image from Camera'),
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () {
                  controller.getRes();
                },
                color: Colors.amberAccent,
                child: const Text('Generate'),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: controller.images.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Image.file(
                          controller.images[index],
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.delete),
                            color: Colors.white,
                            onPressed: () {
                              controller.images.removeAt(index);
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 50),
              if (controller.user.value == null) ...[
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOG_IN);
                  },
                  child: const Text('Log in'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.REGISTRATION);
                  },
                  child: const Text('Register Now'),
                ),
              ] else
                Text(
                  'Salam,\n ${controller.username.value ?? 'No name found'}',
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
