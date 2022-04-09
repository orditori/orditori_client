import 'package:flutter/material.dart';
import 'package:orditori/framework.dart';
import 'package:orditori/widgets/loading_indicator.dart';

class SearchButton extends StatelessWidget {
  final Receive<TextEditingValue> query;
  final Receive<Status> searchStatus;
  final Broadcast<String> submit;

  const SearchButton({
    Key? key,
    required this.query,
    required this.searchStatus,
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
            child: Receiver(
              receive: searchStatus,
              builder: (context) {
                final isLoading = searchStatus.read() is StatusInProgress;

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
