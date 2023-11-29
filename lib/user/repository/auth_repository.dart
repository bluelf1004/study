import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flutter/common/const/data.dart';
import 'package:study_flutter/common/dio/dio.dart';
import 'package:study_flutter/common/model/login_response.dart';
import 'package:study_flutter/common/model/token_response.dart';
import 'package:study_flutter/common/utils/data_utils.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return AuthRepository(dio: dio, baseUrl: 'http://$ip/auth');
});

class AuthRepository {
  final Dio dio;
  final String baseUrl;

  AuthRepository({
    required this.dio,
    required this.baseUrl,
  });

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final serialized = DataUtils.plainToBase64('$username:$password');

    final res = await dio.post(
      '$baseUrl/login',
      options: Options(headers: {'authorization': 'Basic $serialized'}),
    );

    return LoginResponse.fromJson(res.data);
  }

  Future<TokenResponse> token() async {
    final res = await dio.post(
      '$baseUrl/token',
      options: Options(headers: {'refreshToken': 'true'}),
    );

    return TokenResponse.fromJson(res.data);
  }
}
