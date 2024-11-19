import 'package:get_it/get_it.dart';
import 'package:ui/injector/modules/bloc_module.dart';
import 'package:ui/injector/modules/dio_module.dart';
import 'package:ui/injector/modules/service_module.dart';

class Injector {
  Injector._();
  static GetIt instance = GetIt.instance;

  static void init() {
    DioModule.setup();
    ServiceModule.init();

    BlocModule.init();
  }

  static void reset() {
    instance.reset();
  }

  static void resetLazySingleton() {
    instance.resetLazySingleton();
  }
}
