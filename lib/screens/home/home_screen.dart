import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hungry_hub/routes/app_routes.dart';
import 'package:hungry_hub/utils/constant/string_constants.dart';

import '../../controller/auth_controller.dart';
import '../../controller/home_controller.dart';
import '../../widgets/sized_boxes.dart';
import 'meal_tabs.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _buildCartButton(),
        ],
      ),
      drawer: _buildDrawer(),
      body: FutureBuilder(
        future: controller.fetchMealCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else {
            return MealTabs(categories: snapshot.data!);
          }
        },
      ),
    );
  }

  _buildCartButton() {
    return Obx(
      () => Stack(
        children: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            iconSize: 32,
            onPressed: () => Get.toNamed(AppRoutes.order),
          ),
          if (controller.cartItems.isNotEmpty)
            Positioned(
              right: 5,
              top: 5,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                ),
                child: Text(
                  '${controller.cartItems.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: CachedNetworkImageProvider('${FirebaseAuth.instance.currentUser?.photoURL}'),
                ),
                gapH8,
                Text(
                  '${FirebaseAuth.instance.currentUser?.displayName}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  '${FirebaseAuth.instance.currentUser?.uid}',
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(StringConstants.signOut),
            onTap: Get.find<AuthController>().signOut,
          ),
        ],
      ),
    );
  }
}
