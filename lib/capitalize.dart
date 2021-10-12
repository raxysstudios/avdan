String capitalize(String? text) {
  if (text == null) return '';
  return text
      .split(' ')
      .map((w) => w[0].toUpperCase() + w.substring(1))
      .join(' ')
      .split('-')
      .map((w) => w[0].toUpperCase() + w.substring(1))
      .join('-');
}
