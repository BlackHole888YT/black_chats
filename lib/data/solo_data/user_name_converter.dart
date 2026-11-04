class UserNameConverter {
  static final List<String> russianLetters = [
    'а', 'б', 'в', 'г', 'д', 'е', 'ё', 'ж', 'з', 'и', 'й',
    'к', 'л', 'м', 'н', 'о', 'п', 'р', 'с', 'т', 'у', 'ф',
    'х', 'ц', 'ч', 'ш', 'щ', 'ъ', 'ы', 'ь', 'э', 'ю', 'я',
  ];

  static final List<String> russianConvertedLetters = [
    'a', 'b', 'v', 'g', 'd', 'e', 'e', 'j', 'z', 'i', 'i',
    'k', 'l', 'm', 'n', 'o', 'p', 'r', 's', 't', 'y', 'f',
    'h', 'c', 'ch', 'sh', 'sch', '', 'y', '', 'e', 'yu', 'ya',
  ];

  static String run(String userName) {
    List<String> chars = userName.toLowerCase().split('');
    StringBuffer result = StringBuffer();

    for (int i = 0; i < chars.length; i++) {
      String char = chars[i];

      if (char == ' ') {
        result.write('_');
        continue;
      }

      int index = russianLetters.indexOf(char);
      if (index != -1) {
        result.write(russianConvertedLetters[index]);
      } else {
        result.write(char);
      }
    }

    return result.toString();
  }
}