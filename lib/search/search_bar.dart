import 'package:flutter/material.dart';
import 'package:orditori/framework.dart';

class SearchBar extends StatelessWidget with Init<TextEditingController> {
  final Broadcast<String> querySubmit;
  final LateReceive<TextEditingValue> query;

  const SearchBar({
    Key? key,
    required this.querySubmit,
    required this.query,
  }) : super(key: key);

  @override
  TextEditingController init() {
    return TextEditingController()..bind(query);
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = context.data(this);

    return Padding(
      padding: const EdgeInsets.all(16.0).copyWith(top: 0),
      child: Row(
        children: [
          BackButton(),
          Expanded(
            child: TextField(
              controller: ctrl,
              autofocus: true,
              onSubmitted: (query) => querySubmit.write(query),
              decoration: InputDecoration(hintText: 'Search'),
            ),
          ),
          Receiver(
            receive: query,
            builder: (context) {
              return AnimatedOpacity(
                opacity: query.read().text.isEmpty ? 0 : 1,
                duration: const Duration(milliseconds: 200),
                child: TextButton(
                  child: Text('Clear'),
                  onPressed: () {
                    ctrl.clear();
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
