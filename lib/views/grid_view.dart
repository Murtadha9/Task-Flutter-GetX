
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list90/controllers/grid_controller.dart';
import 'package:list90/models/product.dart';
import 'package:list90/views/add_product_dialog.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:list90/models/my_data_source.dart';

class Gridview extends StatelessWidget {
  final GridController controller = Get.put(GridController());

  Gridview({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Receipt'),
        backgroundColor: Colors.greenAccent[100],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 800,
                  height: 500,
                  padding: Platform.isAndroid
                      ? const EdgeInsets.all(1)
                      : const EdgeInsets.all(5),
                  margin: Platform.isAndroid
                      ? const EdgeInsets.all(10)
                      : const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 5),
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    child: Obx(
                      () => SfDataGridTheme(
                        data: SfDataGridThemeData(
                          gridLineColor: Colors.black,
                          gridLineStrokeWidth: 1.0,
                          headerColor: Colors.greenAccent,
                          headerHoverColor: Colors.blueAccent[100],
                          rowHoverColor: Colors.greenAccent[100],
                        ),
                        child: SfDataGrid(
                          gridLinesVisibility: GridLinesVisibility.both,
                          headerGridLinesVisibility: GridLinesVisibility.both,
                          columnWidthMode: Platform.isAndroid
                              ? ColumnWidthMode.none
                              : ColumnWidthMode.fill,
                          allowColumnsResizing: true,
                          columnResizeMode: ColumnResizeMode.onResize,
                          allowSorting: true,
                          source: MyDataSource(controller.productData, context),
                          allowEditing: true,
                          selectionMode: SelectionMode.multiple,
                          onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                            controller.columnWidths[details.column.columnName] = details.width;
                            controller.saveColumnWidths(); 
                            return true;
                          },
                          columns: <GridColumn>[
                          for (var columnName in controller.columnWidths.keys)
                          GridColumn(
                            width: controller.columnWidths[columnName]!,
                            columnName: columnName,
                            visible: controller.columnVisibility[columnName]!,
                            label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.center,
                            child: Text(
                            columnName.toUpperCase(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    
                    showColumnSelectionDialog();
                  },
                  color: Colors.greenAccent,
                  elevation: 5.0,
                  height: 60.0,
                  minWidth: 200.0,
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Text('Edit'),
                ),
                SizedBox(width: 20.0,),
                MaterialButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddProductDialog((Product newProduct) {
                          controller.addProduct(newProduct);
                        });
                      },
                    );
                  },
                  color: Colors.greenAccent,
                  elevation: 5.0,
                  height: 60.0,
                  minWidth: 200.0,
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Text('Add data'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }





void showColumnSelectionDialog() {

  List<String> availableColumns = controller.getAvailableColumns();

  List<bool> selectedColumns = List.generate(availableColumns.length,
      (index) => controller.columnVisibility[availableColumns[index]] ?? true);

  Get.defaultDialog(
    title: "Columns",
    content: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Column(
          children: [
            for (int i = 0; i < availableColumns.length; i++)
              CheckboxListTile(
                title: Text(availableColumns[i].toUpperCase()),
                value: selectedColumns[i],
                onChanged: (value) {
                  setState(() {
                    selectedColumns[i] = value!;
                  });
                },
              ),
          ],
        );
      },
    ),
    confirm: ElevatedButton(
      onPressed: () {
        Get.back();
        for (int i = 0; i < availableColumns.length; i++) {
          controller.setColumnVisibility(availableColumns[i], selectedColumns[i]);
        }
      },
      child: const Text('save'),
    ),
  );
}
}

