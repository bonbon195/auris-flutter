import 'package:auris/model/track.dart';
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

  static Future<List<Track>> getTracks() async {
    return await _pb.collection('tracks').getFullList().then((value) => value
        .map((e) => Track(
            id: e.id,
            title: e.data['title'],
            artist: e.data['artist'],
            album: e.data['album'],
            duration: e.data['duration'],
            audioStreamFile: e.data['audio_stream_file'],
            artworkFile: e.data['artwork_file'],
            audioSourceFile: e.data['audio_source_file']))
        .toList());
  }

  static String getTrackSourceUrl(Track track) {
    return '$_apiURL/api/files/tracks/${track.id}/${track.audioSourceFile}';
  }

  static String getTrackArtworkUrl(Track track) {
    return '$_apiURL/api/files/tracks/${track.id}/${track.artworkFile}';
  }
}
