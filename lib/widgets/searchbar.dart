import 'package:fetch/fetch.dart';
import 'package:flutter/material.dart';
import 'package:orditori/models/definition.dart';

import 'def_picker.dart';

class SearchBar extends StatefulWidget {
  final Function(String word, Definition def) onPicked;

  const SearchBar({Key? key, required this.onPicked}) : super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool isSearching = false;
  final ctrl = TextEditingController();

  _search() async {
    if (ctrl.text.isEmpty) return;

    setState(() {
      isSearching = true;
    });

    try {
      final data = await fetch('/definitions?query=${ctrl.text}')
          .then((res) => res.json())
          .then(
            (json) => List<Definition>.from(
              json.map(
                (d) => Definition.fromJson(d),
              ),
            ),
          );
      final word = ctrl.text;

      ctrl.clear();
      final def = await showModalBottomSheet(
          context: context,
          builder: (context) {
            return DefPicker(defs: data);
          });

      if (def != null) {
        widget.onPicked(word, def);
      }
    } catch (err) {
      print(err);
    }

    setState(() {
      isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              onSubmitted: (_) => _search(),
              textInputAction: TextInputAction.search,
            ),
          ),
          ElevatedButton.icon(
            icon: isSearching
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  )
                : Icon(Icons.search),
            label: Text(
              'Search',
              style: TextStyle(height: 1),
            ),
            onPressed: _search,
          )
        ],
      ),
    );
  }
}
