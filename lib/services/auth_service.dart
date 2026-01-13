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

  /// Signs up a user and inserts a profile row in `profiles` table.
  /// `bloodGroup` may be null and will be stored as null in the DB.
  /// Location is stored as a PostGIS point string: `POINT(lng lat)`
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
      // 1. Sign Up in Auth System
      final res = await _supabase.auth.signUp(email: email, password: password);
      final user = res.user;

      if (user == null) {
        throw Exception('Sign up failed: User creation returned null');
      }

      final userId = user.id;
      // WKT (Well-Known Text) Format for PostGIS: 'POINT(longitude latitude)'
      final location = 'POINT($lng $lat)';

      // 2. Insert into Database (Profile Table)
      // FIX: Removed .execute() and simplified logic for Supabase v2
      await _supabase.from('profiles').insert({
        'id': userId,
        'full_name': fullName,
        'phone':
            phone, // Ensure this matches your SQL column name ('phone' or 'phone_number')
        'blood_group': bloodGroup,
        'location': location,
      });

      // In v2, if the above line doesn't throw an error, it was successful.
    } on AuthException catch (e) {
      // Handle Supabase Auth errors (e.g. weak password)
      throw Exception(e.message);
    } on PostgrestException catch (e) {
      // Handle Database errors (e.g. row security policy, missing column)
      throw Exception('Database Error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
