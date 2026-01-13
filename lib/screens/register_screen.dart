import 'package:flutter/material.dart';
import 'package:myapp/models/user_registration_model.dart';
import 'package:myapp/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _user = UserRegistrationModel();
  DateTime? _selectedDate;

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
    });
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
              const CustomTextField(labelText: 'Full Name'),
              const SizedBox(height: 20),
              const CustomTextField(
                labelText: 'Email Address',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                labelText: 'Phone Number',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              const CustomTextField(labelText: 'Password', obscureText: true),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _user.address,
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
