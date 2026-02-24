extension StringExtension on String {
  static const _diacritics =
      'ÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÌÍÎÏìíîïÙÚÛÜùúûüÿÑñ';
  static const _replacements =
      'AAAAAAaaaaaaOOOOOOooooooEEEEeeeeCcIIIIiiiiUUUUuuuuyNn';

  String removeDiacritics() {
    return splitMapJoin(
      '',
      onNonMatch: (char) => char.isNotEmpty && _diacritics.contains(char)
          ? _replacements[_diacritics.indexOf(char)]
          : char,
    );
  }

  String normalize() {
    return trim().toLowerCase().removeDiacritics();
  }
}
