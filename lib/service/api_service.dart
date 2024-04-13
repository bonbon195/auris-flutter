import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ApiService {
  static late SharedPreferences prefs;
  static late PocketBase _pb;
  static const String _apiURL = String.fromEnvironment('API_URL');

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    AsyncAuthStore store = AsyncAuthStore(
        save: (String data) => prefs.setString('pb_auth', data),
        initial: prefs.getString('pb_auth'));
    _pb = PocketBase(_apiURL, authStore: store);
  }

  static bool checkAuth() {
    return _pb.authStore.isValid;
  }

  static Future<RecordAuth> authWithPassword(
      String email, String password) async {
    return await _pb.collection('users').authWithPassword(email, password);
  }

  static Future<RecordAuth> authWithProvider(
      {required String provider, required BuildContext context}) async {
    return await _pb.collection('users').authWithOAuth2(provider, (url) async {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      }
    });
  }

  static Future<void> signOut() async {
    _pb.authStore.clear();
  }

  static void save(RecordAuth auth) {
    _pb.authStore.save(auth.token, auth.record);
  }
}
