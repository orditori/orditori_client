import 'dart:math';

import 'package:dart_patterns/result.dart';
import 'package:flutter/material.dart';

sealed class Mutation<O, A, R> {
  R get result;
  void call();
}

class SyncMutation<O, A> extends Mutation<O, A, Late<O>> {
  final Object _token;
  final QueryWidgetElement _owner;

  @override
  Late<O> result = Late<O>.pending();

  SyncMutation._(this._owner, this._token);

  @override
  void call() {
    final record = _owner._getMutator<O, A>(_token);
    final ref = _owner._getRef<O>(_token);

    final callback = record.$2 as O Function(O, Object);

    final r = Result.guard(() => callback(ref.current, const Object()));

    switch (r) {
      case Success(value: final value):
        _owner._mutations.remove(ValueKey((SyncMutation<O, A>, _token)));
        ref.current = value;
        break;
      case Failure(exception: final e, stackTrace: final s):
        result = Late.failure(e, s);
        _owner.markNeedsBuild();
        break;
    }
  }
}

abstract interface class QueryBuildContext extends BuildContext {
  Result<T> querySync<T, K extends Object>(
    T Function(T, K) query, {
    K? input,
    Object token,
  });

  SyncMutation<I, A> syncMutation<I, A extends Object>(
    I Function(I current, A arg) mutate, {
    A? input,
    Object token,
  });
}

abstract class QueryWidget extends Widget {
  const QueryWidget({super.key});

  void init(QueryInitContext context) {}
  Widget build(QueryBuildContext context);

  @override
  Element createElement() {
    return QueryWidgetElement(this);
  }
}

class _QueryWidgetMarker extends InheritedWidget {
  final QueryWidgetElement element;
  const _QueryWidgetMarker({required super.child, required this.element});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class QueryWidgetElement extends ComponentElement
    implements QueryBuildContext, QueryInitContext {
  QueryWidgetElement(QueryWidget super.widget);

  final Map<Key, Ref> _refs = {};
  final Map<Key, (Mutation, Function, Object)> _mutations = {};

  @override
  QueryWidget get widget => super.widget as QueryWidget;

  bool initialized = false;

  @override
  Widget build() {
    if (!initialized) {
      widget.init(this);
      initialized = true;
    }

    return _QueryWidgetMarker(
      element: this,
      child: widget.build(this),
    );
  }

  @override
  Ref<T> ref<T>(T Function() createRef, [Object token = const Object()]) {
    final k = ValueKey((Ref<T>, token));
    return (_refs[k] ??= Ref<T>(createRef())..dependencies.add(this)) as Ref<T>;
  }

  @override
  SyncMutation<I, A> syncMutation<I, A extends Object>(
    I Function(I current, A arg) mutate, {
    A? input,
    Object token = const Object(),
  }) {
    final key = ValueKey((SyncMutation<I, A>, token));

    final m = _mutations[key] ??= (
      SyncMutation<I, A>._(this, token),
      mutate,
      token,
    );

    return m.$1 as SyncMutation<I, A>;
  }

  Ref<T> _getRef<T>(Object token) {
    final refKey = ValueKey((Ref<T>, token));
    final ref = _refs[refKey] as Ref<T>?;

    if (ref == null) {
      late Element parent;
      visitAncestorElements((element) {
        parent = element;
        return false;
      });

      final el = parent.getInheritedWidgetOfExactType<_QueryWidgetMarker>();
      final ref = el!.element._getRef<T>(token);

      _refs[refKey] = ref..dependencies.add(this);
      return ref;
    } else {
      return ref;
    }
  }

  (SyncMutation<I, A>, I Function(I, A), Object) _getMutator<I, A>(
    Object token,
  ) {
    final key = ValueKey((SyncMutation<I, A>, token));
    final r = _mutations[key];

    if (r != null) {
      return r as (SyncMutation<I, A>, I Function(I, A), Object);
    } else {
      late Element parent;
      visitAncestorElements((element) {
        parent = element;
        return false;
      });

      final el = parent.getInheritedWidgetOfExactType<_QueryWidgetMarker>();
      return el!.element._getMutator<I, A>(token);
    }
  }

  @override
  Result<T> querySync<T, A extends Object>(
    T Function(T current, A arg) query, {
    A? input,
    Object token = const Object(),
  }) {
    final ref = _getRef<T>(token);
    final arg = input ?? const Object();
    return Result.guard(() => query(ref.current, arg as A));
  }

  @override
  void unmount() {
    for (var ref in _refs.values) {
      ref.dependencies.remove(this);
    }
    super.unmount();
  }
}

abstract interface class QueryInitContext {
  Ref<T> ref<T>(T Function() createRef, [Object token]);
}

class Ref<T> {
  final Set<QueryWidgetElement> dependencies = {};
  T _current;

  T get current => _current;

  set current(T v) {
    _current = v;

    for (var e in dependencies) {
      e.markNeedsBuild();
    }
  }

  Ref(this._current);
}

final r = Random();

class CounterApp extends QueryWidget {
  const CounterApp({super.key});

  @override
  void init(QueryInitContext context) {
    context.ref(() => 0);
  }

  int getCount(int current, _) => current;

  int increment(int current, _) {
    if (r.nextInt(100) > 70) throw Exception();
    return current + 1;
  }

  @override
  Widget build(QueryBuildContext context) {
    final count = context.querySync(getCount);
    final inc = context.syncMutation(increment);

    return Column(
      children: [
        Text('Count: ${(count as Success).value}'),
        Text('${inc.result}'),
        ElevatedButton(
          onPressed: inc.call,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: CounterApp(),
      ),
    ),
  );
}
