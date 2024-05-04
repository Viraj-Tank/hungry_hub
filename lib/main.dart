import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hungry_hub/bindings/initial_bindings.dart';
import 'package:hungry_hub/client/dio_client.dart';
import 'package:hungry_hub/routes/app_routes.dart';
import 'package:hungry_hub/utils/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();
  await Firebase.initializeApp();
  await DioClient.initClient();
  runApp(const HungryHub());
}

class HungryHub extends StatelessWidget {
  const HungryHub({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hungry Hub',
      debugShowCheckedModeBanner: false,
      home: AuthService.handleAuthState(),
      getPages: AppRoutes.routes(),
    );
  }
}
