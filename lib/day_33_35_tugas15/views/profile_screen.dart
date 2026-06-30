import 'package:flutter/material.dart';
import 'package:ppkd_b6/constant/app_color.dart';
import 'package:ppkd_b6/day_33_35_tugas15/models/user_model.dart';
import 'package:ppkd_b6/day_33_35_tugas15/services/auth_service.dart';
import 'package:ppkd_b6/day_33_35_tugas15/services/dio_client2.dart';
import 'package:ppkd_b6/day_33_35_tugas15/services/token_storage.dart';
import 'package:ppkd_b6/day_33_35_tugas15/views/login_screen.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:ppkd_b6/day_33_35_tugas15/views/update_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final AuthService _authService;
  UserModel? _user;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _authService = AuthService(createDioClient());
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await _authService.getProfile();
      setState(() {
        _user = response.data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception:', '');
        _isLoading = false;
      });
    }
  }

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galeri'),
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Kamera'),
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    final pickedFile = await picker.pickImage(
      source: source,
      maxWidth: 500,
      maxHeight: 500,
      imageQuality: 80,
    );

    if (pickedFile == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final bytes = await pickedFile.readAsBytes();
      final base64String = base64Encode(bytes);
      final dataUrl = 'data:image/png;base64,$base64String';

      final response = await _authService.updateProfilePhoto({
        'profile_photo': dataUrl,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message ?? 'Foto profil berhasil diperbarui!'),
            backgroundColor: AppColor.primaryColor,
          ),
        );
      }
      await _loadProfile();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memperbarui foto profil: ${e.toString().replaceAll('Exception:', '')}'),
            backgroundColor: AppColor.redColor,
          ),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleLogout() async {
    await TokenStorage.clearToken();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColor.primaryColor;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Profil Pengguna', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined, color: Colors.white),
            onPressed: _handleLogout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline_outlined, size: 64, color: AppColor.redColor),
                        const SizedBox(height: 16),
                        Text(
                          'Gagal mengambil data profil:\n$_errorMessage',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _loadProfile,
                          style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                          child: const Text('Coba Lagi', style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: _handleLogout,
                          child: const Text('Kembali ke Login', style: TextStyle(color: AppColor.greyText2)),
                        ),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // User Avatar & Name Card
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: _pickAndUploadImage,
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundColor: primaryColor.withValues(alpha: 0.1),
                                      backgroundImage: _user?.profilePhoto != null && _user!.profilePhoto!.isNotEmpty
                                          ? NetworkImage(_user!.profilePhoto!)
                                          : null,
                                      child: _user?.profilePhoto == null || _user!.profilePhoto!.isEmpty
                                          ? Text(
                                              (_user?.name ?? 'U').substring(0, 1).toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 36,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            )
                                          : null,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.white, width: 2),
                                        ),
                                        child: const Icon(
                                          Icons.camera_alt,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _user?.name ?? 'Nama Pengguna',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.blackText,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _user?.email ?? 'email@example.com',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColor.greyText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // User details
                      const Text(
                        'Informasi Akun',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.blackText,
                        ),
                      ),
                      const SizedBox(height: 12),

                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.person_outline),
                              title: const Text('User ID'),
                              trailing: Text(
                                '${_user?.id ?? '-'}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Divider(height: 1),
                            ListTile(
                              leading: const Icon(Icons.email_outlined),
                              title: const Text('Email'),
                              trailing: Text(
                                _user?.email ?? '-',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Divider(height: 1),
                            ListTile(
                              leading: const Icon(Icons.calendar_today_outlined),
                              title: const Text('Bergabung Pada'),
                              trailing: Text(
                                _user?.createdAt != null
                                    ? '${_user!.createdAt!.day}/${_user!.createdAt!.month}/${_user!.createdAt!.year}'
                                    : '-',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Edit Profile Button
                      ElevatedButton.icon(
                        onPressed: () async {
                          final updated = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UpdateProfileScreen(currentName: _user?.name ?? ''),
                            ),
                          );
                          if (updated == true) {
                            _loadProfile();
                          }
                        },
                        icon: const Icon(Icons.edit_outlined),
                        label: const Text('Perbarui Nama Profil'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
