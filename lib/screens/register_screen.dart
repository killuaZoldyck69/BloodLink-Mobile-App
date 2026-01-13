import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/user_registration_model.dart';
import 'package:myapp/widgets/custom_text_field.dart';
import 'package:myapp/services/auth_service.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _user = UserRegistrationModel();
  DateTime? _selectedDate;
  bool _isLoading = false;
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addressController.text = _user.address;
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _user.lastDonationDate = picked;
      });
    }
  }

  void _getCurrentLocation() {
    // Simulate fetching GPS coordinates
    setState(() {
      _user.address = '123 Main St, City, State';
      _addressController.text = _user.address;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
    });

    // Use placeholder coordinates (Dhanmondi, Dhaka) for demo until real GPS is integrated
    const double lat = 23.7465;
    const double lng = 90.3760;

    try {
      final auth = ref.read(authServiceProvider);
      await auth.signUpUser(
        email: _user.email,
        password: _user.password,
        fullName: _user.fullName,
        phone: _user.phoneNumber,
        bloodGroup: _user.bloodGroup,
        lat: lat,
        lng: lng,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registered successfully')));
      // Navigate to home
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      final message = e.toString().toLowerCase();
      if (message.contains('already') ||
          message.contains('duplicate') ||
          message.contains('23505')) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Email already taken')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: Theme.of(context).appBarTheme.elevation ?? 0,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                labelText: 'Full Name',
                onChanged: (v) => _user.fullName = v,
                validator: (v) => v == null || v.isEmpty
                    ? 'Please enter your full name'
                    : null,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'Email Address',
                keyboardType: TextInputType.emailAddress,
                onChanged: (v) => _user.email = v,
                validator: (v) => v == null || !v.contains('@')
                    ? 'Enter a valid email'
                    : null,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'Phone Number',
                keyboardType: TextInputType.phone,
                onChanged: (v) => _user.phoneNumber = v,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter a phone number' : null,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'Password',
                obscureText: true,
                onChanged: (v) => _user.password = v,
                validator: (v) => v == null || v.length < 6
                    ? 'Password must be at least 6 characters'
                    : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                onChanged: (v) => _user.address = v,
                decoration: InputDecoration(
                  labelText: 'Current Address',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.location_pin),
                    onPressed: _getCurrentLocation,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Become a Donor (Optional)',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        items:
                            ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
                                .map(
                                  (label) => DropdownMenuItem(
                                    value: label,
                                    child: Text(label),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            _user.bloodGroup = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Select Blood Group',
                          helperText: 'Select only if you want to donate',
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        decoration: const InputDecoration(
                          labelText: 'Last Donation',
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        controller: TextEditingController(
                          text: _selectedDate == null
                              ? ''
                              : '${_selectedDate!.toLocal()}'.split(' ')[0],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
