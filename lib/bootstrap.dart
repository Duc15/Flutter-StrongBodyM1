import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:ui/core/bloc_core/bloc_observer.dart';
import 'package:ui/features/app/view/app.dart';
import 'package:ui/injector/injector.dart';

Future<void> bootstrap({
  AsyncCallback? firebaseInitialization,
  AsyncCallback? flavorConfiguration,
}) async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await firebaseInitialization?.call();
    Logger.level = Level.verbose;
    await flavorConfiguration?.call();

    Injector.init();

    await Injector.instance.allReady();

    Bloc.observer = AppBlocObserver();

    runApp(const App());
  }, (error, stack) {
    print(error);
    print(stack);
  });
}
