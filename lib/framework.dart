import 'package:flutter/widgets.dart';

abstract class Status<T> {
  const Status();

  factory Status.fromStream(Stream<Status<T>> stream) {
    return _StatusStream<T>(stream);
  }
}

class StatusUnknown<T> implements Status<T> {
  const StatusUnknown();
}

class StatusOk<T> implements Status<T> {
  final T payload;
  const StatusOk(this.payload);
}

class StatusError<T> implements Status<T> {
  final Object? error;
  const StatusError(this.error);
}

class StatusInProgress<T> implements Status<T> {
  const StatusInProgress();
}

class _StatusStream<T> implements Status<T> {
  final Stream<Status<T>> stream;
  final Status<T> initialValue;
  const _StatusStream(this.stream, [this.initialValue = const StatusUnknown()]);
}

abstract class Broadcast<T, K> {
  const Broadcast();
  Status<K> write(T data);

  factory Broadcast.callback(BroadcastCallback<T, K> callback) {
    return _CallbackBroadcast(callback);
  }
}

abstract class _Broadcast<T, K> extends Broadcast<T, K> {
  late final ValueNotifier<Status<K>> _statusNotifier;
  bool _initialized = false;

  void notifyStatusListeners(Status<K> status) {
    if (!_initialized) {
      _initialized = true;
      _statusNotifier = ValueNotifier(status);
    } else {
      _statusNotifier.value = status;
    }
  }

  void addStatusListener(VoidCallback callback) {
    if (!_initialized) {
      _statusNotifier = ValueNotifier(StatusUnknown<K>());
      _initialized = true;
    }

    _statusNotifier.addListener(callback);
  }

  void removeStatusListener(VoidCallback callback) {
    _statusNotifier.removeListener(callback);
  }
}

typedef BroadcastCallback<T, K> = Status<K> Function(T data);

class _CallbackBroadcast<T, K> extends _Broadcast<T, K> {
  final BroadcastCallback<T, K> _callback;
  _CallbackBroadcast(BroadcastCallback<T, K> callback) : _callback = callback;

  @override
  Status<K> write(data) {
    final status = _callback(data);
    notifyStatusListeners(status);
    return status;
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

typedef StatusListenerBuilder<T> = Widget Function(
    BuildContext context, Status<T> status);

class StatusListener<T, K> extends Widget {
  final StatusListenerBuilder<K> builder;
  final Broadcast<T, K> broadcast;

  const StatusListener({
    Key? key,
    required this.builder,
    required this.broadcast,
  }) : super(key: key);

  @override
  Element createElement() {
    return StatusListenerElement<T, K>(this);
  }
}

class StatusListenerElement<T, K> extends ComponentElement {
  StatusListenerElement(StatusListener<T, K> widget) : super(widget);

  StatusListener<T, K> get widget => super.widget as StatusListener<T, K>;
  _Broadcast<T, K> get broadcast => widget.broadcast as _Broadcast<T, K>;
  Status<K> get status => broadcast._initialized
      ? broadcast._statusNotifier.value
      : StatusUnknown();

  void _onStatusReceived() {
    markNeedsBuild();
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    broadcast.addStatusListener(_onStatusReceived);
    super.mount(parent, newSlot);
  }

  @override
  void unmount() {
    broadcast.removeStatusListener(_onStatusReceived);
    super.unmount();
  }

  @override
  Widget build() {
    if (status is _StatusStream<K>) {
      final _status = status as _StatusStream<K>;

      return StreamBuilder<Status<K>>(
        stream: _status.stream,
        initialData: _status.initialValue,
        builder: (context, snapshot) {
          return widget.builder(context, snapshot.requireData);
        },
      );
    }

    return widget.builder(this, status);
  }
}
