import 'package:flutter/material.dart';
import 'package:orditori/framework.dart';

import 'package:orditori/widgets/loading_indicator.dart';

class SearchButton<T> extends StatelessWidget {
  final Receive<TextEditingValue> query;
  final Broadcast<String, T> submit;

  const SearchButton({
    Key? key,
    required this.query,
    required this.submit,
  }) : super(key: key);

  void onSubmit() {
    submit.write(query.read().text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Receiver(
        receive: query,
        builder: (context) {
          return ElevatedButton(
            onPressed: query.read().text.isEmpty ? null : onSubmit,
            child: StatusListener(
              broadcast: submit,
              builder: (context, status) {
                final isLoading = status is StatusInProgress;

                return SizedBox(
                  height: 16,
                  width: isLoading ? 16 : null,
                  child: isLoading
                      ? const LoadingIndicator(
                          color: Colors.white,
                          strokeWidth: 1,
                        )
                      : const Text('Search'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
