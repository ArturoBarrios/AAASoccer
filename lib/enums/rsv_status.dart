enum RsvStatus {
  yes,
  no,
  maybe,
}

extension RsvStatusText on String {
  RsvStatus get toRsv {
    switch (this) {
      case 'Yes':
        return RsvStatus.yes;
      case 'NO':
        return RsvStatus.no;
      case 'MAYBE':
        return RsvStatus.maybe;
      default:
        return RsvStatus.maybe;
    }
  }
}
