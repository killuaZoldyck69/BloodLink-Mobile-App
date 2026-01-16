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

  /// Signs up a user. Profile data is inserted directly into the profiles table.
  Future<void> signUpUser({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    String? bloodGroup,
    required double lat,
    required double lng,
    DateTime? lastDonationDate,
  }) async {
    try {
      // 1. Sign Up in Auth System
      final res = await _supabase.auth.signUp(email: email, password: password);

      final user = res.user;
      if (user == null) {
        throw Exception(
          'Sign up successful, but no user object was returned. Please check your email to confirm your account.',
        );
      }

      // 2. Insert profile data directly into the profiles table
      await _supabase.from('profiles').insert({
        'id': user.id,
        'full_name': fullName,
        'phone_number': phone,
        'blood_group': bloodGroup,
        'location': 'POINT($lng $lat)',
        'last_donation_date': lastDonationDate?.toIso8601String().substring(
          0,
          10,
        ),
      });
    } on AuthException catch (e) {
      // Handle Supabase Auth errors (e.g. weak password, user exists)
      throw Exception(e.message);
    } on PostgrestException catch (e) {
      // Handle database errors
      throw Exception('Database Error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
