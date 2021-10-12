String capitalize(String? text) {
  if (text == null) return '';
  var result = '';
  for (var i = 1; i < text.length; i++) {
    final prev = text.codeUnitAt(i - 1);
    var char = text[i];
    if (prev < 97 || 122 < prev) char = char.toUpperCase();
    result += char;
  }
  return text[0].toUpperCase() + result;
}
