import 'package:auris/platform_components/platform_button.dart';
import 'package:auris/service/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PlatformButton(
              onPressed: () async {
                _signIn('google');
              },
              child: const Text('Sign in with Google')),
          PlatformButton(
              onPressed: () async {
                _signIn('yandex');
              },
              child: const Text('Sign in with Yandex')),
          PlatformButton(
              onPressed: () async {
                _signIn('vk');
              },
              child: const Text('Sign in with VK')),
        ],
      ),
    );
  }

  void _signIn(String provider) async {
    try {
      RecordAuth recordAuth = await ApiService.authWithProvider(
          provider: provider, context: context);
      ApiService.save(recordAuth);
      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      return;
    }
  }
}
