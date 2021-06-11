import 'package:microfrontends/microfrontends.dart';
import 'package:orditori/models/definition.dart';

class SearchState {}

class LoadingSearchState extends SearchState {}

class LoadedSearchState extends SearchState {
  final List<Definition> definitions;

  LoadedSearchState(this.definitions);
}

class Search extends Mutation<String> {
  Search(String payload) : super(payload);
}
