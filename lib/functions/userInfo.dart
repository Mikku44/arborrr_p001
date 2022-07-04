// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names, non_constant_identifier_names

import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:developer' as dev;

Theme? selectedTheme = Theme.normal;
var Themecolor = Colors.white;
var onPrimary = const Color.fromARGB(255, 255, 255, 255);
var foreground = Colors.black;
var foregroundHead = Colors.black38;
var primaryTheme = const Color(0xff4059ad);
//Access to user information

var db = FirebaseFirestore.instance;

FirebaseAuth auth = FirebaseAuth.instance;

final user = FirebaseAuth.instance.currentUser!;

final userID = user.uid;

getCurrentUser() async {
  final prefs = await SharedPreferences.getInstance();
  final double? Lat = prefs.getDouble('LatUser');
  final double? Long = prefs.getDouble('LonUser');
  final currentUser = [Lat!, Long!];
  return currentUser;
}

//use to store the keyValue on disk : This for themecolor
storeKeyValue(counter) async {
  // Save data
  final prefs = await SharedPreferences.getInstance();
  // set default value
  await prefs.setBool('dark', counter);
}

//use to read the keyValue on disk : This for themecolor
readKeyValue() async {
  final prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it doesn't exist, return 0.
  final bool counter = (prefs.getBool('dark') ?? false);

  if (counter) {
    Themecolor = const Color(0xff121212);
    foreground = const Color(0xfff2f2f2);
    foregroundHead = const Color(0xff888888);
    primaryTheme = const Color(0xff243362);
    onPrimary = const Color(0xff323232);
    selectedTheme = Theme.dark;
    dev.log("dark");
    return;
  }
  Themecolor = Colors.white;
  foreground = Colors.black87;
  foregroundHead = Colors.black38;
  primaryTheme = const Color(0xff4059ad);
  onPrimary = const Color.fromARGB(255, 255, 254, 254);
  selectedTheme = Theme.normal;
  dev.log("light");
}

enum Theme { dark, normal }
