// ignore_for_file: unnecessary_null_comparison, null_check_always_fails, deprecated_member_use
import 'dart:developer';
import 'package_export.dart';

//
void printData(String identifier, data) {
  return log('===> $identifier <=== $data');
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
  String get firstCap => "${this[0].toUpperCase()}${substring(1)}";
  String get allInCaps => toUpperCase();
  String get capitalizeFirstOfEach =>
      split(" ").map((str) => str.capitalizeFirstOfEach).join(" ");
}

// setToLocalStorage() method will set data to the local storage
Future setToLocalStorage({required String name, dynamic data}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(name, data);
}

Future setIntToLocalStorage({required String name, dynamic data}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt(name, data);
}

Future setDoubleToLocalStorage({required String name, dynamic data}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setDouble(name, data);
}

Future setBoolToLocalStorage({required String name, dynamic data}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(name, data);
}

Future setListToLocalStorage({
  required String name,
  required List<String> data,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(name, data);
}

// getFromLocalStorage() method will get data from the local storage
Future getFromLocalStorage({required String name}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(name);
}

Future getIntFromLocalStorage({required String name}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt(name);
}

Future getDoubleFromLocalStorage({required String name}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getDouble(name);
}

Future getBoolFromLocalStorage({required String name}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(name);
}

Future getListFromLocalStorage({required String name}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList(name);
}

Future<void> removeFromLocalStorage({required String name}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(name);
}

void finish(BuildContext context, [Object? result]) {
  if (Navigator.canPop(context)) Navigator.pop(context, result);
}

const String image =
    'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/681px-Placeholder_view_vector.svg.png?20220519031949';
String removeSpecialCharactersAndSpaces(String input) {
  return input.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
}

String removeSpecialCharactersAndLetters(String input) {
  // This regex removes everything except digits (0-9)
  return input.replaceAll(RegExp(r'[^0-9]'), '');
}
