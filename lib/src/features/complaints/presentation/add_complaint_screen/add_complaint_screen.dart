import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/banner/app_banner_dialog.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import 'package:widam/src/common_widgets/submit_button.dart';
import 'package:widam/src/features/addresses/presentation/addresses/adaptive_back_button.dart';
import 'package:widam/src/features/complaints/presentation/add_complaint_screen/complaint_type_drop_down.dart';
import 'package:widam/src/features/complaints/presentation/add_complaint_screen/send_complaint_controller.dart';

@RoutePage()
class AddComplaintScreen extends StatefulWidget {
  const AddComplaintScreen({super.key});

  @override
  State<AddComplaintScreen> createState() => _AddComplaintScreenState();
}

class _AddComplaintScreenState extends State<AddComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  ComplaintType? _complaintType;
  String? _description;
  File? _selectedImage;

  // ─── Image Picker ─────────────────────────────────────────────────────────

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1080,
      );
      if (pickedFile != null) {
        setState(() => _selectedImage = File(pickedFile.path));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _removeImage() => setState(() => _selectedImage = null);

  // ─── Bottom Sheet ─────────────────────────────────────────────────────────

  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Handle bar ───────────────────────────────────────────────
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                S.of(context).addImage,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                S.of(context).chooseImageSource,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade500,
                    ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _SourceOptionTile(
                      icon: Icons.camera_alt_rounded,
                      label: S.of(context).camera,
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SourceOptionTile(
                      icon: Icons.photo_library_rounded,
                      label: S.of(context).gallery,
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        leading: const AdaptiveBackButton(),
        title: Text(S.of(context).complaints),
        centerTitle: true,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // ── Subtitle ──────────────────────────────────────────────────
              Text(
                S.of(context).complaintSubtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  // color: colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 28),

              // ── Complaint Type ────────────────────────────────────────────
              _SectionLabel(label: S.of(context).complaintType),
              const SizedBox(height: 8),
              _StyledDropdownWrapper(
                child: ComplaintTypeDropDown(
                  onSaved: (value) => _complaintType = value,
                ),
              ),
              const SizedBox(height: 24),

              // ── Description ───────────────────────────────────────────────
              _SectionLabel(label: S.of(context).description),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: S.of(context).writeDiscription,
                  hintStyle: TextStyle(
                    color: colorScheme.onSurface.withOpacity(0.35),
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: colorScheme.onSurface.withOpacity(0.04),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: colorScheme.outline.withOpacity(0.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: colorScheme.outline.withOpacity(0.25),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1.5,
                    ),
                  ),
                ),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                style: theme.textTheme.bodyMedium,
                validator: qValidator([IsRequired(S.of(context).required)]),
                onSaved: (value) => _description = value,
              ),
              const SizedBox(height: 24),

              // ── Attachment ────────────────────────────────────────────────
              _SectionLabel(label: S.of(context).attachment),
              const SizedBox(height: 8),
              _ImageSection(
                image: _selectedImage,
                onAddTap: _showImageSourceSheet,
                onRemove: _removeImage,
              ),
              const SizedBox(height: 36),

              // ── Submit ────────────────────────────────────────────────────
              Consumer(
                builder: (context, ref, child) {
                  ref.listen(sendComplaintControllerProvider,
                      (previous, next) {
                    if (next is AsyncData && next.value != null) {
                      context.maybePop(next.value);
                    } else if (next is AsyncError) {
                      showAppBannerDialog(
                          context, next.error.toString(), next.stackTrace);
                    }
                  });
                  final state = ref.watch(sendComplaintControllerProvider);
                  if (state is AsyncLoading) {
                    return const Center(child: FadeCircleLoadingIndicator());
                  }
                  return SubmitButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ref
                            .read(sendComplaintControllerProvider.notifier)
                            .sendComplaint(
                              complaintType: _complaintType!.name,
                              subject: _complaintType!.localize,
                              description: _description!,
                              image: _selectedImage,
                            );
                      }
                    },
                    text: S.of(context).submit,
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section Label
// ─────────────────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.75),
            letterSpacing: 0.2,
          ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Styled Dropdown Wrapper
// ─────────────────────────────────────────────────────────────────────────────

class _StyledDropdownWrapper extends StatelessWidget {
  const _StyledDropdownWrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: colorScheme.onSurface.withOpacity(0.04),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: colorScheme.outline.withOpacity(0.3),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: colorScheme.outline.withOpacity(0.25),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: colorScheme.primary,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
      ),
      child: child,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Image Section
// ─────────────────────────────────────────────────────────────────────────────

class _ImageSection extends StatelessWidget {
  const _ImageSection({
    required this.image,
    required this.onAddTap,
    required this.onRemove,
  });

  final File? image;
  final VoidCallback onAddTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    if (image == null) return _AddImageButton(onTap: onAddTap);

    return Stack(
      children: [
        // ── Preview ─────────────────────────────────────────────────────────
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.file(
            image!,
            width: double.infinity,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),

        // ── Dark overlay (bottom) for replace label ──────────────────────────
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: GestureDetector(
            onTap: onAddTap,
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(14),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.55),
                  ],
                ),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.edit_rounded,
                    size: 14,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    S.of(context).replace,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // ── Close / Delete button ────────────────────────────────────────────
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(5),
              child: const Icon(
                Icons.close_rounded,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Add Image Button (empty state)
// ─────────────────────────────────────────────────────────────────────────────

class _AddImageButton extends StatelessWidget {
  const _AddImageButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 110,
        decoration: BoxDecoration(
          border: Border.all(
            color: colorScheme.primary.withOpacity(0.4),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(14),
          color: colorScheme.primary.withOpacity(0.04),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add_photo_alternate_outlined,
                size: 28,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).addImage,
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              S.of(context).optional,
              style: TextStyle(
                color: colorScheme.onSurface.withOpacity(0.4),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Source Option Tile
// ─────────────────────────────────────────────────────────────────────────────

class _SourceOptionTile extends StatelessWidget {
  const _SourceOptionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 22),
        decoration: BoxDecoration(
          color: colorScheme.primary.withOpacity(0.06),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: colorScheme.primary.withOpacity(0.2),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 34, color: colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}