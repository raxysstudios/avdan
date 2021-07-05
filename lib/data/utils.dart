String capitalize(String? value) {
  if (value == null) return '';
  return value
      .split(' ')
      .where((w) => w.length > 0)
      .map((w) => w[0].toUpperCase() + w.substring(1))
      .join(' ');
}
