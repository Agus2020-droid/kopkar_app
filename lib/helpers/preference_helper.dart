import 'dart:convert';

import 'package:kopkar_japernosa/models/user_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static String userData = "data_user";
  // static String token = "token_key";

  Future<SharedPreferences> sharePref() async {
    final sharePref = await SharedPreferences.getInstance();
    return sharePref;
  }

  Future _saveString(key, data) async {
    final _pref = await sharePref();
    await _pref.setString(key, data);
  }

  Future<String?> _getString(key) async {
    final _pref = await sharePref();
    return _pref.getString(
      key,
    );
  }

  setUserData(Dataku userDataModel) async {
    final json = userDataModel.toJson();
    final userDataString = jsonEncode(json);
    // print("simpanUser");
    // print(userDataString);
    await _saveString(userData, userDataString);
  }

  Future<Dataku> getUserData() async {
    final user = await _getString(userData);
    // print("data from pref user");
    // print(user);
    final jsonUserData = jsonDecode(user!);
    final userDataModel = Dataku.fromJson(jsonUserData);
    return userDataModel;
  }

  // setToken(String token) async {
  //   final prefs = await getUserData();
  //   final key = prefs.token!.token;

  //   // final value = prefs;
  //   await _saveString(token, key);
  // }

  // Future<Dataku> getToken() async {
  //   final tokenUser = await _getString(token);
  //   final jsonToken = jsonDecode(tokenUser!);
  //   final tokenModel = Dataku.fromJson(jsonToken);
  //   return tokenModel;
  // }
}
