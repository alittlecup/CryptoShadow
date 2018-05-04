import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cryptoshadow/ui/home/home_page.dart';

void main() {
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  _firebaseMessaging.requestNotificationPermissions();
  runApp(MaterialApp(
    title: "CryptoShadow",
    home: HomePage(),
  ));
}