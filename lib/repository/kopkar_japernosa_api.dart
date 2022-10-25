import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kopkar_japernosa/contents/api_url.dart';
import 'package:kopkar_japernosa/helpers/preference_helper.dart';
import 'package:kopkar_japernosa/models/network_response.dart';
import 'package:kopkar_japernosa/models/user_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KopkarJapernosaApi {
  Dio dioApi() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      // headers: {
      //   "Authorization": "Bearer 105|IOhQG0ejUm0rZYx66b4uwEksbM0svpQqfraNEDtE",
      //   HttpHeaders.contentTypeHeader: "application/json"
      // },
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
      // final token = await PreferenceHelper().getUserData();
      // final tok = token.token!.token;
      // print('Token REquest');
      // print(tok);
      return NetworkResponse.success(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        return NetworkResponse.error(data: null, message: "request timeout");
      }
      return NetworkResponse.error(data: null, message: "request error dio");
    } catch (e) {
      return NetworkResponse.error(data: null, message: "other error");
    }
  }

  Future<NetworkResponse> _postRequest({endpoint, body}) async {
    final token = await PreferenceHelper().getUserData();
    final tok = token.token!.token;
    final statusnya = token.user!.id;
    try {
      final dio = dioApi();
      final result = await dio.post(endpoint,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "Authorization": "Bearer ${tok}"
          }),
          data: body);
      return NetworkResponse.success(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        return NetworkResponse.error(data: null, message: "request timeout");
      }
      return NetworkResponse.error(data: null, message: "request error dio");
    } catch (e) {
      return NetworkResponse.error(data: null, message: "other error");
    }
  }

  Future<NetworkResponse> getSimpanan() async {
    final data = await PreferenceHelper().getUserData();

    final result = await _getRequest(
      endpoint: ApiUrl.simpanans,
      param: {
        "nik_ktp": data.user!.nikKtp,
      },
    );
    return result;
  }

  Future<NetworkResponse> getPenarikan() async {
    final data = await PreferenceHelper().getUserData();

    final result = await _getRequest(
      endpoint: ApiUrl.penarikans,
      param: {
        "nik_ktp": data.user!.nikKtp,
      },
    );
    return result;
  }

  Future<NetworkResponse> getTotalSimpanan() async {
    final data = await PreferenceHelper().getUserData();

    final result = await _getRequest(
      endpoint: ApiUrl.totalSimpanan,
      param: {
        "nik_ktp": data.user!.nikKtp,
      },
    );
    return result;
  }

  Future<NetworkResponse> getShu() async {
    final data = await PreferenceHelper().getUserData();

    final result = await _getRequest(
      endpoint: ApiUrl.shu,
      param: {
        "nik_ktp": data.user!.nikKtp,
      },
    );
    return result;
  }

  Future<NetworkResponse> getPinjaman() async {
    final data = await PreferenceHelper().getUserData();

    final result = await _getRequest(
      endpoint: ApiUrl.pinjamans,
      param: {
        "nik_ktp": data.user!.nikKtp,
      },
    );
    return result;
  }

  Future<NetworkResponse> getSisaPinjaman() async {
    final data = await PreferenceHelper().getUserData();

    final result = await _getRequest(
      endpoint: ApiUrl.sisaPinjamans,
      param: {
        "nik_ktp": data.user!.nikKtp,
      },
    );
    return result;
  }

  Future<NetworkResponse> getPiutang() async {
    final data = await PreferenceHelper().getUserData();

    final result = await _getRequest(
      endpoint: ApiUrl.piutangs,
      param: {
        "nik_ktp": data.user!.nikKtp,
      },
    );
    return result;
  }

  Future<NetworkResponse> getSaldoSimpanan() async {
    final data = await PreferenceHelper().getUserData();

    final result = await _getRequest(
      endpoint: ApiUrl.saldoSimpanan,
      param: {
        "nik_ktp": data.user!.nikKtp,
      },
    );
    return result;
  }

  Future<NetworkResponse> getPinjamanDetail(id) async {
    // final data = await PreferenceHelper().getUserData();

    final result = await _getRequest(
      endpoint: ApiUrl.pinjamanDetails,
      param: {
        "no_pinjaman": id,
      },
    );
    return result;
  }

  Future<NetworkResponse> getShuDetail(id) async {
    final result = await _getRequest(
      endpoint: ApiUrl.shuDetails,
      param: {
        "id_shu": id,
      },
    );
    return result;
  }

  Future<NetworkResponse> getPegawai() async {
    final data = await PreferenceHelper().getUserData();

    final result = await _getRequest(
      endpoint: ApiUrl.pegawais,
      param: {
        "nik_ktp": data.user!.nikKtp,
      },
    );
    return result;
  }

  Future<NetworkResponse> postLogout() async {
    final result = await _postRequest(endpoint: ApiUrl.logout);
    return result;
  }

  Future<NetworkResponse> postPinjaman(body) async {
    final result = await _postRequest(
      endpoint: ApiUrl.tambahPinjamans,
      body: body,
    );
    return result;
  }

  Future<NetworkResponse> postPenarikan(body) async {
    final result = await _postRequest(
      endpoint: ApiUrl.penarikanDanas,
      body: body,
    );
    return result;
  }

  Future<NetworkResponse> getAngsuran(id) async {
    final result = await _getRequest(
      endpoint: ApiUrl.angsurans,
      param: {
        "no_pinjaman": id,
      },
    );
    return result;
  }

  Future<NetworkResponse> getBanner() async {
    final result = await _getRequest(
      endpoint: ApiUrl.banners,
      // param: {
      // },
    );
    return result;
  }
}
