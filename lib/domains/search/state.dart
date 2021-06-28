import 'package:microfrontends/microfrontends.dart';
import 'package:orditori/models/definition.dart';

class DefinitionsSearchState extends Async<DefinitionsSearchState> {
  final List<Definition> definitiaons;

  DefinitionsSearchState(this.definitiaons);
}
