import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/blocs/bloc.dart';
import 'package:note_app/configs/configs.dart';
import 'package:note_app/models/models.dart';
import 'package:note_app/ui/screens/screens.dart';
import 'package:note_app/ui/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NoteBloc _noteBloc;

  @override
  void initState() {
    _noteBloc = BlocProvider.of<NoteBloc>(context);

    _noteBloc.add(NoteFetch());

    super.initState();
  }

  void _logoutAction() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => SplashScreen()),
      (route) => false,
    );
  }

  void _addNoteAction() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => DetailNote()),
    );
  }

  void _noteCardAction(Note note) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => DetailNote(note: note)),
    );
  }

  void _noteCardDeleteAction(Note note) {
    _noteBloc.add(NoteDelete(note: note));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(Word.appName),
            backgroundColor: Colors.transparent,
            actions: [
              Container(
                margin: const EdgeInsets.only(top: 10.0, right: 10.0),
                child: SecondaryButton(
                  onPressed: _logoutAction,
                  icon: Icons.logout,
                  iconSize: 27.0,
                ),
              ),
            ],
          ),
          BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state is NoteFetchSuccess) {
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  sliver: SliverMasonryGrid.count(
                    crossAxisCount: 4,
                    childCount: state.notes.length + 1,
                    mainAxisSpacing: 7.0,
                    crossAxisSpacing: 7.0,
                    itemBuilder: (context, index) {
                      if (index > 0) {
                        Note note = state.notes[index - 1];

                        return NoteCard(
                          note: note,
                          onTap: _noteCardAction,
                          onDeleteTap: _noteCardDeleteAction,
                        );
                      }

                      return Text(Word.deleteNoteInfo);
                    },
                  ),
                );
              }

              return SliverToBoxAdapter(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNoteAction,
        child: Icon(
          Icons.add,
          size: 36.0,
          color: Theme.of(context).primaryColorLight,
        ),
      ),
    );
  }
}
