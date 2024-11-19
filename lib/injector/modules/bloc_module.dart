import 'package:ui/features/app/bloc/app_bloc.dart';
import 'package:ui/features/login/bloc/login_bloc.dart';
import 'package:ui/injector/injector.dart';

class BlocModule {
  BlocModule._();

  static void init() {
    final injector = Injector.instance;

    injector
      ..registerLazySingleton<AppBloc>(
        () => AppBloc(
          appService: injector(),
          logService: injector(),
        ),
      )
      ..registerFactory<LoginBloc>(
        () => LoginBloc(
          authService: injector(),
        ),
      );
  }
}
