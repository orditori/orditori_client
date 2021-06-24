import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:orditori/domains/auth/state.dart';
import 'package:orditori/domains/notebooks/state.dart';
import 'package:orditori/domains/search/state_container.dart';
import 'package:orditori/domains/search/state.dart';
import 'package:microfrontends/microfrontends.dart';
import 'package:orditori/widgets/def_picker.dart';

import 'loading_indicator.dart';

abstract class SearchQuery {}

final ctrl = TextEditingController();

class SearchBar extends StatelessWidget {
  search(BuildContext context) {
    final query = context.query<TextQuery<SearchQuery>>()!;
    final m = Search(query.text);
    context.mutation(m);
  }

  showDefsPicker(BuildContext context, SearchState state) => (_) async {
        await showModalBottomSheet(
          context: context,
          builder: (_) {
            final defs = state.definitiaons;

            return DefPicker(defs: defs)
                .withContainer<NotebookState>(context)
                .withContainer<AuthState>(context);
          },
        );

        context.mutation(ResetSearch());
      };

  @override
  Widget build(BuildContext context) {
    return TextEditingControllerStateContainer<SearchQuery>(ctrl).mount(
      child: SearchStateContainer().mount(
        builder: (context) => context.subscribeAsync<SearchState>(
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
                  icon: context.subscribeAsync<SearchState>(
                    builder: (context, value, _) {
                      if (value is Loading<SearchState>) {
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
          builder: (context, value, child) {
            if (value is Loaded<SearchState>) {
              ctrl.clear();
              SchedulerBinding.instance!.addPostFrameCallback(
                showDefsPicker(context, value.state),
              );
            }
            return child!;
          },
        ),
      ),
    );
  }
}
