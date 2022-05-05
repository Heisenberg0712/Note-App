// To parse this JSON data, do
//
//     final note = noteFromJson(jsonString);

import 'dart:convert';

Note noteFromJson(String str) => Note.fromJson(json.decode(str));

String noteToJson(Note data) => json.encode(data.toJson());

class Note {
  Note({
    this.id = "",
    required this.color,
    required this.content,
    required this.dateTime,
    required this.title,
  });
  String id;
  String color;
  String content;
  String dateTime;
  String title;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        color: json["color"],
        content: json["content"],
        dateTime: json["dateTime"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "color": color,
        "content": content,
        "dateTime": dateTime,
        "title": title,
      };
}
