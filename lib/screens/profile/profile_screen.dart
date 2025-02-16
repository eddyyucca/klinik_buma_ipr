import 'package:flutter/material.dart';
import 'package:klinik_buma_ipr/models/user.dart';
import 'package:klinik_buma_ipr/utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = User.dummy(); // Menggunakan data dummy untuk contoh

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit profile
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(user),
            _buildProfileMenu(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(User user) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingL),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[200],
            backgroundImage:
                user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
            child: user.photoUrl == null
                ? const Icon(Icons.person, size: 50, color: Colors.grey)
                : null,
          ),
          const SizedBox(height: AppSizes.paddingL),
          Text(
            user.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (user.phone != null) ...[
            const SizedBox(height: AppSizes.paddingS),
            Text(
              user.phone!,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ],
          const SizedBox(height: AppSizes.paddingS),
          Text(
            user.email,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      child: Column(
        children: [
          _buildSection(
            title: 'Informasi Kesehatan',
            children: [
              _buildMenuItem(
                icon: Icons.favorite,
                title: 'Golongan Darah',
                value: 'O+',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.height,
                title: 'Tinggi Badan',
                value: '175 cm',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.monitor_weight,
                title: 'Berat Badan',
                value: '70 kg',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingL),
          _buildSection(
            title: 'Pengaturan Akun',
            children: [
              _buildMenuItem(
                icon: Icons.notifications,
                title: 'Notifikasi',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.security,
                title: 'Keamanan',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.language,
                title: 'Bahasa',
                value: 'Indonesia',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingL),
          _buildSection(
            title: 'Lainnya',
            children: [
              _buildMenuItem(
                icon: Icons.help,
                title: 'Bantuan',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.info,
                title: 'Tentang Aplikasi',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.privacy_tip,
                title: 'Kebijakan Privasi',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingXL),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppSizes.paddingM,
            bottom: AppSizes.paddingS,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.zero,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? value,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null)
            Text(
              value,
              style: const TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
          const SizedBox(width: AppSizes.paddingS),
          const Icon(Icons.chevron_right, color: AppColors.textLight),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Keluar'),
              content: const Text('Apakah Anda yakin ingin keluar?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Batal'),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Implement logout
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Keluar',
                    style: TextStyle(color: AppColors.error),
                  ),
                ),
              ],
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.error,
          padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingM),
        ),
        child: const Text('Keluar'),
      ),
    );
  }
}
