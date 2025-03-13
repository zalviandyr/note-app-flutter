import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/blocs/bloc.dart';
import 'package:note_app/configs/configs.dart';
import 'package:note_app/firebase_options.dart';
import 'package:note_app/ui/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // bloc observer
  Bloc.observer = AppBlocObserver();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
          scaffoldBackgroundColor: Pallette.primaryDark,
          primaryColor: Pallette.primaryDark,
          primaryColorLight: Pallette.primaryWhite,
          textTheme: TextTheme(
            displayLarge: TextStyle(
              color: Pallette.primaryWhite,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
            displayMedium: TextStyle(
              color: Pallette.primaryWhite,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            displaySmall: TextStyle(
              color: Pallette.primaryDark,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: TextStyle(
              color: Pallette.primaryWhite,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: TextStyle(
              color: Pallette.primaryDark,
            ),
            bodyMedium: TextStyle(
              color: Pallette.primaryWhite,
            ),
            titleMedium: TextStyle(
              color: Pallette.primaryDark,
            ),
            titleSmall: TextStyle(
              color: Pallette.danger,
            ),
            labelLarge: TextStyle(
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
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Pallette.primaryWhite,
            brightness: Brightness.dark,
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
