extension RemoveZeroFromNumber on String {
  String get removeZero {
    if (startsWith('0')) {
      return substring(1);
    }
    return this;
  }
}
