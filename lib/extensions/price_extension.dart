/// Extension for price.
extension PriceExtension on String? {
  ///
  String getPrice() => (double.parse(this ?? '0.00') / 100).toStringAsFixed(2);
}
