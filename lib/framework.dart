import 'package:flutter/widgets.dart';

abstract class Status {
  const Status();
}

class StatusUnknown implements Status {
  const StatusUnknown();
}

class StatusOk implements Status {
  const StatusOk();
}

class StatusError implements Status {
  final Object? error;
  const StatusError(this.error);
}

class StatusInProgress implements Status {
  const StatusInProgress();
}

abstract class Broadcast<T> {
  const Broadcast();
  Status write(T data);

  factory Broadcast.callback(BroadcastCallback<T> callback) {
    return _CallbackBroadcast(callback);
  }
}

typedef BroadcastCallback<T> = void Function(T data);

class _CallbackBroadcast<T> extends Broadcast<T> {
  final BroadcastCallback<T> _callback;
  _CallbackBroadcast(BroadcastCallback<T> callback) : _callback = callback;

  @override
  Status write(data) {
    _callback(data);
    return StatusOk();
  }
}

abstract class _Receive<T> extends Receive<T> implements Listenable {
  const _Receive();
}

abstract class Receive<T> {
  const Receive();
  T read();

  void bind(LateReceive<T> other);

  factory Receive.fromValueNotifier(ValueNotifier<T> notifier) {
    return _ValueNotifierReceive(notifier);
  }
}

class _ValueNotifierReceive<T> extends _Receive<T> {
  final ValueNotifier<T> _v;

  const _ValueNotifierReceive(this._v);

  @override
  T read() => _v.value;

  @override
  void addListener(VoidCallback listener) {
    return _v.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    return _v.removeListener(listener);
  }

  @override
  void bind(LateReceive<T> other) {
    other.bindValueNotifier(_v);
  }
}

abstract class LateReceive<T> extends Receive<T> {
  factory LateReceive({T initialValue, bool leading}) = _LateReceive;

  void bindValueNotifier(ValueNotifier<T> notifier, {bool leading});
  void bindStream(Stream<T> stream, T initialValue);
}

class _LateReceive<T> extends _Receive<T> implements LateReceive<T> {
  late ValueNotifier<T> _notifier;
  final Set _listeners = <void Function()>{};
  final bool leading;

  bool _bound = false;
  T? _initialValue;

  _LateReceive({T? initialValue, this.leading = false})
      : _initialValue = initialValue;

  void addListener(VoidCallback listener) {
    if (_bound) {
      _notifier.addListener(listener);
    } else {
      _listeners.add(listener);
    }
  }

  @override
  T read() {
    if (!_bound) {
      return _initialValue!;
    }
    return _notifier.value;
  }

  void removeListener(VoidCallback listener) {
    if (_bound) {
      _notifier.removeListener(listener);
    } else {
      _listeners.remove(listener);
    }
  }

  void _bind([leaeding = false]) {
    _bound = true;

    _listeners.forEach((listener) {
      _notifier.addListener(listener);
    });

    if (leading || this.leading) {
      _listeners.forEach((element) {
        element.call();
      });
    }
  }

  void bindStream(Stream<T> stream, T initialValue) {
    _bound = true;
    _notifier = ValueNotifier(initialValue);

    stream.listen((data) {
      _notifier.value = data;
    });

    _bind();
  }

  void bindValueNotifier(ValueNotifier<T> notifier, {leading = false}) {
    _notifier = notifier;
    _bind(leading);
  }

  @override
  void bind(LateReceive<T> other) {
    throw new Exception('not implemented');
  }
}

mixin Init<T> on StatelessWidget {
  T init();

  static data() {}

  @override
  StatelessElement createElement() {
    return InitElement<T>(this);
  }
}

extension DataHolder<T> on BuildContext {
  T data<T>(Init<T> widget) {
    return (this as InitElement<T>).data;
  }
}

extension LateReceiveValueNotifierBinding<T> on ValueNotifier<T> {
  void bind(LateReceive<T> receive) {
    receive.bindValueNotifier(this);
  }
}

extension ReceiveValueNotifierFactory<T> on ValueNotifier<T> {
  Receive<T> toReceive() {
    return Receive.fromValueNotifier(this);
  }
}

class InitElement<T> extends StatelessElement {
  InitElement(StatelessWidget widget) : super(widget);

  late final T data;

  @override
  void mount(Element? parent, Object? newSlot) {
    data = (widget as Init<T>).init();
    super.mount(parent, newSlot);
  }
}

class Receiver<T> extends Widget {
  final WidgetBuilder builder;
  final Receive<T> receive;

  Receiver({
    Key? key,
    required this.builder,
    required this.receive,
  }) : super(key: key);

  @override
  Element createElement() {
    return ReceiverElement<T>(this);
  }
}

class ReceiverElement<T> extends ComponentElement {
  ReceiverElement(Receiver<T> widget) : super(widget);

  Receiver<T> get widget => super.widget as Receiver<T>;

  void _listener() {
    markNeedsBuild();
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);

    (widget.receive as _Receive<T>).addListener(_listener);
  }

  @override
  void unmount() {
    (widget.receive as _Receive<T>).removeListener(_listener);
    super.unmount();
  }

  @override
  Widget build() {
    return widget.builder(this);
  }
}
