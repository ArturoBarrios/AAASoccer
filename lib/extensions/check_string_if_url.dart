/// Extension for checking if string valid url.
extension CheckStringIfUrl on String? {
  ///
  bool isContainsUrl() => (this ?? '').contains('cloudfront.net');

  ///
  bool isValidUrl() =>
      (Uri.tryParse(this ?? '')?.isAbsolute ?? false) && isContainsUrl();
}
