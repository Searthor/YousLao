import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yous_app/init_routes.dart';
import 'package:yous_app/pages/first_page.dart';
import 'package:get/get.dart';
import 'package:yous_app/states/translate.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Initialize GetStorage
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: FirstPage(),
      theme: ThemeData(primarySwatch: Colors.blue),
      locale: const Locale('la', 'LA'),
      translations: Translate(),
      getPages: initRoute,
      initialRoute: '/splash',
    );
  }
}

