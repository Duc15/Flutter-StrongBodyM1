import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui/core/bloc_core/ui_status.dart';
import 'package:ui/services/auth_service/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';
part 'login_notification.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthService authService}) : super(const LoginState()) {
    _authService = authService;
    on<_ChangeUsername>(_onChangeUsername);
    on<_ChangePassword>(_onChangePassword);
    on<_Login>(_onLogin);
  }

  late final AuthService _authService;

  void _onChangeUsername(_ChangeUsername event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        username: event.username,
      ),
    );
  }

  void _onChangePassword(_ChangePassword event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }

  Future<bool> _onLogin(_Login event, Emitter<LoginState> emit) async {
    try {
      emit(
        state.copyWith(loading: true, notification: null),
      );
      dynamic payload = {
        'username': state.username,
        'password': state.password
      };
      dynamic response = await _authService.login(payload);
      emit(
        state.copyWith(
            loading: false,
            isSuccess: true,
            notification: _NotificationInsertSuccess(
              message: 'Login Successful',
            )),
      );
      return true;
    } catch (e, s) {
      emit(
        state.copyWith(
          loading: false,
          notification: _NotificationInsertFailed(
            message: e.toString(),
          ),
        ),
      );
      return false;
    }
  }
}
