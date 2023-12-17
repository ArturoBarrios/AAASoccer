class FilterResultModel {
  FilterResultModel({
    this.rangeResult,
  });

  FilterRangeResultModel? rangeResult;
}

class FilterRangeResultModel {
  FilterRangeResultModel({
    this.minResult,
    this.maxResult,
  });

  double? minResult;
  double? maxResult;
}
