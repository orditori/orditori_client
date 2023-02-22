import 'package:flutter/material.dart';
import 'package:orditori/framework.dart';

final fn = FocusNode();

class SearchBar<T> extends StatelessWidget with Init<TextEditingController> {
  final Broadcast<String, T> querySubmit;
  final LateReceive<TextEditingValue> query;
  final VoidCallback onExit;

  const SearchBar({
    Key? key,
    required this.querySubmit,
    required this.query,
    required this.onExit,
  }) : super(key: key);

  @override
  TextEditingController init() {
    return TextEditingController()..bind(query);
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = context.data(this);

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            fn.unfocus();
            onExit();
          },
        ),
        Expanded(
          child: TextField(
            focusNode: fn,
            controller: ctrl,
            autofocus: true,
            onSubmitted: (query) => querySubmit.write(query),
            decoration: const InputDecoration(hintText: 'Search'),
            textInputAction: TextInputAction.search,
          ),
        ),
        Receiver(
          receive: query,
          builder: (context) {
            return AnimatedOpacity(
              opacity: query.read().text.isEmpty ? 0 : 1,
              duration: const Duration(milliseconds: 200),
              child: TextButton(
                child: const Text('Clear'),
                onPressed: () {
                  ctrl.clear();
                },
              ),
            );
          },
        )
      ],
    );
  }
}
