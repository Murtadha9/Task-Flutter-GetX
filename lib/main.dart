
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list90/controllers/grid_controller.dart';
import 'package:list90/views/grid_view.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final GridController controller = Get.put(GridController());
  runApp(MyApp(controller: controller));
}

class MyApp extends StatelessWidget {
  final GridController controller;

  const MyApp({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Gridview(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Gridview()),
        
         
      ],
    );
  }
}
