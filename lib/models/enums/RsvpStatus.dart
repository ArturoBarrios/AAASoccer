enum RsvpStatus {
  yes,
  no,
  maybe,
}

extension RsvStatusText on String {
  RsvpStatus get toRsvpStatus {
    switch (this) {
      case 'Yes':
        return RsvpStatus.yes;
      case 'NO':
        return RsvpStatus.no;
      case 'MAYBE':
        return RsvpStatus.maybe;
      default:
        return RsvpStatus.maybe;
    }
  }
}
