import 'package:flutter/widgets.dart';
import 'package:flutter_context/flutter_context.dart';

abstract class ContextNode<T> {
  T get value;
  Context<T> get context;

  // ignore: non_constant_identifier_names
  Widget Provider({
    required Widget child,
  }) {
    return (context as PendingContext<T>).Provider(
      value: value,
      child: child,
    );
  }
}
