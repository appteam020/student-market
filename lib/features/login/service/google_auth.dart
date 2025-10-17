import 'dart:developer';
import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  static Future<AuthResponse?> signInWithGoogle() async {
    try {
      log('Initializing GoogleSignIn...');
      await _googleSignIn.initialize(
        clientId: Platform.isIOS ? '523816985336-hctn22cbk83d0duihrao96gpmujpcgc4.apps.googleusercontent.com' : null,
        serverClientId: '945058684721-rdmnvmgtc92r7roh1aqhpqhbqnsri2b4.apps.googleusercontent.com',
      );

      log('Calling authenticate()...');
      final GoogleSignInAccount? account = await _googleSignIn.authenticate(scopeHint: ['email', 'profile']);

      if (account == null) {
        log('User cancelled Google Sign-In.');
        return null;
      }

      log('Account: $account');

      final GoogleSignInAuthentication googleAuth = await account.authentication;
      final String? idToken = googleAuth.idToken;

      log('Authentication: idToken=${googleAuth.idToken}');
      final AuthResponse response = await supabase.auth.signInWithIdToken(provider: OAuthProvider.google, idToken: idToken!);

      if (response.user != null) {
        final responseUser = await supabase.from('tb_user').select('*').eq('user_id', response.user!.id).maybeSingle();
        if (responseUser == null || responseUser.isEmpty) {
          await _insertUserToSupabase(response.user!);
        }
      }

      return response;
    } catch (e, st) {
      log('Google Sign-In error: $e\n$st');
      rethrow;
    }
  }

  static Future<void> signOut() async {
    await _googleSignIn.signOut();
    log('User signed out from Google.');
  }

  static User? getCurrentUser() => supabase.auth.currentUser;

  static Future<void> _insertUserToSupabase(User user) async {
    try {
      log('Inserting/updating user data in Supabase...');
      await supabase.from('tb_user').insert({
        'full_name': user.userMetadata?['full_name'],
        'email': user.email,
        'image': user.userMetadata?['avatar_url'],
        'user_id': user.id,
      });

      log('User inserted/updated successfully in Supabase.');
    } catch (e) {
      log('Supabase user insert error: $e');
    }
  }
}
