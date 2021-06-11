import 'package:fetch/fetch.dart';
import 'package:flutter/widgets.dart';
import 'package:microfrontends/microfrontends.dart';
import 'package:orditori/domains/search/state.dart';
import 'package:orditori/models/definition.dart';

class SearchStateBinding extends AsyncStateBinding<SearchState> {
  SearchStateBinding({required Widget child}) : super(child: child);

  @override
  StateContainer<Async<SearchState>> create(BuildContext context) {
    return container(Uninitialized<SearchState>())
      ..query<List<Definition>>((ctrl, state, params) =>
          (state as Loaded<SearchState>).state.definitiaons)
      ..mutation<Search>((ctrl, state, mutation) {
        final text = mutation!.payload;
        if (text.isEmpty) return state;

        ctrl.run(() async* {
          yield Loading<SearchState>();

          final data = await fetch('/definitions?query=$text')
              .then((res) => res.json())
              .then(
                (json) => List<Definition>.from(
                  json.map((d) => Definition.fromJson(d)),
                ),
              );

          yield Loaded(SearchState(data));
        });

        return state;
      });
  }
}
