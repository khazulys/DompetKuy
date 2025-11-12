import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class OnboardingSheet extends StatefulWidget {
  const OnboardingSheet({super.key});

  @override
  State<OnboardingSheet> createState() => _OnboardingSheetState();
}

class _OnboardingSheetState extends State<OnboardingSheet> {
  final _nameController = TextEditingController();
  bool _isValid = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _validateName() {
    setState(() {
      _isValid = _nameController.text.trim().isNotEmpty;
    });
  }

  Future<void> _saveName() async {
    if (_nameController.text.trim().isEmpty) return;

    await context.read<UserProvider>().setUserName(_nameController.text.trim());
    
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 32,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: BoxDecoration(
        color: context.theme.colors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.theme.colors.muted,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          Text(
            'Selamat Datang! 👋',
            style: context.theme.typography.xl3.copyWith(
              fontWeight: FontWeight.bold,
              color: context.theme.colors.foreground,
            ),
          ),
          const SizedBox(height: 8),
          
          Text(
            'Siapa nama kamu? Kami akan menggunakannya untuk personalisasi pengalaman kamu.',
            style: context.theme.typography.base.copyWith(
              color: context.theme.colors.mutedForeground,
            ),
          ),
          const SizedBox(height: 32),
          
          TextField(
            controller: _nameController,
            onChanged: (_) => _validateName(),
            autofocus: true,
            style: TextStyle(
              color: context.theme.colors.foreground,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              labelText: 'Nama',
              labelStyle: TextStyle(color: context.theme.colors.mutedForeground),
              hintText: 'Contoh: Budi Santoso',
              hintStyle: TextStyle(color: context.theme.colors.muted),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.theme.colors.border),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.theme.colors.primary, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: context.theme.colors.background,
            ),
            textCapitalization: TextCapitalization.words,
            onSubmitted: (_) {
              if (_isValid) _saveName();
            },
          ),
          const SizedBox(height: 24),
          
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _isValid ? _saveName : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isValid 
                    ? context.theme.colors.primary 
                    : context.theme.colors.muted,
                foregroundColor: _isValid 
                    ? context.theme.colors.primaryForeground 
                    : context.theme.colors.mutedForeground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                'Mulai',
                style: context.theme.typography.base.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
