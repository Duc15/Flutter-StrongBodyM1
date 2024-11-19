part of 'login_bloc.dart';

@Freezed()
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(UIInitial()) UIStatus status,
    LoginNotification? notification,
    @Default(false) bool loading,
    @Default('') String username,
    @Default('') String password,
    @Default(false) bool isSuccess,
  }) = _LoginState;
}