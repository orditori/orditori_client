import 'package:fetch/fetch.dart';
import 'package:microfrontends/microfrontends.dart';
import 'package:orditori/domains/search/state.dart';
import 'package:orditori/models/definition.dart';

class SearchStateContainer extends AsyncStateContainer<SearchState> {
  SearchStateContainer() : super(Uninitialized<SearchState>());

  @override
  queries(StateContainerContext context) {
    query(
      (ctrl, value, arg) => (state as Loaded<SearchState>).state.definitiaons,
    );
    return super.queries(context);
  }

  @override
  mutations(StateContainerContext context) {
    mutation<Search>((ctrl, state, mutation) {
      final text = mutation!.payload;
      if (text.isEmpty) return state;

      ctrl.load(() async {
        final data = await fetch('/definitions?query=$text')
            .then((res) => res.json())
            .then(
              (json) => List<Definition>.from(
                json.map((d) => Definition.fromJson(d)),
              ),
            );

        return SearchState(data);
      });

      return state;
    });
    return super.mutations(context);
  }
}
