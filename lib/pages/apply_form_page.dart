import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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
  Uint8List? cvFile;
  String? cvName;

  Future<void> pickCV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf", "doc", "docx"],
    );

    if (result != null) {
      setState(() {
        cvFile = result.files.first.bytes;
        cvName = result.files.first.name;
      });
    }
  }

  void submitApplication() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    // Submit to backend via API
    // TODO: Implement POST request to your server

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Application submitted!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "Job Application Form",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Full Name
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Full Name"),
                      validator: (v) => v!.isEmpty ? "Required" : null,
                      onSaved: (v) => fullName = v!,
                    ),
                    const SizedBox(height: 20),

                    // Phone
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                      ),
                      validator: (v) => v!.isEmpty ? "Required" : null,
                      onSaved: (v) => phone = v!,
                    ),
                    const SizedBox(height: 20),

                    // Email
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Email Address",
                      ),
                      validator: (v) =>
                          v!.contains("@") ? null : "Enter a valid email",
                      onSaved: (v) => email = v!,
                    ),
                    const SizedBox(height: 20),

                    // Description
                    TextFormField(
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: "Tell us about yourself",
                      ),
                      validator: (v) => v!.isEmpty ? "Required" : null,
                      onSaved: (v) => description = v!,
                    ),
                    const SizedBox(height: 20),

                    // Upload CV
                    ElevatedButton.icon(
                      onPressed: pickCV,
                      icon: const Icon(Icons.upload_file),
                      label: Text(cvName ?? "Upload CV"),
                    ),
                    const SizedBox(height: 40),

                    ElevatedButton(
                      onPressed: submitApplication,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        child: Text("Submit Application"),
                      ),
                    ),
                    const SizedBox(height: 50),
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
