import 'package:flutter/widgets.dart';

typedef ResultBuilder<T> = Widget Function(BuildContext context, T? value);
typedef ErrorBuilder<T> = Widget Function(BuildContext context, Object? err);

class _Provider<T> extends InheritedWidget {
  const _Provider({
    Key? key,
    required Widget child,
    required this.value,
  }) : super(key: key, child: child);

  final T? value;

  @override
  bool updateShouldNotify(_Provider<T> old) => value != old.value;
}

class AsyncWidget<T> extends StatefulWidget {
  final Future<T> Function() load;
  final Widget? child;
  final ResultBuilder<T>? builder;

  final Widget? error;
  final ErrorBuilder? errorBuilder;

  final Widget loading;
  final bool showDataWhenLoading;

  const AsyncWidget({
    Key? key,
    required this.load,
    required this.loading,
    this.showDataWhenLoading = false,
    this.child,
    this.builder,
    this.error,
    this.errorBuilder,
  })  : assert(child != null || builder != null),
        assert(error != null || errorBuilder != null),
        super(key: key);

  static T? read<T>(BuildContext context) {
    final w = context.dependOnInheritedWidgetOfExactType<_Provider<T>>();
    return w?.value;
  }

  static final Map<Type, _AsyncWidgetState> _widgets = {};

  static void reload<T>() {
    final s = _widgets[T] as _AsyncWidgetState<T>?;
    s?._reload();
  }

  @override
  _AsyncWidgetState createState() => _AsyncWidgetState<T>();
}

enum AsyncState {
  loading,
  success,
  error,
}

class _AsyncWidgetState<T> extends State<AsyncWidget> {
  @override
  AsyncWidget<T> get widget => super.widget as AsyncWidget<T>;

  AsyncState _state = AsyncState.loading;

  T? value;
  Object? error;

  Widget _defaultBuilder(BuildContext _, T? __) => widget.child!;
  Widget _defaultErrorBuilder(BuildContext _, Object? __) => widget.error!;

  ResultBuilder<T> get builder => widget.builder ?? _defaultBuilder;
  ErrorBuilder get errorBuilder => widget.errorBuilder ?? _defaultErrorBuilder;

  bool _debugNeedsReload = true;
  Widget? prevBuiltWidget;

  @override
  void initState() {
    AsyncWidget._widgets[T] = this;

    _load();
    super.initState();
  }

  void _reload() {
    setState(_load);
  }

  void _done(T value) {
    _state = AsyncState.success;
    setState(() {
      this.value = value;
    });
  }

  void _onError(Object? error) {
    _state = AsyncState.error;
    setState(() {
      this.error = error;
    });
  }

  void _load() {
    _state = AsyncState.loading;
    widget.load().then(_done).catchError(_onError);
  }

  @override
  void didUpdateWidget(covariant AsyncWidget oldWidget) {
    if (_debugNeedsReload) {
      setState(_load);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    AsyncWidget._widgets.remove(T);
    super.dispose();
  }

  @override
  void reassemble() {
    _debugNeedsReload = false;
    super.reassemble();
    _debugNeedsReload = false;
  }

  @override
  Widget build(BuildContext context) {
    switch (_state) {
      case AsyncState.loading:
        if (widget.showDataWhenLoading && prevBuiltWidget != null) {
          return prevBuiltWidget!;
        } else {
          return widget.loading;
        }
      case AsyncState.success:
        prevBuiltWidget = _Provider<T>(
          value: value,
          child: builder(context, value),
        );

        return prevBuiltWidget!;
      case AsyncState.error:
        return errorBuilder(context, error);
    }
  }
}
