// ignore_for_file: avoid_print

import 'package:final_project/Cubits/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phoneNo,
  }) async {
    try {
      emit(AuthLoading());

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (value) async {
          if (value.user != null) {                     //if value of user != 0 then we will add data to database
            await addUserDataToFireStoreDataBase(
              name: name,
              email: email,
              password: password,
              uid: value.user!.uid,
              phoneNo: phoneNo,
            ).then((value) {
              emit(AuthLoaded());
            });
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      emit(AuthError(error: firebaseAuthExceptionH(e)));
      print(e.message);
    } catch (error) {
      emit(AuthError(error: 'Error: $error'));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value.user != null) {
          emit(AuthLoaded());
        }
      });
    } on FirebaseAuthException catch (e) {
      emit(AuthError(error: firebaseAuthExceptionH(e)));
    } catch (error) {
      emit(AuthError(error: 'Error: $error'));
    }
  }

  Future<void> addUserDataToFireStoreDataBase({
    required String name,
    required String email,
    required String password,
    required String uid,
    required String phoneNo,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set(
      {
        "name": name,
        "email": email,
        "password": password,
        "uid": uid,
        "userImage": "",
        "phoneNo": phoneNo,
      },
    );
  }

  /// handle errors code in switch case
  String firebaseAuthExceptionH(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-cardinality':
        return 'The email or password is invalid.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'invalid-email':
        return 'Your email address appears to be malformed.';
      case 'too-many-requests':
        return 'Too many requests. Try again later.';
      default:
        return 'Error: ${e.message}';
    }
  }
}
