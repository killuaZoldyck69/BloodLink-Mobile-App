import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

final supabaseClientProvider = Provider<SupabaseClient>(
  (ref) => Supabase.instance.client,
);
final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService(ref.read(supabaseClientProvider)),
);

class AuthService {
  final SupabaseClient _supabase;
  AuthService(this._supabase);

  /// Signs up a user. Profile data is passed as metadata.
  /// A database trigger (`handle_new_user`) is expected to create the profile.
  Future<void> signUpUser({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    String? bloodGroup,
    required double lat,
    required double lng,
  }) async {
    try {
      // 1. Sign Up in Auth System, passing profile data in the 'data' field.
      // This data will be accessible in the database trigger.
      final res = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'phone': phone,
          'blood_group': bloodGroup,
          // Pass lat/lng for the trigger to create the location point.
          'lat': lat,
          'lng': lng,
        },
      );

      final user = res.user;
      if (user == null) {
        throw Exception(
            'Sign up successful, but no user object was returned. Please check your email to confirm your account.');
      }
      
      // After sign up, the trigger will have done its job.
      // If we are here, it means the auth part was successful.
      // The user may need to confirm their email if enabled.

    } on AuthException catch (e) {
      // Handle Supabase Auth errors (e.g. weak password, user exists)
      throw Exception(e.message);
    } on PostgrestException catch (e) {
      // This shouldn't be reached for sign-up unless there's an issue with the auth call itself.
      throw Exception('Database Error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}