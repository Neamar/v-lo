class Currency {
  static String formatPrice(int price) {
    return (price / 100).toStringAsFixed(2);
  }
}