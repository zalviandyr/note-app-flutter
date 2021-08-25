import 'package:flutter/material.dart';
import 'package:note_app/configs/configs.dart';
import 'package:note_app/helper/helper.dart';
import 'package:note_app/models/models.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final Function(Note) onTap;
  final Function(Note) onDeleteTap;

  const NoteCard(
      {required this.note, required this.onTap, required this.onDeleteTap});

  void _deleteDialogAction(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            Word.deleteNote,
            style: Theme.of(context).textTheme.headline4,
          ),
          content: Text(
            Word.deleteNoteConfirm,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                Word.no,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            const SizedBox(width: 10.0),
            MaterialButton(
              onPressed: () {
                onDeleteTap(note);

                Navigator.of(context).pop();
              },
              color: Pallette.danger,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(Word.yes),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            color: Color(note.backgroundColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(height: 10.0),
              Text(
                Helper.formatTime(note.dateTime),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onTap(note),
              onLongPress: () => _deleteDialogAction(context),
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
        ),
      ],
    );
  }
}
