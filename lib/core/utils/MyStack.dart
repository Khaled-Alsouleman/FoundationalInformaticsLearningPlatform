import 'package:flutter/foundation.dart';

class MyStack<T> {
  final List<T> _stack = [];

  void push(T element) {
    if (kDebugMode) {
      print('Element to add in the Stack: $element');
    }
    _stack.add(element);
  }

  T? pop() {
    if (isEmpty) {
      return null;
    }
    return _stack.removeLast();
  }

  T? peek() {
    if (isEmpty) {
      return null;
    }
    return _stack.last;
  }

  bool get isEmpty => _stack.isEmpty;

  int get size => _stack.length;

  void clear() {
    _stack.clear(); // Methode zum Leeren des Stacks
  }

  MyStack<T> clone() {
    return MyStack<T>().._stack.addAll(_stack);
  }

  /// Gibt den Stack-Inhalt als Liste zurück.
  List<T> toList() {
    return List<T>.from(_stack);
  }

  @override
  String toString() {
    return _stack.toString();
  }
}
