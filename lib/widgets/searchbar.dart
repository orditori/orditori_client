import 'package:flutter/material.dart';
import 'package:microfrontends/microfrontends.dart';

import 'loading_indicator.dart';

abstract class SearchQuery {}

class Search extends Mutation<String> {
  Search(String payload) : super(payload);
}

class ResetSearch extends Mutation<Null> {
  ResetSearch() : super(null);
}

final ctrl = TextEditingController();

class SearchBar<T> extends StatelessWidget {
  search(BuildContext context) {
    final query = context.query<TextQuery<SearchQuery>>()!;
    final m = Search(query.text);
    context.mutation(m);
  }

  @override
  Widget build(BuildContext context) {
    final clear = Effect<Async<T>>((_, __) => ctrl.clear())
      ..whenType<Loaded<T>>();

    clear.bind(context);

    return TextEditingControllerStateContainer<SearchQuery>(ctrl).mount(
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: ctrl,
                keyboardAppearance: Brightness.dark,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Type a word',
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => search(context),
                textInputAction: TextInputAction.search,
              ),
            ),
            ElevatedButton.icon(
              icon: context.subscribeAsync<T>(
                builder: (context, value, _) {
                  if (value is Loading<T>) {
                    return const Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: LoadingIndicator(),
                    );
                  }

                  return Icon(Icons.search);
                },
              ),
              label: Text('Search', style: TextStyle(height: 1)),
              onPressed: () {
                search(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
