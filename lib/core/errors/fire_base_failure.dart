import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// ✅ قاعدة عامة للفشل (Failure)
abstract class FireBaseFailure {
  final String message;
  const FireBaseFailure({required this.message});
}

/// ✅ أنواع مختلفة من الفشل
class FirebaseAuthFailure extends FireBaseFailure {
  const FirebaseAuthFailure({required super.message});
}

class FirestoreFailure extends FireBaseFailure {
  const FirestoreFailure({required super.message});
}

class ServerFailure extends FireBaseFailure {
  const ServerFailure({required super.message});
}

class NetworkFailure extends FireBaseFailure {
  const NetworkFailure({required super.message});
}

/// ✅ كلاس مركزي لمعالجة الأخطاء
class FirebaseErrorHandler {
  static FireBaseFailure handleFirebaseError(Object error) {
    if (error is FirebaseAuthException) {
      return FirebaseAuthFailure(message: _handleAuthError(error));
    } else if (error is FirebaseException) {
      return FirestoreFailure(message: _handleFirestoreError(error));
    } else if (error is TimeoutException) {
      return NetworkFailure(message: '⏳ Connection timed out. Please try again.');
    } else {
      return ServerFailure(message: '❗ An unexpected error occurred. Please try again.');
    }
  }

  /// 🔹 أخطاء Authentication
  static String _handleAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case 'user-not-found':
        return 'No user found for that email or phone.';
      case 'wrong-password':
        return 'Wrong password.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'network-request-failed':
        return 'Network connection failed.';
      default:
        return 'Auth error: ${error.message ?? "Unknown error"}';
    }
  }

  /// 🔹 أخطاء Firestore
  static String _handleFirestoreError(FirebaseException error) {
    switch (error.code) {
      case 'permission-denied':
        return 'You don’t have permission to access this data.';
      case 'unavailable':
        return 'Firestore service temporarily unavailable.';
      case 'not-found':
        return 'The requested document was not found.';
      case 'already-exists':
        return 'This document already exists.';
      default:
        return 'Firestore error: ${error.message ?? "Unknown error"}';
    }
  }
}
