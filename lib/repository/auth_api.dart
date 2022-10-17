import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:kopkar_japernosa/contents/api_url.dart';
import 'package:kopkar_japernosa/helpers/preference_helper.dart';
// import 'package:kopkar_japernosa/helpers/user_email.dart';
import 'package:kopkar_japernosa/models/network_response.dart';
import 'package:kopkar_japernosa/models/user_login.dart';

class AuthApi {
  Dio dioApi() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      headers: {
        "Authorization": ApiUrl.apiKey,
        HttpHeaders.contentTypeHeader: "application/json"
      },
      responseType: ResponseType.json,
    );

    final dio = Dio(options);

    return dio;
  }

  Future<NetworkResponse> _getRequest({endpoint, param}) async {
    final token = await PreferenceHelper().getUserData();
    final tok = token.token!.token;
    final statusnya = token.user!.id;
    print("Status");
    print(statusnya);
    try {
      final dio = dioApi();
      final result = await dio.get(endpoint,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "Authorization": "Bearer ${tok}"
          }),
          queryParameters: param);
      // return result.data;
      return NetworkResponse.success(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        // print("eror timeout");
        return NetworkResponse.error(data: null, message: "request timeout");
      }
      // print("eror Dio");

      return NetworkResponse.error(data: null, message: "request timeout");
    } catch (e) {
      // print("eror Lainnya");
      return NetworkResponse.error(data: null, message: "other error");
    }
  }

  Future<NetworkResponse> _postRequest({endpoint, body}) async {
    // final token = await PreferenceHelper().getUserData();
    // final tok = token.token!.token;
    // final statusnya = token.user!.id;
    try {
      final dio = dioApi();
      final result = await dio.post(endpoint,
          // options: Options(headers: {
          //   HttpHeaders.contentTypeHeader: "application/json",
          //   "Authorization": "Bearer ${tok}"
          // }),
          data: body);
      // return result.data;
      return NetworkResponse.success(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        // print("eror timeout");
        return NetworkResponse.error(data: null, message: "request timeout");
      }
      // print("eror Dio");

      return NetworkResponse.error(data: null, message: "request error dio");
    } catch (e) {
      // print("eror Lainnya");
      return NetworkResponse.error(data: null, message: "other error");
    }
  }

  Future<NetworkResponse> postLogin(body) async {
    final result = await _postRequest(endpoint: ApiUrl.login, body: body);
    // print(result);
    return result;
  }

  // Future<NetworkResponse> postRegister(body) async {
  //   final result = await _postRequest(
  //     endpoint: ApiUrl.userRegistrasi,
  //     body: body,
  //   );
  //   return result;
  // }

  // Future<NetworkResponse> postUpdateUSer(body) async {
  //   final result = await _postRequest(
  //     endpoint: ApiUrl.userUpdateProfile,
  //     body: body,
  //   );
  //   return result;
  // }

}
