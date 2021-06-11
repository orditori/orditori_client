import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:orditori/domains/notebooks/binding.dart';
import 'package:orditori/domains/search/binding.dart';
import 'package:orditori/domains/search/state.dart';
import 'package:microfrontends/microfrontends.dart';
import 'package:orditori/widgets/def_picker.dart';

class SearchBar extends StatelessWidget {
  final ctrl = TextEditingController();

  search(BuildContext context) {
    final q = Search(context.query<TextQuery<String>>()!.text);
    context.mutation(q);
  }

  @override
  Widget build(BuildContext context) {
    return SearchStateBinding(
      child: TextEditingControllerBinding<String>(
        child: Builder(builder: (context) {
          return context.subscribe<SearchState>(
            child: Padding(
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
                    icon: context.subscribe<SearchState>(
                      builder: (context, value, _) {
                        if (value is LoadingSearchState)
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          );

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
            builder: (context, state, child) {
              if (state is LoadedSearchState) {
                ctrl.clear();

                SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      final search = StateContainer.of<SearchState>(context);
                      final notes = StateContainer.of<NotebookState>(context);
                      final defs = state.definitions;

                      return DefPicker(defs: defs)
                          .withContainer(search)
                          .withContainer(notes);
                    },
                  );
                });
              }
              return child!;
            },
          );
        }),
        controller: ctrl,
      ),
    );
  }
}
