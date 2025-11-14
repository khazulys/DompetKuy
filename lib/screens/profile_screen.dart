import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:provider/provider.dart';
import '../models/avatar_config.dart';
import '../providers/user_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/avatar_preview.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showEditNameDialog(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    final nameController = TextEditingController(text: userProvider.userName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: context.theme.colors.background,
        title: Text(
          'Edit Nama',
          style: context.theme.typography.lg.copyWith(
            fontWeight: FontWeight.w600,
            color: context.theme.colors.foreground,
          ),
        ),
        content: TextField(
          controller: nameController,
          autofocus: true,
          style: TextStyle(color: context.theme.colors.foreground),
          decoration: InputDecoration(
            labelText: 'Nama',
            labelStyle: TextStyle(color: context.theme.colors.mutedForeground),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: context.theme.colors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: context.theme.colors.primary,
                width: 2,
              ),
            ),
          ),
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Batal',
              style: TextStyle(color: context.theme.colors.mutedForeground),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                context.read<UserProvider>().updateUserName(
                  nameController.text.trim(),
                );
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.theme.colors.primary,
              foregroundColor: context.theme.colors.primaryForeground,
            ),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final avatarConfig = userProvider.avatarConfig;

    return Scaffold(
      backgroundColor: context.theme.colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profil',
                style: context.theme.typography.xl3.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.theme.colors.foreground,
                ),
              ),
              const SizedBox(height: 24),

              Center(
                child: Column(
                  children: [
                    AvatarPreview(config: avatarConfig, size: 110),
                    const SizedBox(height: 16),
                    Text(
                      userProvider.userName,
                      style: context.theme.typography.xl.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.theme.colors.foreground,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => _showEditAvatarSheet(context),
                      child: Text(
                        'Edit Avatar',
                        style: context.theme.typography.sm.copyWith(
                          color: context.theme.colors.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _showEditNameDialog(context),
                      child: Text(
                        'Edit Nama',
                        style: context.theme.typography.sm.copyWith(
                          color: context.theme.colors.mutedForeground,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              Text(
                'Pengaturan',
                style: context.theme.typography.lg.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.theme.colors.foreground,
                ),
              ),
              const SizedBox(height: 12),

              FCard(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        themeProvider.isDarkMode
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        color: context.theme.colors.foreground,
                      ),
                      title: Text(
                        'Mode Gelap',
                        style: context.theme.typography.base.copyWith(
                          color: context.theme.colors.foreground,
                        ),
                      ),
                      trailing: Switch(
                        value: themeProvider.isDarkMode,
                        onChanged: (_) => themeProvider.toggleTheme(),
                        activeTrackColor: context.theme.colors.primary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Tentang',
                style: context.theme.typography.lg.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.theme.colors.foreground,
                ),
              ),
              const SizedBox(height: 12),

              FCard(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        color: context.theme.colors.foreground,
                      ),
                      title: Text(
                        'Tentang Aplikasi',
                        style: context.theme.typography.base.copyWith(
                          color: context.theme.colors.foreground,
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: context.theme.colors.mutedForeground,
                      ),
                      onTap: () => _showAboutDialog(context),
                    ),
                    Divider(height: 1, color: context.theme.colors.border),
                    ListTile(
                      leading: Icon(
                        Icons.help_outline,
                        color: context.theme.colors.foreground,
                      ),
                      title: Text(
                        'Bantuan',
                        style: context.theme.typography.base.copyWith(
                          color: context.theme.colors.foreground,
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: context.theme.colors.mutedForeground,
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Halaman bantuan akan segera hadir'),
                            backgroundColor: context.theme.colors.muted,
                          ),
                        );
                      },
                    ),
                    Divider(height: 1, color: context.theme.colors.border),
                    ListTile(
                      leading: Icon(
                        Icons.privacy_tip_outlined,
                        color: context.theme.colors.foreground,
                      ),
                      title: Text(
                        'Kebijakan Privasi',
                        style: context.theme.typography.base.copyWith(
                          color: context.theme.colors.foreground,
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: context.theme.colors.mutedForeground,
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Kebijakan privasi akan segera hadir',
                            ),
                            backgroundColor: context.theme.colors.muted,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              Center(
                child: Text(
                  'DompetKuy v1.0.0',
                  style: context.theme.typography.sm.copyWith(
                    color: context.theme.colors.mutedForeground,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: context.theme.colors.background,
        title: Text(
          'Tentang DompetKuy',
          style: context.theme.typography.lg.copyWith(
            fontWeight: FontWeight.w600,
            color: context.theme.colors.foreground,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DompetKuy adalah aplikasi pengelola keuangan pribadi yang membantu Anda mencatat transaksi dan mencapai target tabungan.',
              style: context.theme.typography.sm.copyWith(
                color: context.theme.colors.foreground,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Versi: 1.0.0',
              style: context.theme.typography.sm.copyWith(
                color: context.theme.colors.mutedForeground,
              ),
            ),
            Text(
              'Build: 1',
              style: context.theme.typography.sm.copyWith(
                color: context.theme.colors.mutedForeground,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Tutup',
              style: TextStyle(color: context.theme.colors.primary),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditAvatarSheet(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    final theme = context.theme;
    var tempConfig = userProvider.avatarConfig;
    final seedController = TextEditingController(text: tempConfig.seed);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.colors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (builderContext, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(builderContext).viewInsets.bottom + 24,
                top: 24,
                left: 20,
                right: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: AvatarPreview(config: tempConfig, size: 140)),
                    const SizedBox(height: 20),
                    Center(
                      child: TextButton.icon(
                        onPressed: () {
                          final newConfig = AvatarConfig.random();
                          seedController.text = newConfig.seed;
                          setState(() {
                            tempConfig = newConfig;
                          });
                        },
                        icon: const Icon(Icons.casino_outlined),
                        label: const Text('Acak Avatar'),
                        style: TextButton.styleFrom(
                          foregroundColor: theme.colors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Seed',
                      style: theme.typography.base.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colors.foreground,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: seedController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan seed untuk avatar',
                        hintStyle: TextStyle(
                          color: theme.colors.mutedForeground,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme.colors.border),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: theme.colors.primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: TextStyle(color: theme.colors.foreground),
                      onChanged: (value) {
                        setState(() {
                          tempConfig = tempConfig.copyWith(seed: value);
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Style Avatar',
                      style: theme.typography.base.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colors.foreground,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: DiceBearStyle.values.map((style) {
                        final isSelected = tempConfig.style == style;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              tempConfig = tempConfig.copyWith(style: style);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? theme.colors.primary
                                      .withValues(alpha: 0.15)
                                  : theme.colors.muted,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? theme.colors.primary
                                    : theme.colors.border,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Text(
                              style.displayName,
                              style: theme.typography.sm.copyWith(
                                color: isSelected
                                    ? theme.colors.primary
                                    : theme.colors.foreground,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              seedController.dispose();
                              Navigator.pop(builderContext);
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: theme.colors.mutedForeground,
                              side: BorderSide(color: theme.colors.border),
                            ),
                            child: const Text('Batal'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              await userProvider.updateAvatarConfig(tempConfig);
                              seedController.dispose();
                              if (builderContext.mounted) {
                                Navigator.pop(builderContext);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colors.primary,
                              foregroundColor: theme.colors.primaryForeground,
                            ),
                            child: const Text('Simpan'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
