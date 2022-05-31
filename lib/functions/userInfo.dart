// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:developer';

//Access to user information
final user = FirebaseAuth.instance.currentUser!;

final userID = user.uid;

getCurrentUser() async {
  final prefs = await SharedPreferences.getInstance();
  final double? Lat = prefs.getDouble('LatUser');
  final double? Long = prefs.getDouble('LonUser');
  final currentUser = [Lat!, Long!];
  return currentUser;
}
