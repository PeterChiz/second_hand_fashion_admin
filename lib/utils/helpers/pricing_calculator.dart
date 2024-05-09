import '../../features/shop/models/cart_model.dart';

class SHFPricingCalculator {
  /// -- Tính toán giá dựa trên thuế và phí vận chuyển
  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;

    double shippingCost = getShippingCost(location);

    double totalPrice = productPrice + taxAmount + shippingCost;
    return double.tryParse(totalPrice.toStringAsFixed(2)) ?? 0;
  }

  /// -- Tính toán phí vận chuyển
  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  /// -- Tính toán thuế
  static String calculateTax(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
    return 0.10; //thuế VAT 10%
  }

  static double getShippingCost(String location) {
    // Tra cứu phí vận chuyển cho vị trí cụ thể bằng cách sử dụng API phí vận chuyển.
    // Tính toán phí vận chuyển dựa trên các yếu tố khác nhau như khoảng cách, trọng lượng, vv.
    return 5.00; // Ví dụ phí vận chuyển là $5
  }

}
