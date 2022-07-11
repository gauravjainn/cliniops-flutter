extension StringExtension on String {
  String get inCaps {
    if (isEmpty) {
      return '';
    }

    if (length < 2) {
      return this[0].toUpperCase();
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get capitalizeFirstOfEach {
    if (isEmpty) {
      return '';
    }
    return toLowerCase().split(' ').map((str) => str.inCaps).join(' ');
  }

  String get trimAll {
    if (isEmpty) {
      return '';
    }
    return replaceAll(RegExp(r'\s+'), '');
  }
}
