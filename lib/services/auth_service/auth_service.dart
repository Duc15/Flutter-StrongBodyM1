import 'dart:async';

import 'package:dio/dio.dart';

class AuthService {

  const AuthService({
    required this.dio
  });
  final Dio dio;
  // final dio = Injector.instance<Dio>();

  Future<dynamic> login(Map<String, dynamic> data) async {
    try {
      final res = await dio.post('/login', data: data);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
