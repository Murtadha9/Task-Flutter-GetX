
import 'package:get/get.dart';
import 'package:list90/models/product.dart';
import 'package:get_storage/get_storage.dart';

class GridController extends GetxController {


  final RxList<Product> productData = <Product>[].obs;

  final RxMap<String, double> columnWidths = {
    'id': double.nan,
    'name': double.nan,
    'price': double.nan,
    'orderNo': double.nan,
    'qty': double.nan,
  }.obs;

   final RxMap<String, bool> columnVisibility = {
    'id': true,
    'name': true,
    'price': true,
    'orderNo': true,
    'qty': true,
  }.obs;

    final box = GetStorage();

  


  @override
  void onInit() {


     final savedProductData = box.read<List<dynamic>>('productData');
    if (savedProductData != null) {
      productData.addAll(savedProductData.map((data) => Product.fromMap(data as Map<String, dynamic>)));
    } else {
      
      productData.assignAll([
        Product(1, 'Product 1', '10 ', 'ORD123', 5),
        Product(2, 'Product 2', '20 ', 'ORD321', 10),
        
      ]);
    }




    
    loadSavedColumnWidths();
    



    final savedColumnVisibility = box.read<Map<String, dynamic>>('columnVisibility');
    if (savedColumnVisibility != null) {
      columnVisibility.addAll(Map<String, bool>.from(savedColumnVisibility));
    }
  
    
    super.onInit();
  }

 void addProduct(Product newProduct) {
    productData.add(newProduct);
    saveProductData();
  }


   void saveProductData() {
    box.write('productData', productData.map((product) => product.toMap()).toList());
  }

  Future<void> updateProduct(int rowIndex, String columnName, String value) async {
    if (columnName == 'name') {
      productData[rowIndex].name = value;
    } else if (columnName == 'price') {
      productData[rowIndex].price = value;
    } else if (columnName == 'orderNo') {
      productData[rowIndex].orderNo = value;
    } else if (columnName == 'qty') {
      productData[rowIndex].qty = int.tryParse(value) ?? 0;
    }

    update(); 
  }

 
////////////////////////////////////////////////////////////////////////////////
void saveColumnWidths() {
  final box = GetStorage();
  final validColumnWidths = <String, dynamic>{};

  for (var entry in columnWidths.entries) {
    if (entry.value.isFinite) {
      validColumnWidths[entry.key] = entry.value;
    } else {
      validColumnWidths[entry.key] = null;
    }
  }

  box.write('columnWidths', validColumnWidths);
}
  void loadSavedColumnWidths() {
    final box = GetStorage();
    final savedColumnWidths = box.read<Map<String, dynamic>>('columnWidths');

    if (savedColumnWidths != null) {
      for (var entry in savedColumnWidths.entries) {
        final double? width = entry.value is double ? entry.value : null;
        if (width != null && width.isFinite) {
          columnWidths[entry.key] = width;
        } else {
          
          columnWidths[entry.key] = 100.0;
        }
      }

      
    }
  }
  ////////////////////////////////////////////////////////////////////////////////

    void setColumnVisibility(String columnName, bool isVisible) {
    columnVisibility[columnName] = isVisible;
    saveColumnVisibility();
    update(); 
  }

  void saveColumnVisibility() {
    box.write('columnVisibility', Map<String, bool>.from(columnVisibility));
  }

  List<String> getAvailableColumns() {
    return columnVisibility.keys.toList();
  }


}
