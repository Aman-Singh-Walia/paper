class Note {
  String title;
  String content;
  bool favorite;
  DateTime modifiedOn;
  DateTime createdOn;

  Note({
    required this.title,
    required this.content,
    required this.favorite,
    required this.modifiedOn,
    required this.createdOn,
  });
}
