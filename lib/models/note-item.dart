class NoteItem {
  final int id;
  final String title;
  final String content;

  NoteItem({this.id, this.title, this.content});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}