import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/blocs/bloc.dart';
import 'package:note_app/configs/configs.dart';
import 'package:note_app/helper/helper.dart';
import 'package:note_app/models/models.dart';
import 'package:note_app/ui/widgets/widgets.dart';

class DetailNote extends StatefulWidget {
  final Note? note;

  const DetailNote({this.note});

  @override
  _DetailNoteState createState() => _DetailNoteState();
}

class _DetailNoteState extends State<DetailNote> {
  late NoteBloc _noteBloc;
  final GlobalKey<FormState> _form = GlobalKey();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    _noteBloc = BlocProvider.of<NoteBloc>(context);

    // if widget.note exist
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
      _dateTime = widget.note!.dateTime;
    }

    super.initState();
  }

  void _backAction() => Navigator.of(context).pop();

  void _saveAction() {
    if (_form.currentState!.validate()) {
      if (widget.note == null) {
        Note note = Note(
          title: _titleController.text.trim(),
          content: _contentController.text.trim(),
          dateTime: DateTime.now(),
          backgroundColor: Helper.getNoteBackgroundColor().value,
        );

        _noteBloc.add(NoteAdd(note: note));
      } else {
        Note note = Note(
          key: widget.note!.key,
          title: _titleController.text.trim(),
          content: _contentController.text.trim(),
          dateTime: DateTime.now(),
          backgroundColor: widget.note!.backgroundColor,
        );

        _noteBloc.add(NoteUpdate(note: note));
      }

      _noteBloc.add(NoteFetch()); // re-fetch
    }
  }

  void _noteListener(BuildContext context, NoteState state) {
    if (state is NoteAddSuccess || state is NoteUpdateSuccess) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteBloc, NoteState>(
      listener: _noteListener,
      child: Scaffold(
        extendBody: true,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).primaryColor,
              automaticallyImplyLeading: false,
              elevation: 0.0,
              leading: Container(
                margin: const EdgeInsets.only(left: 10.0, top: 10.0),
                child: SecondaryButton(
                  onPressed: _backAction,
                  icon: Icons.chevron_left,
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 10.0, top: 10.0),
                  child: BlocBuilder<NoteBloc, NoteState>(
                    builder: (context, state) {
                      if (state is NoteLoading) {
                        return SecondaryButton.loading(iconSize: 27.0);
                      }

                      return SecondaryButton(
                        onPressed: _saveAction,
                        icon: Icons.save,
                        iconSize: 27.0,
                      );
                    },
                  ),
                ),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 15.0, bottom: 50.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Form(
                      key: _form,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _titleController,
                            maxLines: null,
                            style: Theme.of(context).textTheme.displayMedium,
                            validator: Validation.inputRequired,
                            decoration: InputDecoration(
                              hintText: 'Judul',
                              hintStyle: Theme.of(context).textTheme.bodyMedium,
                              fillColor: Theme.of(context).primaryColor,
                            ),
                          ),
                          Divider(
                              color: Theme.of(context).colorScheme.secondary),
                          TextFormField(
                            controller: _contentController,
                            maxLines: null,
                            style: Theme.of(context).textTheme.bodyMedium,
                            validator: Validation.inputRequired,
                            decoration: InputDecoration(
                              hintText: 'Isi note',
                              hintStyle: Theme.of(context).textTheme.bodyMedium,
                              fillColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          padding: const EdgeInsets.symmetric(vertical: 7.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(20.0),
          ),
          child: Text(
            Helper.formatTime(_dateTime),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
