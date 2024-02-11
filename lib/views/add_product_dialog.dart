
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list90/models/product.dart';

class AddProductDialog extends StatefulWidget {
  final Function(Product) addProductCallback;

  const AddProductDialog(this.addProductCallback, {super.key});

  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController orderNoController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: const Text('Add Product'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: idController,
                onChanged: (value) {
                  idController.text = value;
                },
                decoration: const InputDecoration(labelText: 'ID'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: nameController,
                onChanged: (value) {
                  nameController.text = value;
                },
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: priceController,
                onChanged: (value) {
                  priceController.text = value;
                },
                decoration: const InputDecoration(labelText: 'Price'),
              ),
              TextFormField(
                controller: orderNoController,
                onChanged: (value) {
                  orderNoController.text = value;
                },
                decoration: const InputDecoration(labelText: 'Order No'),
              ),
              TextFormField(
                controller: qtyController,
                onChanged: (value) {
                  qtyController.text = value;
                },
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                widget.addProductCallback(Product(
                  int.parse(idController.text),
                  nameController.text,
                  priceController.text,
                  orderNoController.text,
                  int.parse(qtyController.text),
                ));
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
