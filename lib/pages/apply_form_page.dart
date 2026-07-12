import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../theme/app_theme.dart';
import '../widgets/page_layout.dart';
import '../widgets/page_hero.dart';

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

  Future<void> pickCV() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
      withData: true,
    );

    if (result != null && result.files.first.bytes != null) {
      setState(() {
        cvBytes = result.files.first.bytes!;
        cvName = result.files.first.name;
      });
    }
  }

  Future<void> submitApplication() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    if (cvBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload your CV')),
      );
      return;
    }

    setState(() => isSubmitting = true);

    try {
      final uri = Uri.parse(
        'https://bazutelcom-backend.onrender.com/api/careers/apply',
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
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Application sent successfully')),
        );

        _formKey.currentState!.reset();
        setState(() {
          cvBytes = null;
          cvName = null;
        });
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Submission failed (${response.statusCode}): $responseBody',
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Submission error: $e')),
      );
    } finally {
      if (mounted) setState(() => isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isNarrow = width < 600;

    return PageLayout(
      children: [
        PageHero(
          title: 'Apply for ${position ?? "Position"}',
          subtitle: 'Fill in your details below and upload your CV to apply.',
          compact: true,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isNarrow ? 24 : 48,
            vertical: 48,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: AppTheme.cardHoverDecoration,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                        onSaved: (v) => fullName = v,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone_outlined),
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                        onSaved: (v) => phone = v,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (v) => v != null && v.contains('@')
                            ? null
                            : 'Enter a valid email',
                        onSaved: (v) => email = v,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Tell us about yourself',
                          alignLabelWithHint: true,
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                        onSaved: (v) => description = v,
                      ),
                      const SizedBox(height: 24),
                      OutlinedButton.icon(
                        onPressed: isSubmitting ? null : pickCV,
                        icon: const Icon(Icons.upload_file),
                        label: Text(cvName ?? 'Upload CV (PDF, DOC)'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: isSubmitting ? null : submitApplication,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: isSubmitting
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
