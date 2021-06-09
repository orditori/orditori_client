import 'package:orditori/models/notebookentry.dart';

class NotebookState {
  final int id;
  final List<NotebookEntry> entries;

  NotebookState({required this.id, required this.entries});

  NotebookState copyWith({
    int? id,
    List<NotebookEntry>? entries,
  }) {
    return NotebookState(
      id: id ?? this.id,
      entries: entries ?? this.entries,
    );
  }
}

class LoadingNotebookState extends NotebookState {
  LoadingNotebookState() : super(id: -1, entries: []);
}
