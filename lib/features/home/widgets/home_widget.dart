import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Obx(() => Text('Counter: ${controller.counter}'));
  }
}