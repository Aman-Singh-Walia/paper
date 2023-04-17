import 'package:hive_flutter/hive_flutter.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  bool favorite;

  @HiveField(3)
  DateTime modifiedOn;

  @HiveField(4)
  DateTime createdOn;

  Note({
    required this.title,
    required this.content,
    required this.favorite,
    required this.modifiedOn,
    required this.createdOn,
  });
}
