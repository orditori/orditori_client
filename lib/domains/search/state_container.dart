import 'package:fetch/fetch.dart';
import 'package:microfrontends/microfrontends.dart';
import 'package:orditori/domains/search/state.dart';
import 'package:orditori/models/definition.dart';
import 'package:orditori/widgets/searchbar.dart';

class SearchStateContainer extends AsyncStateContainer<DefinitionsSearchState> {
  SearchStateContainer() : super(Uninitialized<DefinitionsSearchState>());

  @override
  queries(StateContainerContext context) {
    query(
      (ctrl, value, arg) =>
          (state as Loaded<DefinitionsSearchState>).state.definitiaons,
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

        return DefinitionsSearchState(data);
      });

      return state;
    });

    mutation<ResetSearch>(
        (ctrl, value, arg) => Uninitialized<DefinitionsSearchState>());

    return super.mutations(context);
  }
}
