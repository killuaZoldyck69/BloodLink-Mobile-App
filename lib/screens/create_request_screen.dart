
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/request_widgets/blood_group_chips.dart';
import '../widgets/request_widgets/urgency_selector.dart';

final unitsRequiredProvider = StateProvider<int>((ref) => 1);
final formLoadingProvider = StateProvider<bool>((ref) => false);

class CreateRequestScreen extends ConsumerWidget {
  const CreateRequestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final units = ref.watch(unitsRequiredProvider);
    final isLoading = ref.watch(formLoadingProvider);

    void submitForm() async {
      if (formKey.currentState!.validate()) {
        ref.read(formLoadingProvider.notifier).state = true;
        await Future.delayed(const Duration(seconds: 2)); // Mock API call
        ref.read(formLoadingProvider.notifier).state = false;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Blood request posted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Blood'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Patient Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Patient Name', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Please enter patient name' : null,
              ),
              const SizedBox(height: 24),
              const Text('Blood Group', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              const BloodGroupChips(),
              const SizedBox(height: 24),
              const Text('Units Required', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline, size: 30),
                    onPressed: () {
                      if (units > 1) {
                        ref.read(unitsRequiredProvider.notifier).state--;
                      }
                    },
                  ),
                  Text('$units', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline, size: 30, color: Color(0xFFD32F2F)),
                    onPressed: () {
                      ref.read(unitsRequiredProvider.notifier).state++;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),
              const Text('Urgency Level', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const UrgencySelector(),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),
              const Text('Location & Contact', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Hospital Name', border: OutlineInputBorder()),
                 validator: (value) => value!.isEmpty ? 'Please enter hospital name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.map),
                    onPressed: () {
                      // Mock function
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Fetching current location... (mock)')),
                      );
                    },
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter location' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Contact Number', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Please enter a contact number' : null,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD32F2F),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'POST REQUEST',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
