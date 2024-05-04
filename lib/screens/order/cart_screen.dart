import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hungry_hub/controller/home_controller.dart';
import 'package:hungry_hub/utils/constant/string_constants.dart';
import 'package:hungry_hub/widgets/sized_boxes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(StringConstants.orderSummary),
      ),
      body: Obx(() => Column(
            children: [
              Expanded(
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color(0xff0f3923),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          '${controller.cartItems.length} Dishes - ${controller.cartItems.fold<double>(0, (previousValue, item) => previousValue + item.mealCount).toInt()} Items',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (_, index) {
                            final meal = controller.cartItems[index];
                            return ListTile(
                              title: Text(
                                meal.mealName,
                                style: const TextStyle(fontSize: 17),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('INR ${meal.mealPrice}'),
                                  const Text('15 Calories'),
                                ],
                              ),
                              trailing: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xff0f3923),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () => controller.decreaseMealCount(meal, isFromCart: true),
                                      icon: const Icon(Icons.remove, color: Colors.white),
                                      iconSize: 18,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        '${meal.mealCount}',
                                        style: const TextStyle(color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => controller.increaseMealCount(meal, isFromCart: true),
                                      icon: const Icon(Icons.add, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: controller.cartItems.length,
                          shrinkWrap: true,
                          separatorBuilder: (_, __) => const Divider(),
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text(
                          StringConstants.totalAmount,
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        trailing: Text(
                          'INR ${controller.getCartItemsTotalPrice}',
                          style: const TextStyle(fontSize: 17, color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _placeOrderButton(controller),
              gapH16,
            ],
          )),
    );
  }

  _placeOrderButton(HomeController controller) {
    return GestureDetector(
      onTap: controller.confirmPlaceOrder,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: const Color(0xff0f3923),
          borderRadius: BorderRadius.circular(32.0),
        ),
        child: const Center(
          child: Text(
            StringConstants.placeOrder,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
