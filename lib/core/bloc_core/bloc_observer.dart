import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/injector/injector.dart';
import 'package:ui/services/log_service/log_service.dart';

class AppBlocObserver extends BlocObserver {
  AppBlocObserver() {
    _logService = Injector.instance<LogService>();
  }

  late final LogService _logService;

  @override
  void onCreate(BlocBase bloc) {
    _logService.i('BLoC: ${bloc.runtimeType} created');
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    _logService.i('Event: ${event.runtimeType} added');
    super.onEvent(bloc, event);
  }
}
