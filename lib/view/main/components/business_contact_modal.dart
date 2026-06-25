import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../res/constants.dart';
import '../../../services/mock_data_service.dart';
import 'business_contact_header.dart';
import 'business_contact_footer.dart';
import 'business_contact_form.dart';

/// Opens the premium Gmail-compose-style Business Contact dialog.
void showBusinessContactDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Close',
    barrierColor: Colors.black.withValues(alpha: 0.75),
    transitionDuration: const Duration(milliseconds: 350),
    transitionBuilder: (context, anim1, anim2, child) {
      final curved = CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.88, end: 1.0).animate(curved),
          alignment: Alignment.bottomRight,
          child: child,
        ),
      );
    },
    pageBuilder: (context, _, _) => const _BusinessContactDialog(),
  );
}

class _BusinessContactDialog extends StatefulWidget {
  const _BusinessContactDialog();

  @override
  State<_BusinessContactDialog> createState() => _BusinessContactDialogState();
}

class _BusinessContactDialogState extends State<_BusinessContactDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSending = false;
  bool _sent = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSending = true);

    try {
      await MockDataService().submitContactMessage(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        subject: _subjectController.text.trim(),
        message: _messageController.text.trim(),
      );

      if (mounted) {
        setState(() {
          _isSending = false;
          _sent = true;
        });
      }
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;
    final bool isMobile = width < 600;
    final double dialogWidth = isMobile ? width : 560.0;
    final double keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;

    final borderRadius = isMobile
        ? const BorderRadius.vertical(top: Radius.circular(28))
        : BorderRadius.circular(24);

    return Stack(
      children: [
        // ── Full-screen frosted backdrop glass filter ──
        Positioned.fill(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                color: Colors.black.withValues(alpha: 0.25),
              ),
            ),
          ),
        ),
        
        // ── The Floating Dialog Window ──
        Align(
          alignment: isMobile ? Alignment.bottomCenter : Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOutCubic,
              width: dialogWidth,
              margin: isMobile
                  ? EdgeInsets.only(bottom: keyboardHeight)
                  : const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              constraints: BoxConstraints(
                maxWidth: isMobile ? double.infinity : 560.0,
                maxHeight: height - keyboardHeight - (isMobile ? 0 : 48),
              ),
              decoration: BoxDecoration(
                // Highly visible, rich deep navy-space frosted background
                color: const Color(0xFF070B16).withValues(alpha: 0.96),
                borderRadius: borderRadius,
                border: Border.all(
                  // Cyber neon indigo border for maximum visual definition
                  color: AppConstants.primaryColor.withValues(alpha: 0.26),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppConstants.primaryColor.withValues(alpha: 0.22),
                    blurRadius: 40,
                    spreadRadius: -2,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.8),
                    blurRadius: 30,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── Header Bar (Sticky at top) ──
                  BusinessContactHeader(
                    onClose: () => Navigator.of(context).pop(),
                  ),

                  // ── Scrollable Body Area ──
                  Flexible(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                      child: BusinessContactForm(
                        formKey: _formKey,
                        nameController: _nameController,
                        emailController: _emailController,
                        subjectController: _subjectController,
                        messageController: _messageController,
                      ),
                    ),
                  ),

                  // ── Footer / Send (Sticky at bottom) ──
                  BusinessContactFooter(
                    sent: _sent,
                    isSending: _isSending,
                    onSend: _send,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
