class LanguageConverter {
  /// Превращает число в порядковое: 1-ым, 2-ым, 3-им, 13-ым, 23-им и т.д.
  static String toOrdinal(int number) {
    final absNumber = number.abs();

    // Исключения: 13, 113, 213 и т.д. -> тринадцатым (-ым)
    if (absNumber % 100 == 13) {
      return '$number-ым';
    }

    // Все числа, оканчивающиеся на 3 (3, 23, 33, 103...) -> третьим (-им)
    if (absNumber % 10 == 3) {
      return '$number-им';
    }

    // Все остальные числа (1-ым, 2-ым, 4-ым, 5-ым, 10-ым...)
    return '$number-ым';
  }
}