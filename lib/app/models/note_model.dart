class NoteModel {
  int? id;
  String? title;
  String? content;
  DateTime createdAt = DateTime.now();

  NoteModel({
    this.id,
    this.title = "(Unnamed Note)",
    this.content = '-',
  });
}
