import 'package:flutter/material.dart';
import 'app_ config.dart';
import 'main.dart';

void main() {
  var configuredApp =  AppConfig(
    appName: 'RedOps app PROD',
    flavorName: 'production',
    apiBaseUrl: 'https://api.example.com/',
    child: const App(),
  );

  runApp(configuredApp);
}
