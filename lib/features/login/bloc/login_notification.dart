part of 'login_bloc.dart';

@Freezed(equal: false)
class LoginNotification with _$LoginNotification {
  factory LoginNotification.insertSuccess({
    required String message,
  }) = _NotificationInsertSuccess;

  factory LoginNotification.insertFailed({
    required String message,
  }) = _NotificationInsertFailed;
}
