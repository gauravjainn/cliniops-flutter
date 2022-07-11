extension IterableExtension<T> on Iterable<T> {
  T? get tryFirst {
    if (isEmpty) {
      return null;
    }
    return first;
  }

  T? get tryLast {
    if (isEmpty) {
      return null;
    }
    return last;
  }

  T? tryElementAt(int index) {
    var elementIndex = 0;
    for (var element in this) {
      if (index == elementIndex) return element;
      elementIndex++;
    }
  }

  T? tryFirstWhere(bool Function(T element) test, {T Function()? orElse}) {
    if (isEmpty) {
      return null;
    } else {
      try {
        return firstWhere(test, orElse: orElse);
      } catch (e) {
        return null;
      }
    }
  }
}
