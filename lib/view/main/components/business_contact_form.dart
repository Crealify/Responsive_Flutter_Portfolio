import 'package:flutter/material.dart';
import 'business_contact_to_field.dart';
import 'business_contact_text_field.dart';
import 'business_contact_message_field.dart';

/// The form fields section of the business contact dialog.
class BusinessContactForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController subjectController;
  final TextEditingController messageController;

  const BusinessContactForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.subjectController,
    required this.messageController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── To Field ──
          const BusinessContactToField(),
          
          const SizedBox(height: 8),
          _divider(),
          const SizedBox(height: 16),

          // ── Form Fields ──
          BusinessContactTextField(
            controller: nameController,
            hint: 'Your Name',
            icon: Icons.person_outline_rounded,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Name is required' : null,
          ),
          const SizedBox(height: 12),
          BusinessContactTextField(
            controller: emailController,
            hint: 'Your Email',
            icon: Icons.alternate_email_rounded,
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Email is required';
              if (!v.contains('@')) return 'Enter a valid email';
              return null;
            },
          ),
          const SizedBox(height: 12),
          BusinessContactTextField(
            controller: subjectController,
            hint: 'Subject',
            icon: Icons.subject_rounded,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Subject is required' : null,
          ),
          const SizedBox(height: 12),
          BusinessContactMessageField(controller: messageController),
        ],
      ),
    );
  }

  Widget _divider() => Container(
        height: 1,
        color: Colors.white.withValues(alpha: 0.08),
      );
}
