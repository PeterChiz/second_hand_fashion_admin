class SHFPricingCalculator {
  /// -- Tính toán giá dựa trên thuế và phí vận chuyển
  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate = getTaxRateForLocation();
    double taxAmount = productPrice * taxRate;

    double shippingCost = getShippingCost(location);

    double totalPrice = productPrice + taxAmount + shippingCost;
    return double.tryParse(totalPrice.toStringAsFixed(0)) ?? 0;
  }

  /// -- Tính toán phí vận chuyển
  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(0);
  }

  /// -- Tính toán thuế
  static String calculateTax(double productPrice) {
    double taxRate = getTaxRateForLocation();
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(0);
  }

  static double getTaxRateForLocation() {
    return 0.1; //thuế VAT 10%
  }

  static double getShippingCost(String location) {
    if (location == 'Nha Trang'  || location == 'nha trang') {
      return 0.0;
    } else {
      return 30000;
    }
  }
}