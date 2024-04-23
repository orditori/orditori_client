import 'package:dart_patterns/result.dart';
import 'package:flutter/material.dart';

abstract class QContext implements BuildContext {
  Query<T> query<T extends Function>(T fn, [Object token = const Object()]);
}

abstract class QWidget extends Widget {
  const QWidget({super.key});

  @override
  Element createElement() {
    return QElement(this);
  }

  Widget build(QContext context);
}

class Ref<T> {
  T _value;
  final Set<QElement> _dependencies = {};

  T get value => _value;
  set value(T value) {
    _value = value;

    for (final element in _dependencies) {
      element.notify(this);
    }
  }

  Ref(this._value);
}

class _QElementMarker extends InheritedWidget {
  final QElement element;
  const _QElementMarker({required super.child, required this.element});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class QElement extends ComponentElement implements QContext {
  QElement(super.widget);

  final Map<Object, Ref> _refs = {};

  @override
  QWidget get widget => super.widget as QWidget;

  @override
  Widget build() {
    return widget.build(this);
  }

  void notify(Ref ref) {
    markNeedsBuild();
  }

  Ref<T> _getRef<T>([Object token = const Object()]) {
    final key = ValueKey((Ref<T>, token));
    final ref = _refs[key] as Ref<T>?;

    if (ref != null) {
      return ref;
    }

    late Element parent;

    visitAncestorElements((element) {
      parent = element;
      return false;
    });

    final marker = parent.getInheritedWidgetOfExactType<_QElementMarker>()!;
    return marker.element._getRef<T>(token);
  }

  @override
  Query<T> query<T extends Function>(T fn, [Object token = const Object()]) {
    return Query(fn, token, this);
  }
}

class Query<T extends Function> {
  final T _query;
  final Object _token;
  final QElement _element;
  late Object _result;

  Query(this._query, this._token, this._element);
}

extension ExecQueryWithNoArgs<T, K> on Query<QueryFn<T, K>> {
  void exec() {
    final ref = _element._getRef<K>(_token);
    _result = Result.guard(() => _query(ref.value));
  }
}

extension ExecQuery<T, K, A> on Query<QueryFnWithArg<T, K, A>> {
  void exec(A arg) {
    final ref = _element._getRef<K>(_token);
    _result = Result.guard(() => _query(ref.value, arg));
  }
}

extension ExecAsyncQueryWithNoArgs<T, K> on Query<AsyncQueryFn<T, K>> {
  void exec() async {
    final ref = _element._getRef<K>(_token);
    _result = LateAsync<T>.pending();

    try {
      final value = await _query(ref.value);
      _result = LateAsync<T>.success(value);
    } catch (e) {
      _result = LateAsync<T>.failure(e);
    }
  }
}

extension ExecAsyncQuery<T, K, A> on Query<AsyncQueryFnWithArg<T, K, A>> {
  void exec(A arg) async {
    final ref = _element._getRef<K>(_token);
    _result = LateAsync<T>.pending();

    try {
      final value = await _query(ref.value, arg);
      _result = LateAsync<T>.success(value);
    } catch (e) {
      _result = LateAsync<T>.failure(e);
    }
  }
}

typedef QueryFn<T, K> = T Function(K);
typedef AsyncQueryFn<T, K> = Future<T> Function(K);

typedef QueryFnWithArg<T, K, A> = T Function(K, A);
typedef AsyncQueryFnWithArg<T, K, A> = Future<T> Function(K, A);

extension LateResultQuery<T, K> on Query<QueryFn<T, K>> {
  Late<T> get result {
    return _result as Late<T>;
  }
}

extension LateResultQueryWithArg<T, K, A> on Query<QueryFnWithArg<T, K, A>> {
  Late<T> get result {
    return _result as Late<T>;
  }
}

extension LateAsyncResultQuery<T, K> on Query<AsyncQueryFn<T, K>> {
  LateAsync<T> get result {
    return _result as LateAsync<T>;
  }
}

extension LateAsyncResultQueryWithArg<T, K, A>
    on Query<AsyncQueryFnWithArg<T, K, A>> {
  LateAsync<T> get result {
    return _result as LateAsync<T>;
  }
}

int getCount(int current) => current;

class Example extends QWidget {
  const Example({super.key});

  @override
  Widget build(QContext context) {
    final countQuery = context.query(getCount)..exec();

    return Column(
      children: [
        if (countQuery.result case Pending())
          ElevatedButton(
            onPressed: () => countQuery.exec(),
            child: const Text('Get count'),
          ),
        switch (countQuery.result) {
          Success(value: final value) => Text('Count: $value'),
          Failure(exception: final e) => Text('Error: $e'),
          Pending<int>() => const Text('Something is seriously wrong!'),
        }
      ],
    );
  }
}
