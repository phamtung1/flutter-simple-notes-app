import 'package:flutter/material.dart';
import 'package:simple_notes_app/helpers/data-helper.dart';
import 'package:simple_notes_app/models/note-item.dart';
import 'package:simple_notes_app/ui/components/my_note_list_tile.dart';
import 'package:simple_notes_app/ui/update_note_page.dart';

class MySearchDelegate extends SearchDelegate<String> {
  List<NoteItem> _data;

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<NoteItem>>(
        future: DataHelper.search(query),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Iterable<NoteItem> suggestions =
              query.isEmpty ? <NoteItem>[] : snapshot.data;

          suggestions = suggestions == null ? <NoteItem>[] : suggestions;

          _data = snapshot.data;
          return _SuggestionList(
            query: query,
            suggestions: suggestions,
            onSelected: (NoteItem suggestion) {
              query = suggestion.title;
              showResults(context);
            },
          );
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final String searched = query;
    var matchedNotes = query == null || query.isEmpty
        ? null
        : _data.where((element) => element.title.contains(searched));

    if (matchedNotes == null || matchedNotes.isEmpty) {
      return Center(
        child: Text(
          'No Data',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
        padding: EdgeInsets.all(4.0),
        itemCount: matchedNotes.length,
        itemBuilder: (context, index) {
          var note = matchedNotes.elementAt(index);
          return  MyNoteListTile(
              note: note,
              onTap:  () async {
                final NoteItem result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateNotePage(noteId: note.id)),
                );

                this.showResults(context);
              },
            );
        });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<NoteItem> suggestions;
  final String query;
  final ValueChanged<NoteItem> onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final NoteItem suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          title: RichText(
            text: TextSpan(
              text: suggestion.title.substring(0, query.length),
              style:
                  theme.textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.title.substring(query.length),
                  style: theme.textTheme.subtitle1,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}
