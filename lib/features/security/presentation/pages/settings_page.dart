import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _buildSection(
            'Keamanan',
            [
              _buildSettingsTile(
                icon: Icons.lock,
                title: 'PIN Aplikasi',
                subtitle: 'Atur PIN untuk keamanan aplikasi',
                onTap: () => _showComingSoon(context, 'PIN Aplikasi'),
              ),
              _buildSettingsTile(
                icon: Icons.fingerprint,
                title: 'Biometrik',
                subtitle: 'Gunakan sidik jari atau Face ID',
                onTap: () => _showComingSoon(context, 'Biometrik'),
              ),
              _buildSettingsTile(
                icon: Icons.security,
                title: 'Enkripsi Data',
                subtitle: 'Status enkripsi: Aktif (AES-256)',
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Aktif',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          _buildSection(
            'Backup & Restore',
            [
              _buildSettingsTile(
                icon: Icons.backup,
                title: 'Backup Data',
                subtitle: 'Cadangkan data ke penyimpanan lokal',
                onTap: () => _showComingSoon(context, 'Backup Data'),
              ),
              _buildSettingsTile(
                icon: Icons.restore,
                title: 'Restore Data',
                subtitle: 'Pulihkan data dari backup',
                onTap: () => _showComingSoon(context, 'Restore Data'),
              ),
            ],
          ),
          _buildSection(
            'Aplikasi',
            [
              _buildSettingsTile(
                icon: Icons.notifications,
                title: 'Notifikasi',
                subtitle: 'Pengingat dokumen kadaluwarsa',
                onTap: () => _showComingSoon(context, 'Notifikasi'),
              ),
              _buildSettingsTile(
                icon: Icons.storage,
                title: 'Penyimpanan',
                subtitle: 'Kelola ruang penyimpanan',
                onTap: () => _showComingSoon(context, 'Penyimpanan'),
              ),
              _buildSettingsTile(
                icon: Icons.info,
                title: 'Tentang Aplikasi',
                subtitle: 'SakuDok v1.0.0',
                onTap: () => _showAboutDialog(context),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ),
        ...children,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature akan segera hadir!'),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'SakuDok',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(
        Icons.folder_special,
        size: 48,
      ),
      children: const [
        Text(
          'Brankas digital 100% offline untuk KTP, SIM, Ijazah, dan dokumen penting Anda.',
        ),
        SizedBox(height: 16),
        Text(
          'Data Anda aman dengan enkripsi AES-256 dan tidak pernah dikirim ke server manapun.',
        ),
      ],
    );
  }
}
