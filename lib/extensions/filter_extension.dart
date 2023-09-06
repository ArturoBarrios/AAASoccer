import 'package:soccermadeeasy/models/componentModels/filter_result_model.dart';

/// Extension for filtering event list.
extension FilterEventExtension on List<dynamic>? {
  List<dynamic>? filterByPriceAmount(
      {final String? selectedKey, final FilterRangeResultModel? rangeAmount}) {
    return this?.where((item) {
      final selectedMinAmount = formatAmount(rangeAmount?.minResult);
      final selectedMaxAmount = formatAmount(rangeAmount?.maxResult);
      double itemAmount =
          getPriceByEventType(key: selectedKey, event: item) ?? 0;

      return (selectedMinAmount) < itemAmount &&
          itemAmount < (selectedMaxAmount);
    }).toList();
  }

  double? getPriceByEventType({final String? key, final dynamic event}) {
    switch (key) {
      case '10':
        return double.tryParse(event['event']['price']['amount'].toString()) ??
            0;
      case '12':
        return double.tryParse(event['team']['price'].toString()) ?? 0;
      case 'EventType.GAME':
        return double.tryParse(event['price']['amount'].toString()) ?? 0;
      case 'TEAM':
        return double.tryParse(event['price']['amount'].toString()) ?? 0;
      case 'EventType.TRAINING':
        return double.tryParse(event['price']['amount'].toString()) ?? 0;
      case 'EventType.TRYOUT':
        return double.tryParse(event['price']['amount'].toString()) ?? 0;
      case 'EventType.TOURNAMENT':
        return double.tryParse(event['price']['amount'].toString()) ?? 0;
    }

    return null;
  }

  double formatAmount(double? amount) {
    double formatted = ((amount ?? 0) * 100).roundToDouble();
    return formatted;
  }
}
