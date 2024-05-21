import 'package:firebase_auth/firebase_auth.dart';

class Result {
  Result({required this.result, required this.user});

  final String result;
  final User? user;
}
