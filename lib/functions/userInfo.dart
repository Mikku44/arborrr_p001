// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names, non_constant_identifier_names
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:developer';

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

enum Theme { dark, normal }
