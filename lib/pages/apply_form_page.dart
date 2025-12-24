import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/navbar.dart';
import '../widgets/footer.dart';

class ApplyFormPage extends StatefulWidget {
  const ApplyFormPage({super.key});

  @override
  State<ApplyFormPage> createState() => _ApplyFormPageState();
}

class _ApplyFormPageState extends State<ApplyFormPage> {
  final _formKey = GlobalKey<FormState>();

  String? fullName;
  String? phone;
  String? email;
  String? description;
  String? position;

  Uint8List? cvBytes;
  String? cvName;

  bool isSubmitting = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    position = ModalRoute.of(context)?.settings.arguments as String?;
  }

  // =========================
  // PICK CV (WEB SAFE)
  // =========================
  Future<void> pickCV() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
      withData: true, // REQUIRED for Flutter Web
    );

    if (result != null && result.files.first.bytes != null) {
      setState(() {
        cvBytes = result.files.first.bytes!;
        cvName = result.files.first.name;
      });
    }
  }

  // =========================
  // SUBMIT APPLICATION
  // =========================
  Future<void> submitApplication() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    if (cvBytes == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please upload your CV')));
      return;
    }

    setState(() => isSubmitting = true);

    try {
      final uri = Uri.parse(
        'https://bazutelcom-backend.onrender.com/api/careers/apply', // 🔴 CHANGE IF NEEDED
      );

      final request = http.MultipartRequest('POST', uri);

      request.fields['fullName'] = fullName ?? '';
      request.fields['phone'] = phone ?? '';
      request.fields['email'] = email ?? '';
      request.fields['description'] = description ?? '';
      request.fields['position'] = position ?? '';

      request.files.add(
        http.MultipartFile.fromBytes(
          'cv',
          cvBytes!,
          filename: cvName ?? 'cv.pdf',
        ),
      );

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Application sent successfully ✅')),
        );

        _formKey.currentState!.reset();
        setState(() {
          cvBytes = null;
          cvName = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Submission failed (${response.statusCode}): $responseBody',
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Submission error: $e')));
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  // =========================
  // UI
  // =========================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),

            Text(
              'Apply for ${position ?? "Position"}',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // FULL NAME
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Full Name'),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Required' : null,
                      onSaved: (v) => fullName = v,
                    ),
                    const SizedBox(height: 20),

                    // PHONE
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Required' : null,
                      onSaved: (v) => phone = v,
                    ),
                    const SizedBox(height: 20),

                    // EMAIL
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                      ),
                      validator: (v) => v != null && v.contains('@')
                          ? null
                          : 'Enter a valid email',
                      onSaved: (v) => email = v,
                    ),
                    const SizedBox(height: 20),

                    // DESCRIPTION
                    TextFormField(
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'Tell us about yourself',
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Required' : null,
                      onSaved: (v) => description = v,
                    ),
                    const SizedBox(height: 25),

                    // UPLOAD CV
                    ElevatedButton.icon(
                      onPressed: isSubmitting ? null : pickCV,
                      icon: const Icon(Icons.upload_file),
                      label: Text(cvName ?? 'Upload CV'),
                    ),

                    const SizedBox(height: 40),

                    // SUBMIT BUTTON
                    ElevatedButton(
                      onPressed: isSubmitting ? null : submitApplication,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        child: isSubmitting
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text('Submit Application'),
                      ),
                    ),

                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),

            const Footer(),
          ],
        ),
      ),
    );
  }
}
