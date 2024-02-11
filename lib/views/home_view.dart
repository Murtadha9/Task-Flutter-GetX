
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list90/controllers/grid_controller.dart';

class HomeView extends StatelessWidget {
  final GridController controller = Get.put(GridController());

   HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataGrid'),
        centerTitle: true,
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            Get.toNamed('/grid');
          },
          color: Colors.greenAccent,
          elevation: 5.0,
          height: 60.0,
          minWidth: 200.0,
          padding: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: const Text(
            'Click Here',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
