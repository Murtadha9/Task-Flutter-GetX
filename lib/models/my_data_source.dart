import 'package:get/get.dart';
import 'package:list90/models/product.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MyDataSource extends DataGridSource {
  final BuildContext context;
  final List<Product> productList;

  MyDataSource(this.productList, this.context) {
    _updateDataGridRows();
  }

  List<DataGridRow> _dataGridRows = <DataGridRow>[];

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return InkWell(
          onTap: () {
            _showEditDialog(context, dataGridCell.value.toString(), (String value) {
              int rowIndex = _dataGridRows.indexOf(row);
              _updateDataSource(rowIndex, dataGridCell.columnName, value);
            });
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(dataGridCell.value.toString()),
          ),
        );
      }).toList(),
    );
  }

  Future<void> _showEditDialog(BuildContext context, String initialValue, ValueChanged<String> onSubmitted) async {
    TextEditingController controller = TextEditingController(text: initialValue);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit '),
          content: TextField(
            controller: controller,
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
                onSubmitted(controller.text);
                Get.back();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _updateDataGridRows() {
    _dataGridRows = productList.map<DataGridRow>((Product product) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: product.id),
        DataGridCell<String>(columnName: 'name', value: product.name),
        DataGridCell<String>(columnName: 'price', value: product.price),
        DataGridCell<String>(columnName: 'orderNo', value: product.orderNo),
        DataGridCell<int>(columnName: 'qty', value: product.qty),
      ]);
    }).toList();
  }

  void _updateDataSource(int rowIndex, String columnName, String value) {
    if (columnName == 'name') {
      productList[rowIndex].name = value;
    } else if (columnName == 'price') {
      productList[rowIndex].price = value;
    } else if (columnName == 'orderNo') {
      productList[rowIndex].orderNo = value;
    } else if (columnName == 'qty') {
      productList[rowIndex].qty = int.tryParse(value) ?? 0;
    }

    _updateDataGridRows(); 

    notifyListeners();
  }
}
