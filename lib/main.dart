import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/blocs/bloc.dart';
import 'package:note_app/configs/configs.dart';
import 'package:note_app/ui/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SnackbarCubit _snackbarCubit = SnackbarCubit();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SnackbarCubit>(create: (_) => _snackbarCubit),
        BlocProvider<AuthBloc>(create: (_) => AuthBloc(_snackbarCubit)),
        BlocProvider<NoteBloc>(create: (_) => NoteBloc(_snackbarCubit)),
      ],
      child: MaterialApp(
        title: 'Note App',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Pallette.primaryDark,
          primaryColor: Pallette.primaryDark,
          primaryColorLight: Pallette.primaryWhite,
          accentColor: Pallette.primaryWhite,
          buttonColor: Pallette.info,
          textTheme: TextTheme(
            headline1: TextStyle(
              color: Pallette.primaryWhite,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
            headline2: TextStyle(
              color: Pallette.primaryWhite,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            headline3: TextStyle(
              color: Pallette.primaryDark,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
            headline4: TextStyle(
              color: Pallette.primaryWhite,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
            bodyText1: TextStyle(
              color: Pallette.primaryDark,
            ),
            bodyText2: TextStyle(
              color: Pallette.primaryWhite,
            ),
            subtitle1: TextStyle(
              color: Pallette.primaryDark,
            ),
            subtitle2: TextStyle(
              color: Pallette.danger,
            ),
            button: TextStyle(
              color: Pallette.primaryWhite,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(color: Pallette.primaryDark),
            errorStyle: TextStyle(color: Pallette.danger),
            fillColor: Pallette.primaryWhite,
            filled: true,
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        home: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarIconBrightness: Theme.of(context).brightness,
          ),
          child: SplashScreen(),
        ),
      ),
    );
  }
}
