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

  factory Broadcast.statusStreamGenerator(
    StatusStreamGenerator<T, K> gen,
    Receive<T> recv,
  ) {
    return _StatusStreamGeneratorBroadcast(gen, recv);
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
typedef StatusStreamGenerator<T, K> = Stream<Status<K>> Function(T data);

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

class _StatusStreamGeneratorBroadcast<T, K> extends _Broadcast<T, K> {
  final StatusStreamGenerator<T, K> _gen;
  final Receive<T> _recv;
  _StatusStreamGeneratorBroadcast(
      StatusStreamGenerator<T, K> generator, Receive<T> receive)
      : _gen = generator,
        _recv = receive;

  @override
  Status<K> write(T data) {
    final statusStream = _gen(_recv.read());
    final status = Status.fromStream(statusStream);
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

  Receive<K> map<K>(Mapper<T, K> mapper);

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
  Receive<K> map<K>(Mapper<T, K> mapper) {
    return _MappedReceive<T, K>(this, mapper);
  }
}

typedef Mapper<T, K> = K Function(T data);

class _MappedReceive<T, K> extends _Receive<K> {
  final _Receive<T> _receive;
  final Mapper<T, K> _mapper;

  const _MappedReceive(this._receive, this._mapper);

  @override
  K read() {
    return _mapper(_receive.read());
  }

  @override
  Receive<U> map<U>(Mapper<K, U> mapper) {
    return _MappedReceive<K, U>(this, mapper);
  }

  @override
  void addListener(VoidCallback listener) {
    _receive.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _receive.removeListener(listener);
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
  final T? _initialValue;

  _LateReceive({T? initialValue, this.leading = false})
      : _initialValue = initialValue;

  @override
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

  @override
  void removeListener(VoidCallback listener) {
    if (_bound) {
      _notifier.removeListener(listener);
    } else {
      _listeners.remove(listener);
    }
  }

  void _bind([leading = false]) {
    _bound = true;

    for (var listener in _listeners) {
      _notifier.addListener(listener);
    }

    if (leading || leading) {
      for (var element in _listeners) {
        element.call();
      }
    }
  }

  @override
  void bindStream(Stream<T> stream, T initialValue) {
    _bound = true;
    _notifier = ValueNotifier(initialValue);

    stream.listen((data) {
      _notifier.value = data;
    });

    _bind();
  }

  @override
  void bindValueNotifier(ValueNotifier<T> notifier, {leading = false}) {
    _notifier = notifier;
    _bind(leading);
  }

  @override
  Receive<K> map<K>(Mapper<T, K> mapper) {
    return _MappedLateReceive(this, mapper);
  }
}

class _MappedLateReceive<T, K> implements _LateReceive<K> {
  final _LateReceive<T> _receive;
  final Mapper<T, K> _mapper;

  const _MappedLateReceive(this._receive, this._mapper);

  @override
  void _bind([leading = false]) {
    _receive._bind(leading);
  }

  @override
  void addListener(VoidCallback listener) {
    _receive.addListener(listener);
  }

  @override
  void bindStream(Stream<K> stream, K initialValue) {
    throw Exception("Can't bind stream to mapped LateReceive");
  }

  @override
  K read() {
    if (!_bound) {
      return _initialValue!;
    }

    return _notifier.value;
  }

  @override
  void bindValueNotifier(ValueNotifier<K> notifier, {bool leading = false}) {
    throw Exception("Can't bind value notifier to mapped LateReceive");
  }

  @override
  Receive<U> map<U>(Mapper<K, U> mapper) {
    return _MappedLateReceive(this, mapper);
  }

  @override
  void removeListener(VoidCallback listener) {
    _receive.removeListener(listener);
  }

  @override
  bool get _bound => _receive._bound;

  @override
  K? get _initialValue {
    if (_receive._initialValue == null) return null;
    return _mapper(_receive._initialValue as T);
  }

  @override
  Set get _listeners => _receive._listeners;

  @override
  ValueNotifier<K> get _notifier =>
      _MappedValueNotifier<T, K>(_receive._notifier, _mapper);

  @override
  bool get leading => _receive.leading;

  @override
  set _bound(bool bound) {
    _receive._bound = bound;
  }

  @override
  set _notifier(ValueNotifier<K> notifier) {
    throw Exception("Can't set notifier on mapped LateReceive");
  }
}

class _MappedValueNotifier<T, K> implements ValueNotifier<K> {
  final ValueNotifier<T> _notifier;
  final Mapper<T, K> _mapper;

  late K _value = _mapper(_notifier.value);

  @override
  K get value => _value;

  @override
  set value(K v) {
    if (_value == v) return;
    _value = v;
    notifyListeners();
  }

  _MappedValueNotifier(this._notifier, this._mapper);

  @override
  void addListener(VoidCallback listener) {
    _notifier.addListener(listener);
  }

  @override
  void dispose() {
    _notifier.dispose();
  }

  @override
  bool get hasListeners => _notifier.hasListeners;

  @override
  void notifyListeners() {
    _notifier.notifyListeners();
  }

  @override
  void removeListener(VoidCallback listener) {
    _notifier.removeListener(listener);
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
  T data(Init<T> widget) {
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

  const Receiver({
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

  @override
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

  @override
  StatusListener<T, K> get widget => super.widget as StatusListener<T, K>;
  // ignore: library_private_types_in_public_api
  _Broadcast<T, K> get broadcast => widget.broadcast as _Broadcast<T, K>;
  Status<K> get status => broadcast._initialized
      ? broadcast._statusNotifier.value
      : const StatusUnknown();

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
      final s = status as _StatusStream<K>;

      return StreamBuilder<Status<K>>(
        stream: s.stream,
        initialData: s.initialValue,
        builder: (context, snapshot) {
          return widget.builder(context, snapshot.requireData);
        },
      );
    }

    return widget.builder(this, status);
  }
}
