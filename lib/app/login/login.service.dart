import 'package:SMLingg/app/login/login.provider.dart';
import 'package:SMLingg/config/application.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

String name;
String email;
String imageUrl;

//Todo: handle Sign in with Google
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final FacebookLogin facebookSignIn = FacebookLogin();

//Todo: Sign in Google
Future<String> signInWithGoogle(BuildContext context) async {
  print("signInWithGoogle");
  await Firebase.initializeApp();
  print("1");
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn().catchError((onError) {
    print("Error $onError");
  });
  print("2");
  if (googleSignInAccount != null) {
    print("3");
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

            print('signInWithGoogle succeeded: $user');
            Application.sharePreference.putString("access_token", googleSignInAuthentication.accessToken);

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
  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}

//Todo: Sign in Facebook
Future loginWithFacebook(BuildContext context) async {
  final facebookLogin = FacebookLogin();
  final FacebookLoginResult result = await facebookLogin.logIn(['email']);
  print(result.status);
  switch (result.status) {
    case FacebookLoginStatus.loggedIn:
      final FacebookAccessToken accessToken = result.accessToken;
      Application.sharePreference.putString("access_token", result.accessToken.token);
      print(Application.sharePreference.getString("access_token"));
      print('''
         Logged in!
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
      break;
    case FacebookLoginStatus.cancelledByUser:
      Provider.of<LoginModel>(context, listen: false).logInAbsorb(false);
      print('Login cancelled by the user.');
      break;
    case FacebookLoginStatus.error:
      Provider.of<LoginModel>(context, listen: false).logInAbsorb(false);
      print('Something went wrong with the login process.\n'
          'Here\'s the error Facebook gave us: ${result.errorMessage}');
      break;
  }
}

Future logout() async {
  await _auth.signOut();
  await facebookSignIn.logOut();
}

Future checkLogin() async {
  final User currentUser = _auth.currentUser;
  if (currentUser != null) {
    print("signed in as ${currentUser.displayName}");
  }
}
