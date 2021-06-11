import 'package:fetch/fetch.dart';
import 'package:flutter/widgets.dart';
import 'package:microfrontends/microfrontends.dart';
import 'package:orditori/domains/search/state.dart';
import 'package:orditori/models/definition.dart';

class SearchStateBinding extends Binding<SearchState> {
  SearchStateBinding({required Widget child}) : super(child: child);

  @override
  StateContainer<SearchState> create(BuildContext context) {
    return container<SearchState>(SearchState())
      ..mutation<Search>((ctrl, state, mutation) {
        if (mutation!.payload.isEmpty) return state;
        final text = mutation.payload;

        ctrl.run(() async* {
          yield LoadingSearchState();

          final data = await fetch('/definitions?query=$text')
              .then((res) => res.json())
              .then(
                (json) => List<Definition>.from(
                  json.map((d) => Definition.fromJson(d)),
                ),
              );

          yield LoadedSearchState(data);
        });

        return state;
      });
  }
}
