import 'package:deneme/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    
    try {
      // Firestore-Referenz initialisieren
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Überprüfen, ob der Benutzer existiert
      var userSnapshot = await firestore.collection('users').doc(data.name).get();
      if (!userSnapshot.exists) {
        return 'User not exists';
      }

      // Überprüfen, ob das Passwort übereinstimmt
      var password = userSnapshot['password'];
      if (password != data.password) {
        return 'Password does not match';
      }

      // Erfolgreiche Authentifizierung
      return null;
    } catch (e) {
      // Fehler behandeln
      debugPrint('Error: $e');
      return 'Failed to authenticate. Please try again later.';
    }
  }

  Future<String?> _signupUser(SignupData data) async {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');

    try {
      // Firestore-Referenz initialisieren
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Benutzerdaten in Firestore speichern
      await firestore.collection('users').doc(data.name).set({
        'password': data.password,
        // Weitere Benutzerdaten hier speichern, z.B. Name, E-Mail usw.
      });

      // Erfolgreiche Registrierung
      return null;
    } catch (e) {
      // Fehler behandeln
      debugPrint('Error: $e');
      return 'Failed to register. Please try again later.';
    }
  }

  Future<String> _recoverPassword(String name) async {
    debugPrint('Name: $name');

    try {
      // Firestore-Referenz initialisieren
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Überprüfen, ob der Benutzer existiert
      var userSnapshot = await firestore.collection('users').doc(name).get();
      if (!userSnapshot.exists) {
        return 'User not exists';
      }

      // Implementieren Sie hier Ihre Passwort-Wiederherstellungslogik, z.B. E-Mail-Versand
      // Hier ein Platzhalter, da diese Funktion im Beispiel nicht vollständig implementiert ist
      return 'Password recovery not implemented.';
    } catch (e) {
      // Fehler behandeln
      debugPrint('Error: $e');
      return 'Failed to recover password. Please try again later.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'ECORP',
      logo: const AssetImage('assets/images/ecorp-lightblue.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
