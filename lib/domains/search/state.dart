import 'package:microfrontends/microfrontends.dart';
import 'package:orditori/models/definition.dart';

class SearchState extends Async<SearchState> {
  final List<Definition> definitiaons;

  SearchState(this.definitiaons);
}

class Search extends Mutation<String> {
  Search(String payload) : super(payload);
}

class ResetSearch extends Mutation<Null> {
  ResetSearch() : super(null);
}
