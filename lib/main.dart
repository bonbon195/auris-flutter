import 'dart:io';
import 'package:auris/page/auth.dart';
import 'package:auris/page/check_auth.dart';
import 'package:auris/page/home.dart';
import 'package:auris/service/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ApiService.init();

  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final Map<String, WidgetBuilder> routes = {
    '/': (context) => const HomePage(),
    'auth': (context) => const AuthPage(),
    'check-auth': (context) => const CheckAuth(),
  };

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS || kDebugMode) {
      return CupertinoApp(
        navigatorKey: navigatorKey,
        title: 'Auris',
        initialRoute: 'check-auth',
        routes: routes,
      );
    }
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Auris',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: 'check-auth',
      routes: routes,
    );
  }
}
