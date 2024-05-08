import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/popups/dialogs.dart';
import '../../models/product_attribute_model.dart';
import 'product_variations_controller.dart';

class ProductAttributesController extends GetxController {
  static ProductAttributesController get instance => Get.find();

  // Observables cho trạng thái tải, key của form, và các thuộc tính của sản phẩm
  final isLoading = false.obs;
  final attributesFormKey = GlobalKey<FormState>();
  TextEditingController attributeName = TextEditingController();
  TextEditingController attributes = TextEditingController();
  final RxList<ProductAttributeModel> productAttributes = <ProductAttributeModel>[].obs;

  // Hàm để thêm một thuộc tính mới
  void addNewAttribute() {
    // Validation Form
    if (!attributesFormKey.currentState!.validate()) {
      return;
    }

    // Thêm Thuộc tính vào Danh sách các Thuộc tính
    productAttributes.add(ProductAttributeModel(
        name: attributeName.text.trim(), values: attributes.text.trim().split('|').toList()));

    // Xóa các trường văn bản sau khi thêm
    attributeName.text = '';
    attributes.text = '';
  }

  // Hàm để xóa một thuộc tính
  void removeAttribute(int index, BuildContext context) {
    // Hiển thị hộp thoại xác nhận
    SHFDialogs.defaultDialog(
      context: context,
      onConfirm: () {
        // Người dùng xác nhận, xóa thuộc tính
        Navigator.of(context).pop();
        productAttributes.removeAt(index);

        // Đặt lại productVariations khi xóa một thuộc tính
        ProductVariationController.instance.productVariations.value = [];
      },
    );
  }

  // Hàm để đặt lại productAttributes
  void resetProductAttributes() {
    productAttributes.clear();
  }
}
