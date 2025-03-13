import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/blocs/bloc.dart';
import 'package:note_app/configs/configs.dart';
import 'package:note_app/ui/screens/screens.dart';
import 'package:note_app/ui/widgets/widgets.dart';

class SplashScreen extends StatelessWidget {
  final Future<FirebaseApp> _initialization =
      Future.delayed(Duration(seconds: 3), () => Firebase.initializeApp());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          FirebaseAuth auth = FirebaseAuth.instance;

          // set firebase database persistance
          FirebaseDatabase.instance.setPersistenceEnabled(true);

          return Scaffold(
            body: BlocListener<SnackbarCubit, SnackbarState>(
              listener: (context, state) {
                if (state is SnackbarError) {
                  showErrorSnackbar(context, state.message);
                } else if (state is SnackbarInfo) {
                  showInfoSnackbar(context, state.message);
                }
              },
              child: auth.currentUser == null ? LoginScreen() : HomeScreen(),
            ),
          );
        }

        return Scaffold(
          body: Center(
            child: Text(
              Word.appName,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
        );
      },
    );
  }
}
