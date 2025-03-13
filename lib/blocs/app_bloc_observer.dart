import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // showSnackbar('Something went wrong', isError: true);

    if (kDebugMode) {
      log(
        '----------------------- Error -----------------------',
        error: error,
        stackTrace: stackTrace,
      );
    }

    super.onError(bloc, error, stackTrace);
  }
}
