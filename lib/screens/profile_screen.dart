import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

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
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: context.theme.colors.muted,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: context.theme.colors.foreground,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Pengguna DompetKuy',
                      style: context.theme.typography.xl.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.theme.colors.foreground,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'user@dompetkuy.com',
                      style: context.theme.typography.sm.copyWith(
                        color: context.theme.colors.mutedForeground,
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
                        themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
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
                        activeColor: context.theme.colors.primary,
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: context.theme.colors.border,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.lock_outline,
                        color: context.theme.colors.foreground,
                      ),
                      title: Text(
                        'Keamanan',
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
                            content: Text('Fitur keamanan akan segera hadir'),
                            backgroundColor: context.theme.colors.muted,
                          ),
                        );
                      },
                    ),
                    Divider(
                      height: 1,
                      color: context.theme.colors.border,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.notifications_outlined,
                        color: context.theme.colors.foreground,
                      ),
                      title: Text(
                        'Notifikasi',
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
                            content: Text('Pengaturan notifikasi akan segera hadir'),
                            backgroundColor: context.theme.colors.muted,
                          ),
                        );
                      },
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
                    Divider(
                      height: 1,
                      color: context.theme.colors.border,
                    ),
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
                    Divider(
                      height: 1,
                      color: context.theme.colors.border,
                    ),
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
                            content: Text('Kebijakan privasi akan segera hadir'),
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
}
