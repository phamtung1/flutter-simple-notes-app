class NoteItem {
  int id;
  String title;
  String content;

  NoteItem({this.id, this.title, this.content});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}