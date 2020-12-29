class NoteItem {
  int id;
  String title;
  String content;
  bool deleted;
  int modifiedDate;

  NoteItem({this.id, this.title, this.content, this.deleted, this.modifiedDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'deleted': deleted,
      'modifiedDate': modifiedDate
    };
  }
}