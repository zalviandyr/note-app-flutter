class Note {
  final String? key;
  final String title;
  final String content;
  final DateTime dateTime;
  final int backgroundColor;

  Note({
    this.key,
    required this.title,
    required this.content,
    required this.dateTime,
    required this.backgroundColor,
  });

  Map<String, String> toJson() {
    return {
      'title': title,
      'content': content,
      'dateTime': dateTime.toIso8601String(),
      'backgroundColor': backgroundColor.toString(),
    };
  }

  static List<Note> fromJson(dynamic json) {
    List<Note> notes = [];

    if (json != null) {
      for (var data in json.entries) {
        notes.add(Note(
          key: data.key,
          title: data.value['title'],
          content: data.value['content'],
          dateTime: DateTime.parse(data.value['dateTime']),
          backgroundColor: int.parse(data.value['backgroundColor']),
        ));
      }
    }

    return notes;
  }
}
