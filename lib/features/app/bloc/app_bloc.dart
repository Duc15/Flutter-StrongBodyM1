import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui/configs/app_config.dart';
import 'package:ui/core/bloc_core/ui_status.dart';
import 'package:ui/generated/l10n.dart';
import 'package:ui/services/app_service/app_service.dart';
import 'package:ui/services/log_service/log_service.dart';

part 'app_event.dart';
part 'app_state.dart';
part 'app_bloc.freezed.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AppService appService,
    required LogService logService,
  }) : super(const AppState()) {
    _appService = appService;
    _logService = logService;
    on<_Loaded>(_onLoaded);
    on<_LocaleChanged>(_onLocaleChanged);
  }

  late final AppService _appService;
  late final LogService _logService;

  FutureOr<void> _onLoaded(
    _Loaded event,
    Emitter<AppState> emit,
  ) {
    try {
      emit(
        state.copyWith(
          status: const UILoading(),
        ),
      );

      final bool darkMode = _appService.isDarkMode;
      final bool isFirstUse = _appService.isFirstUse;
      final String locale = _appService.locale;

      emit(
        state.copyWith(
          status: const UILoadSuccess(),
          isDarkMode: darkMode,
          isFirstUse: isFirstUse,
          locale: locale,
        ),
      );
    } catch (e, s) {
      _logService.e('AppBloc load failed', e, s);
      emit(
        state.copyWith(
          status: UILoadFailed(message: e.toString()),
        ),
      );
    }
  }

  FutureOr<void> _onLocaleChanged(
    _LocaleChanged event,
    Emitter<AppState> emit,
  ) async {
    if (state.locale != event.locale) {
      await S.load(Locale(event.locale));

      await _appService.setLocale(locale: event.locale);

      emit(
        state.copyWith(
          locale: event.locale,
        ),
      );
    }
  }
}
