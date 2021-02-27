import 'package:SMLingg/app/login/login.provider.dart';
import 'package:SMLingg/config/application.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

String name;
String email;
String imageUrl;

//Todo: handle Sign in with Google
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
// final FacebookLogin facebookSignIn = FacebookLogin();

//Todo: Sign in Google
Future<String> signInWithGoogle(BuildContext context) async {
  await Firebase.initializeApp();
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn().catchError((onError) {
    print("Error $onError");
  });
  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    if (googleSignInAuthentication != null) {
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      print(googleSignInAuthentication.accessToken);
      if (credential != null && _auth != null) {
        final UserCredential authResult = await _auth.signInWithCredential(credential);
        if (authResult != null) {
          final User user = authResult.user;

          if (user != null) {
            // Checking if email and name is null
            assert(user.email != null);
            assert(user.displayName != null);
            assert(user.photoURL != null);

            name = user.displayName;
            email = user.email;
            imageUrl = user.photoURL;

            // Only taking the first part of the name, i.e., First Name
            if (name.contains(" ")) {
              name = name.substring(0, name.indexOf(" "));
            }

            assert(!user.isAnonymous);
            assert(await user.getIdToken() != null);

            final User currentUser = _auth.currentUser;
            assert(user.uid == currentUser.uid);

            // print('signInWithGoogle succeeded: $user');
            name = currentUser.displayName;
            email= currentUser.email;
            imageUrl = currentUser.photoURL;
            // Application.sharePreference.putString("access_token", googleSignInAuthentication.accessToken);
            // print('access_token: ${Application.sharePreference.getString("access_token")}');
            return '$user';
          } else {
            Provider.of<LoginModel>(context, listen: false).logInAbsorb(false);
            return null;
          }
        } else {
          Provider.of<LoginModel>(context, listen: false).logInAbsorb(false);
          return null;
        }
      } else {
        Provider.of<LoginModel>(context, listen: false).logInAbsorb(false);
        return null;
      }
    } else {
      Provider.of<LoginModel>(context, listen: false).logInAbsorb(false);
      return null;
    }
  } else {
    Provider.of<LoginModel>(context, listen: false).logInAbsorb(false);
    return null;
  }
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}

Map<String, dynamic> _userData;
AccessToken _accessToken;
//Todo: Sign in Facebook
Future loginWithFacebook(BuildContext context) async {
  try {
    // show a circular progress indicator
    _accessToken = await FacebookAuth.instance.login(); // by the fault we request the email and the public profile
    // loginBehavior is only supported for Android devices, for ios it will be ignored
    // _accessToken = await FacebookAuth.instance.login(
    //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
    //   loginBehavior:
    //       LoginBehavior.DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
    // );
    // get the user data
    // by default we get the userId, email,name and picture
    final userData = await FacebookAuth.instance.getUserData();
    // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
    _userData = userData;

    print("userData: $userData");
    print("accessToken: ${_accessToken.toJson()}");
  } on FacebookAuthException catch (e) {
    // if the facebook login fails
    print(e.message); // print the error message in console
    // check the error type
    switch (e.errorCode) {
      case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
        print("You have a previous login operation in progress");
        break;
      case FacebookAuthErrorCode.CANCELLED:
        print("login cancelled");
        break;
      case FacebookAuthErrorCode.FAILED:
        print("login failed");
        break;
    }
  } catch (e, s) {
    // print in the logs the unknown errors
    print(e);
    print(s);
  } finally {
    // update the view
  }
}

Future logout() async {
  await _auth.signOut();
  await FacebookAuth.instance.logOut();
  _accessToken = null;
  _userData = null;
}

Future checkLogin() async {
  final User currentUser = _auth.currentUser;
  if (currentUser != null) {
    print("signed in as ${currentUser.displayName}");
  }
}
