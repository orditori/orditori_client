import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:orditori/domains/auth/state.dart';
import 'package:orditori/domains/notebooks/state.dart';
import 'package:orditori/domains/search/state_container.dart';
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
    return SearchStateContainer().mount(
      child: TextEditingControllerStateContainer<String>(ctrl).mount(
        child: Builder(builder: (context) {
          return context.subscribeAsync<SearchState>(
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
                        if (value is Loading<SearchState>)
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
            builder: (context, value, child) {
              if (value is Loaded<SearchState>) {
                ctrl.clear();

                SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      final defs = value.state.definitiaons;

                      return DefPicker(defs: defs)
                          .withContainer<NotebookState>(context)
                          .withContainer<AuthState>(context);
                    },
                  );
                });
              }
              return child!;
            },
          );
        }),
      ),
    );
  }
}
