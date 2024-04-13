import 'package:auris/platform_components/platform_loading_indicator.dart';
import 'package:auris/service/api_service.dart';
import 'package:flutter/material.dart';

class CheckAuth extends StatefulWidget {
  const CheckAuth({super.key});

  @override
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ApiService.checkAuth()) {
        Navigator.pushReplacementNamed(context, '/');
      } else {
        Navigator.pushReplacementNamed(context, 'auth');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: PlatformLoadingIndicator(),
    );
  }
}
